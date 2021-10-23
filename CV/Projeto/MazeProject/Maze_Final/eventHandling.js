
mousePressed = false;

function setEventListeners(canvas){


	canvas.onmousedown = onMouseDown;
    document.onmouseup = onMouseUp;
    document.onmousemove = onMouseMove;
	document.onwheel = onMouseWheel;
	// File loading
	
	// Adapted from:
	
	// http://stackoverflow.com/questions/23331546/how-to-use-javascript-to-read-local-text-file-and-read-line-by-line
	
	document.getElementById("file").onchange = function(){
		
		var file = this.files[0];
		
		var reader = new FileReader();
		
		reader.onload = function( progressEvent ){
			
			// Entire file read as a string
			
			// The tokens/values in the file
    
			// Separation between values is 1 or mode whitespaces
			var lines = this.result.split('\n');
			var newmaze = [];
			var newmaze_size = [0,0]
			var exception = false;
			var temp_start = [];
			var temp_finish = [];
			for(var line = 0; line < lines.length; line++){
				values = lines[line].split(/\s\s*/);
				var temp = [];
				for (i = 0; i< values.length; i++){
					
					if(values[i]!=0 && values[i]!=1 && values[i]!=2 && values[i]!=3 && values[i]!="" ) {
						exception = true;
					}
					else if(values[i]!=""){
						temp[i] = parseInt(values[i]);
						if(values[i] == 2){
							temp_start = [line,i];
						}
						else if(values[i] == 3){
							temp_finish = [line,i];
						}
					}
					
				}
				if(line > 0 && temp.length != newmaze[line-1].length){
					exception = true;
				}
				newmaze[line] = temp;
			}

			newmaze_size[0] = newmaze.length; 
			newmaze_size[1] = newmaze[0].length; 

			if(!exception){
				maze = newmaze;
				maze_size[0] = newmaze_size[0];
				maze_size[1] = newmaze_size[1];
				start[0] = temp_start[0];
				start[1] = temp_start[1];
				player_pos[0] = start[0];
				player_pos[1] = start[1];
				finish = temp_finish;

				toOutsideView();
				drawScene();
			} else{
				console.error("Invalid maze!");
				alert("Sorry! Your maze is invalid.");
			}
			
		};
		
		// Entire file read as a string
			
		reader.readAsText( file );		
	}   


	document.getElementById("reset-button").onclick = function(){
		
		player_pos[0] = start[0];
		player_pos[1] = start[1];
        if(playing){
            startPlaying();
        }else{
            drawScene();
        }

        
	};   
	document.getElementById("change-mode-button").onclick = function(){
		
		// The initial values
		if(playing){
			toOutsideView();
		}else{
			globalRotationXX_ON = 0;
			globalRotationYY_ON = 0;
			globalRotationZZ_ON = 0;
			startPlaying();
		}
	};
	
	document.getElementById("reset-view-button").onclick = function(){
		toOutsideView();
    };
    
    document.getElementById("move-left-button").onclick = function(){
		moveLeft();
    };  
    
    document.getElementById("move-right-button").onclick = function(){
		moveRight();
    }; 
    
    document.getElementById("move-up-button").onclick = function(){
		moveUp();
    }; 
    
    document.getElementById("move-down-button").onclick = function(){
		moveDown();
    }; 
    
    document.getElementById("move-back-button").onclick = function(){
		globalTz -= 0.1;
    }; 
    
    document.getElementById("move-front-button").onclick = function(){
		globalTz+= 0.1;
    }; 
    
    document.getElementById("XX-on-off-button").onclick = function(){
        if(globalRotationXX_ON){
            globalRotationXX_ON = 0;
        }
        else{
            globalRotationXX_ON = 1;
        }
    }; 
    document.getElementById("XX-direction-button").onclick = function(){
		if(globalRotationXX_DIR == 1){
            globalRotationXX_DIR = -1;
        }
        else{
            globalRotationXX_DIR = 1;
        }
    }; 
    document.getElementById("XX-slower-button").onclick = function(){
		globalRotationXX_SPEED *= 0.75;
    }; 
    document.getElementById("XX-faster-button").onclick = function(){
		globalRotationXX_SPEED *= 1.25;
    }; 
    document.getElementById("YY-on-off-button").onclick = function(){
		if(globalRotationYY_ON){
            globalRotationYY_ON = 0;
        }
        else{
            globalRotationYY_ON = 1;
        }
    }; 
    document.getElementById("YY-direction-button").onclick = function(){
		if(globalRotationYY_DIR == 1){
            globalRotationYY_DIR = -1;
        }
        else{
            globalRotationYY_DIR = 1;
        }
    }; 
    document.getElementById("YY-slower-button").onclick = function(){
		globalRotationYY_SPEED *= 0.75;
    }; 
    document.getElementById("YY-faster-button").onclick = function(){
		globalRotationYY_SPEED *= 1.25;
    }; 
    document.getElementById("ZZ-on-off-button").onclick = function(){
		if(globalRotationZZ_ON){
            globalRotationZZ_ON = 0;
        }
        else{
            globalRotationZZ_ON = 1;
        }
    }; 
    document.getElementById("ZZ-direction-button").onclick = function(){
		if(globalRotationZZ_DIR == 1){
            globalRotationZZ_DIR = -1;
        }
        else{
            globalRotationZZ_DIR = 1;
        }
    }; 
    document.getElementById("ZZ-slower-button").onclick = function(){
		globalRotationZZ_SPEED *= 0.75;
    }; 
    document.getElementById("ZZ-faster-button").onclick = function(){
		globalRotationZZ_SPEED *= 1.25;
	}; 
	
	document.getElementById("move-player-left-button").onclick = function(){
		moveLeft();
	};
	document.getElementById("move-player-right-button").onclick = function(){
		moveRight();
	};
	document.getElementById("move-player-up-button").onclick = function(){
		moveUp();
	};
	document.getElementById("move-player-down-button").onclick = function(){
		moveDown();
	};
	document.getElementById("rotate-player-right-button").onclick = function(){
		rotateRight();
	};
	document.getElementById("rotate-player-left-button").onclick = function(){
		rotateLeft();
    };
		
	
}
function onMouseDown(event){
	if(!playing){
		mousePressed = true;
		lastposX = event.clientX;

		lastposY = event.clientY;
	}
}

function onMouseUp(event){
	if(!playing){
		mousePressed = false;
	}
}

function onMouseWheel(event){
	if(!playing){
		if(event.deltaY>0){

			globalTz -= 0.05;
		}
		else if(event.deltaY<0){

			globalTz += 0.05;
		}
	}
}

function onMouseMove(event) {
	if(!playing){
		if (!mousePressed) {
			return;
		}

		var posX = event.clientX;
		var posY = event.clientY;

		var deltaX = posX - lastposX;
		var deltaY = posY - lastposY;

		globalAngleYY += deltaX * 0.5;
		globalAngleXX += deltaY * 0.5;

		lastposX = posX;
		lastposY = posY;
	}
}
function moveUp(){
	if(playing){
		z1 = Math.cos(radians(look_at))*0.01;
		x1 = Math.sin(radians(look_at))*0.01;
		

		z2 = Math.cos(radians(look_at+30))*0.01;
		x2 = Math.sin(radians(look_at+30))*0.01;

		z3 = Math.cos(radians(look_at-30))*0.01;
		x3 = Math.sin(radians(look_at-30))*0.01;
		if(!checkCollision(viewer_x,viewer_z,z1,x1) && !checkCollision(viewer_x,viewer_z,z2,x2) && !checkCollision(viewer_x,viewer_z,z3,x3)){
			executeMove(z1,x1);
		}
	}else{
		globalTy += 0.1;
	}
}

function moveDown(){
	if(playing){
		z = Math.cos(radians(look_at+180))*0.01;
		x = Math.sin(radians(look_at+180))*0.01;
					
		z1 = Math.cos(radians(look_at+180))*0.01;
		x1 = Math.sin(radians(look_at+180))*0.01;
					

		z2 = Math.cos(radians(look_at+210))*0.01;
		x2 = Math.sin(radians(look_at+210))*0.01;

		z3 = Math.cos(radians(look_at+150))*0.01;
		x3 = Math.sin(radians(look_at+150))*0.01;
		if(!checkCollision(viewer_x,viewer_z,z1,x1) && !checkCollision(viewer_x,viewer_z,z2,x2) && !checkCollision(viewer_x,viewer_z,z3,x3)){
			executeMove(z1,x1);
		}
	}else{
		globalTy -= 0.1;
	}
}

function moveLeft(){
	if(playing){
		z = Math.cos(radians(look_at+90))*0.01;
		x = Math.sin(radians(look_at+90))*0.01;

		z1 = Math.cos(radians(look_at+90))*0.01;
		x1 = Math.sin(radians(look_at+90))*0.01;
		

		z2 = Math.cos(radians(look_at+120))*0.01;
		x2 = Math.sin(radians(look_at+120))*0.01;

		z3 = Math.cos(radians(look_at+60))*0.01;
		x3 = Math.sin(radians(look_at+60))*0.01;
		if(!checkCollision(viewer_x,viewer_z,z1,x1) && !checkCollision(viewer_x,viewer_z,z2,x2) && !checkCollision(viewer_x,viewer_z,z3,x3)){
			executeMove(z1,x1);
		}
	}else{
		globalTx -= 0.1;
	}
}

function moveRight(){
	if(playing){
		z = Math.cos(radians(look_at-90))*0.01;
		x = Math.sin(radians(look_at-90))*0.01;

		z1 = Math.cos(radians(look_at-90))*0.01;
		x1 = Math.sin(radians(look_at-90))*0.01;
		

		z2 = Math.cos(radians(look_at-60))*0.01;
		x2 = Math.sin(radians(look_at-60))*0.01;

		z3 = Math.cos(radians(look_at-120))*0.01;
		x3 = Math.sin(radians(look_at-120))*0.01;
		if(!checkCollision(viewer_x,viewer_z,z1,x1) && !checkCollision(viewer_x,viewer_z,z2,x2) && !checkCollision(viewer_x,viewer_z,z3,x3)){
			executeMove(z1,x1);
		}
	}else{
		globalTx += 0.1;
	}
}

function rotateRight(){
	globalAngleYY += 4;
	look_at -=4;
}
function rotateLeft(){
	globalAngleYY -= 4;
	look_at +=4;
}

function initKeyboardCallback() {
    document.onkeydown = function(event) {
        switch(event.code) {
			case "ArrowUp": //Move towards where "camera" is looking
				moveUp();
				break;
			case "ArrowDown": //Move away from where "camera" is looking
				moveDown();
				break;
			case "ArrowLeft": //Move towards where "camera" is looking
				moveLeft();
				break;
			case "ArrowRight": //Move towards where "camera" is looking
				moveRight();
				break;
			
			case "KeyW": //Move towards where "camera" is looking
				moveUp();
                break;
			case "KeyS": //Move away from where "camera" is looking
				moveDown();
				break;
			case "KeyA": //Move towards where "camera" is looking
				moveLeft();
				break;
			case "KeyD": //Move towards where "camera" is looking
				moveRight();
                break;
			case "KeyQ": //Rotate "camera" left
				rotateLeft();
                break;
			case "KeyE": //Rotate "camera" right
				rotateRight();		
				break;
			case "KeyF":
				if(!playing){
					globalTz += 0.1;
				}
				break;
			case "KeyB":
				if(!playing){
					globalTz -= 0.1;
				}
				break;	
            default: return;
        }
    }
}