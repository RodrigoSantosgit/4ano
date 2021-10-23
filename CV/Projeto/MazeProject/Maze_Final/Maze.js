

//----------------------------------------------------------------------------
//
// Global Variables

var maze = [[1, 1, 1, 1, 1],
			[0, 1, 0, 0, 1], 
			[2, 0, 0, 1, 1],
			[0, 1, 0, 0, 3],
			[1, 1, 1, 1, 1],
			];

var maze_size = [5,5];
var start = [2,0];
var finish = [3,4];
var player_pos = [2,0];
var viewer_x = 0;
var viewer_z = 0;
var playing = true;


var gl = null; // WebGL context

var shaderProgram = null;
var cubeVertexPositionBuffer = null;
var cubeVertexIndexBuffer = null;
var cubeVertexTextureCoordBuffer = null;
var playerVertexPositionBuffer = null;
var playerVertexColorBuffer = null;
var playerVertexTextureCoordBuffer = null;
var playerVertexIndexBuffer = null;

var pos_Viewer = [ 0.0, 0.0, 0.0, 1.0 ];
var look_at = 0;
// The GLOBAL transformation parameters

var globalAngleXX = 0;
var globalAngleYY = 0;
var lastGlobalAngleYY = 0;
var globalAngleZZ = 0;

var globalTx = 0.0;
var globalTy = 0.0;
var globalTz = 0.0;
var globalTzVariation = 0;

// The local transformation parameters

// The translation vector
var tx = 0.0;
var ty = 0.0;
var tz = 0.0;

// The rotation angles in degrees
var angleXX = 0.0;
var angleYY = 0.0;
var angleZZ = 0.0;

// The scaling factors
var sx = 0.5;
var sy = 0.5;
var sz = 0.5;

var globalRotationXX_ON = 0;
var globalRotationXX_DIR = 1;
var globalRotationXX_SPEED = 1;
var globalRotationYY_ON = 0;
var globalRotationYY_DIR = 1;
var globalRotationYY_SPEED = 1;
var globalRotationZZ_ON = 0;
var globalRotationZZ_DIR = 1;
var globalRotationZZ_SPEED = 1;

vertices = [
            // Front face
            -0.25, -0.25,  0.25,
             0.25, -0.25,  0.25,
             0.25,  0.25,  0.25,
            -0.25,  0.25,  0.25,

            // Back face
            -0.25, -0.25, -0.25,
            -0.25,  0.25, -0.25,
             0.25,  0.25, -0.25,
             0.25, -0.25, -0.25,

            // Top face
            -0.25,  0.25, -0.25,
            -0.25,  0.25,  0.25,
             0.25,  0.25,  0.25,
             0.25,  0.25, -0.25,

            // Bottom face
            -0.25, -0.25, -0.25,
             0.25, -0.25, -0.25,
             0.25, -0.25,  0.25,
            -0.25, -0.25,  0.25,

            // Right face
             0.25, -0.25, -0.25,
             0.25,  0.25, -0.25,
             0.25,  0.25,  0.25,
             0.25, -0.25,  0.25,

            // Left face
            -0.25, -0.25, -0.25,
            -0.25, -0.25,  0.25,
            -0.25,  0.25,  0.25,
            -0.25,  0.25, -0.25
];

var textureCoords = [
          // Front face
          0.0, 0.0,
          1.0, 0.0,
          1.0, 1.0,
          0.0, 1.0,
          // Back face
          1.0, 0.0,
          1.0, 1.0,
          0.0, 1.0,
          0.0, 0.0,
          // Top face
          0.0, 1.0,
          0.0, 0.0,
          1.0, 0.0,
          1.0, 1.0,
          // Bottom face
          1.0, 1.0,
          0.0, 1.0,
          0.0, 0.0,
          1.0, 0.0,
          // Right face
          1.0, 0.0,
          1.0, 1.0,
          0.0, 1.0,
          0.0, 0.0,
          // Left face
          0.0, 0.0,
          1.0, 0.0,
          1.0, 1.0,
          0.0, 1.0,
];

var cubeVertexIndices = [

            0, 1, 2,      0, 2, 3,    // Front face
            4, 5, 6,      4, 6, 7,    // Back face
            8, 9, 10,     8, 10, 11,  // Top face
            12, 13, 14,   12, 14, 15, // Bottom face
            16, 17, 18,   16, 18, 19, // Right face
            20, 21, 22,   20, 22, 23  // Left face
];

var texturePlayerCoords = [
          // Back Top
          0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,
          
          // Back Down
		  0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,
		  
		  //Front Top
          0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,

		  // Front Down
          0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,
          
		  //Left Top
          0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,
		  
		  //Left Down
          0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,
		  
		  //Right Top
          0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,
		  
		  //Right Down
          0.0, 0.0,
          1.0, 0.0,
          0.0, 1.0,
];
var vertices_player = [
			//BACK & TOP
			-0.25, 0, -0.25,
			 0   , 0.25,  0,
			 0.25, 0, -0.25,
			//BACK & DOWN
			-0.25, 0, -0.25,
			 0.25, 0, -0.25,
			 0   , -0.25, 0,
			//FRONT & TOP FACE
			-0.25, 0,  0.25,
			 0.25, 0,  0.25,
			 0   , 0.25,  0,
			//FRONT & DOWN
			-0.25, 0,  0.25,
			 0   , -0.25, 0,
			 0.25, 0,  0.25,
			//LEFT & TOP
			-0.25, 0,  0.25,
			 0   , 0.25,  0,
			-0.25, 0, -0.25,
			//LEFT & DOWN
			-0.25,  0,  0.25,
			-0.25,  0, -0.25,
			 0   , -0.25,  0,
			//RIGHT & TOP
			 0.25,  0,  0.25,
			 0.25,  0, -0.25,
			 0   ,  0.25,  0,
			//RIGHT & DOWN
			 0.25,  0,  0.25,
			 0   , -0.25,  0,
			 0.25,  0, -0.25
];

var playerVertexIndices = [

            0, 1, 2,    3, 4, 5,       
			6, 7, 8, 	9, 10, 11, 
			12, 13, 14, 15, 16, 17, 
			18, 19, 20,	21, 22, 23 
];


//----------------------------------------------------------------------------
//
// The WebGL code
//

//----------------------------------------------------------------------------


//----------------------------------------------------------------------------

function handleLoadedTexture(texture,image) {
	
	gl.bindTexture(gl.TEXTURE_2D, texture);
	gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
	gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, texture.image);
	if(isPowerOf2(image.width) && isPowerOf2(image.height)){
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.NEAREST);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.NEAREST);
	}else{
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
       	gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);
       	gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
		
	}
	gl.bindTexture(gl.TEXTURE_2D, null);
}

function requestCORSIfNotSameOrigin(img, url) {
    if ((new URL(url, window.location.href)).origin !== window.location.origin) {
      img.crossOrigin = "";
    }
}

var webGLTextureWall;
var webGLTextureFloor;
var webGLTexturePlayer;
var webGLTextureEND;

function initTexture() {
	
	webGLTextureWall = gl.createTexture();
	webGLTextureWall.image = new Image();
	requestCORSIfNotSameOrigin(webGLTextureWall.image, "https://i.imgur.com/NvRa2BI.jpg?1");
	webGLTextureWall.image.onload = function () {
		handleLoadedTexture(webGLTextureWall,webGLTextureWall.image);
	}

	webGLTextureWall.image.src = "https://i.imgur.com/NvRa2BI.jpg?1";
	
	webGLTextureFloor = gl.createTexture();
	webGLTextureFloor.image = new Image();
	requestCORSIfNotSameOrigin(webGLTextureFloor.image, "https://i.imgur.com/hcqIIWY.png");
	webGLTextureFloor.image.onload = function () {
		handleLoadedTexture(webGLTextureFloor,webGLTextureFloor.image);
	}

	webGLTextureFloor.image.src = "https://i.imgur.com/hcqIIWY.png";

	webGLTexturePlayer = gl.createTexture();
	webGLTexturePlayer.image = new Image();
	requestCORSIfNotSameOrigin(webGLTexturePlayer.image, "https://live.staticflickr.com/3941/15562266021_77f1ed2562_k.jpg");
	webGLTexturePlayer.image.onload = function () {
		handleLoadedTexture(webGLTexturePlayer,webGLTexturePlayer.image);
	}

	webGLTexturePlayer.image.src = "https://live.staticflickr.com/3941/15562266021_77f1ed2562_k.jpg";
	
	webGLTextureEND = gl.createTexture();
	webGLTextureEND.image = new Image();
	requestCORSIfNotSameOrigin(webGLTextureEND.image, "https://i.imgur.com/eucAMTA.jpeg");
	webGLTextureEND.image.onload = function () {
		handleLoadedTexture(webGLTextureEND,webGLTextureEND.image);
	}

	webGLTextureEND.image.src = "https://i.imgur.com/eucAMTA.jpeg";
}

function isPowerOf2(value) {
	return (value & (value - 1)) == 0;
}

function checkIfWin(v_x, v_z){

	line = Math.floor(v_z/0.25);
	column = Math.floor(v_x/0.25);
	
	if(maze[line][column]==3){
		playing=false;
		alert("Congratulations! You won!");
		toOutsideView();
		document.getElementById("change-mode-button").textContent = "Play";
	}
}

function checkCollision( v_x,v_z,z,x){
	
	n = 7;
	test_z = v_z - z;
	line = Math.floor(v_z/0.25);
	nextline = line;
	if(test_z > v_z){
		for(i = n; i >= 0; i--){
			nextline = Math.floor((test_z+(0.01*i))/0.25);
			if(nextline!=line){
				break;
			}
		}
	}else if(v_z > test_z){
		for(i = n; i >= 0; i--){
			nextline = Math.floor((test_z-(0.01*i))/0.25);
			if(nextline!=line){
				break;
			}
		}
	}
	
	test_x = v_x - x;
	column = Math.floor(v_x/0.25);
	nextColumn = column;

	if(test_x > v_x){
		for(i = n; i >= 0; i--){
			nextColumn = Math.floor((test_x+(0.01*i))/0.25);
			if(nextColumn!=column){
				break
			}
		}
	}else if(v_x > test_x){
		for(i = n; i >= 0; i--){
			nextColumn = Math.floor((test_x-(0.01*i))/0.25);
			if(nextColumn!=column){
				break;
			}
		}
	}
	if(!(nextColumn < 0 || nextColumn > maze_size[1] || nextline < 0 || nextline > maze_size[0])){
		if(!(maze[nextline][nextColumn]==1 || maze[nextline][nextColumn]==1)){
			return false;
		}
	}
	return true;

}

function executeMove(z1,x1){
	globalTz+= z1;
	viewer_z-= z1;
	globalTx+= x1;
	viewer_x-= x1;
	console.log(look_at);
	player_pos[1] = Math.floor(viewer_x/0.25);
	player_pos[0] = Math.floor(viewer_z/0.25);
}

//  Drawing the 3D scene

function drawScene() {
	
	var pMatrix;
	
	var mvMatrix = mat4();
	
	gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
		
	pMatrix = perspective( 55, 1, 0.05, 15 );
	
	// Passing the Projection Matrix to apply the current projection
	if(playing){
		mvMatrix = mult(rotationYYMatrix(globalAngleYY),
							rotationXXMatrix(globalAngleXX));

		mvMatrix = mult(mvMatrix, rotationZZMatrix(globalAngleZZ))
		mvMatrix = mult(mvMatrix, translationMatrix( globalTx, globalTy, globalTz+globalTzVariation ));
	}else{
		mvMatrix =mult( translationMatrix(globalTx,globalTy,globalTz ), rotationYYMatrix(globalAngleYY));
		
		mvMatrix = mult(mvMatrix, rotationZZMatrix(globalAngleZZ))
		mvMatrix = mult(mvMatrix, rotationXXMatrix(globalAngleXX))
	}
	var pUniform = gl.getUniformLocation(shaderProgram, "uPMatrix");
	gl.uniformMatrix4fv(pUniform, false, new Float32Array(flatten(pMatrix)));
	gl.uniform4fv( gl.getUniformLocation(shaderProgram, "viewerPosition"), flatten(pos_Viewer) );

	for (i = 0; i < maze_size[0]; i++){
		for(j = 0; j < maze_size[1]; j++){
			if (maze[i][j] == 1){
				
				drawWalls(angleXX, angleYY, angleZZ, 
					sx, sy, sz,
					tx + j * 0.25, ty, tz + i * 0.25,
					mvMatrix);
				
			}else if(player_pos[0] == i && player_pos[1] == j && !playing){
				setUpPlayer();
				drawPlayer(angleXX, angleYY, angleZZ, 
					sx * 0.5, sy * 0.5, sz * 0.5,
					tx + j * 0.25, ty , tz + i * 0.25,
					mvMatrix);
				setUpCube();
			}
			setUpFloor(maze[i][j]);
			drawFloor(angleXX, angleYY, angleZZ, 
				sx, sy*0.25, sz,
				tx + j * 0.25, ty-0.155, tz + i * 0.25,
				mvMatrix);
			setUpCube();
		}
	}

	
}

//----------------------------------------------------------------------------
//
//  NEW --- Animation
//

var lastTime = 0;

function animate() {
	
	var timeNow = new Date().getTime();
	if( lastTime != 0 ) {
		
		var elapsed = timeNow - lastTime;
		
		// Global rotation
		if( globalRotationXX_ON ) {

			globalAngleXX += globalRotationXX_DIR * globalRotationXX_SPEED * (90 * elapsed) / 1000.0;
		}
		
		if( globalRotationZZ_ON ) {

			globalAngleZZ += globalRotationZZ_DIR * globalRotationZZ_SPEED * (90 * elapsed) / 1000.0;
	    }

		if( globalRotationYY_ON ) {

			globalAngleYY += globalRotationYY_DIR * globalRotationYY_SPEED * (90 * elapsed) / 1000.0;
	    }
	}
	
	lastTime = timeNow;
}

//----------------------------------------------------------------------------

// Timer

function tick() {
	
	requestAnimFrame(tick);
	animate();
	drawScene();
	
	if(playing){
		checkIfWin(viewer_x, viewer_z);
	}
}




//----------------------------------------------------------------------------
//
//  User Interaction
//

function outputInfos(){
    
}

//----------------------------------------------------------------------------


function startPlaying(){
	tx= 0;
	tz= 0;
	globalTy = 0;
	globalTx = -(player_pos[1] * 0.25);
	globalTz = -(player_pos[0] * 0.25);
	viewer_x = -globalTx + 0.125; 
	viewer_z = -globalTz + 0.125;
	
	globalAngleXX = 0;
	globalAngleZZ = 0;
	console.log(player_pos[0] == start[0] && player_pos[1] == start[1]);
	if(player_pos[0] == start[0] && player_pos[1] == start[1]){
		console.log
		if(start[0] > 0 && maze[start[0]-1][start[1]] == 0){
			look_at = 0;
			globalAngleYY = 0;
		}else if (start[0] < maze_size[0] - 1 && maze[start[0]+1][start[1]] == 0){
			look_at = 180;
			globalAngleYY = 180;
		}else if (start[1] > 0 && maze[start[0]][start[1]-1] == 0){
			look_at = 90;
			globalAngleYY = -90;
		}else if(start[1] < maze_size[1] - 1 && maze[start[0]][start[1]+1] == 0){
			look_at = -90;
			globalAngleYY = 90;
		}
	}else{
		globalAngleYY = lastGlobalAngleYY;
	}
	playing = true;
	enableDisableButtons(true);
	document.getElementById("change-mode-button").textContent = "To outside view";
	drawScene();
}

function toOutsideView(){

	playing = false;
	globalTz = -3.5;
	globalTx = 0;
	globalTy = 0.0;
	tx= -((maze_size[1]-1)*0.25)/2;
	tz= -((maze_size[0]-1)*0.25)/2;
	lastGlobalAngleYY = globalAngleYY;
	globalAngleXX = 90;
	globalAngleYY = 0;
	globalAngleZZ = 0;
	enableDisableButtons(false);
	document.getElementById("change-mode-button").textContent = "Play";
	drawScene();
}

function enableDisableButtons(bool){
	document.getElementById("reset-view-button").disabled = bool;
	document.getElementById("XX-on-off-button").disabled = bool;
	document.getElementById("YY-on-off-button").disabled = bool;
	document.getElementById("ZZ-on-off-button").disabled = bool;
	document.getElementById("XX-direction-button").disabled = bool;
	document.getElementById("YY-direction-button").disabled = bool;
	document.getElementById("ZZ-direction-button").disabled = bool;
	document.getElementById("XX-slower-button").disabled = bool;
	document.getElementById("YY-slower-button").disabled = bool;
	document.getElementById("ZZ-slower-button").disabled = bool;
	document.getElementById("XX-faster-button").disabled = bool;
	document.getElementById("YY-faster-button").disabled = bool;
	document.getElementById("ZZ-faster-button").disabled = bool;
	document.getElementById("move-left-button").disabled = bool;
	document.getElementById("move-right-button").disabled = bool;
	document.getElementById("move-front-button").disabled = bool;
	document.getElementById("move-back-button").disabled = bool;
	document.getElementById("move-up-button").disabled = bool;
	document.getElementById("move-down-button").disabled = bool;
	document.getElementById("move-player-left-button").disabled = !bool;
	document.getElementById("move-player-right-button").disabled = !bool;
	document.getElementById("move-player-up-button").disabled = !bool;
	document.getElementById("move-player-down-button").disabled = !bool;
	document.getElementById("rotate-player-left-button").disabled = !bool;
	document.getElementById("rotate-player-right-button").disabled = !bool;
}
//----------------------------------------------------------------------------
//
// WebGL Initialization
//

function initWebGL( canvas ) {
	try {
		
		
		gl = canvas.getContext("webgl") || canvas.getContext("experimental-webgl");
		
		gl.enable( gl.CULL_FACE );

		gl.enable( gl.DEPTH_TEST );
		
		//gl.cullFace( gl.BACK );
        
	} catch (e) {
	}
	if (!gl) {
		alert("Could not initialise WebGL, sorry! :-(");
	}        
}

//----------------------------------------------------------------------------

function runWebGL() {
	//startPlaying();
	initKeyboardCallback();
	var canvas = document.getElementById("my-canvas");
	initWebGL( canvas );
	shaderProgram = initShaders( gl );
	setEventListeners(canvas);
	initBuffers();
	initTexture();
	toOutsideView();
	tick();
	outputInfos();
}


