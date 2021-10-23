
function initBuffers() {
		
    // Cube Coordinates
	
	cubeVertexPositionBuffer = gl.createBuffer();
	gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexPositionBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
	cubeVertexPositionBuffer.itemSize = 3;
	cubeVertexPositionBuffer.numItems = vertices.length / 3;			
	
	// PLAYER COORDINATES
	playerVertexPositionBuffer = gl.createBuffer();
	gl.bindBuffer(gl.ARRAY_BUFFER, playerVertexPositionBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices_player), gl.STATIC_DRAW);
	playerVertexPositionBuffer.itemSize = 3;
	playerVertexPositionBuffer.numItems = vertices_player.length / 3;
	
	// Textures
		
    cubeVertexTextureCoordBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexTextureCoordBuffer);
 	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(textureCoords), gl.STATIC_DRAW);
    cubeVertexTextureCoordBuffer.itemSize = 2;
	cubeVertexTextureCoordBuffer.numItems = 24;

	playerVertexTextureCoordBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, playerVertexTextureCoordBuffer);
 	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(texturePlayerCoords), gl.STATIC_DRAW);
    playerVertexTextureCoordBuffer.itemSize = 2;
	playerVertexTextureCoordBuffer.numItems = 24;		

	// Vertex indices
	
    cubeVertexIndexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, cubeVertexIndexBuffer);
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(cubeVertexIndices), gl.STATIC_DRAW);
    cubeVertexIndexBuffer.itemSize = 1;
	cubeVertexIndexBuffer.numItems = 36;
	
	playerVertexIndexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, playerVertexIndexBuffer);
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(playerVertexIndices), gl.STATIC_DRAW);
    playerVertexIndexBuffer.itemSize = 1;
	playerVertexIndexBuffer.numItems = 24;
	
	
	setUpCube();
}

function setUpCube(){
    // Set up cube coordinate
	gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexPositionBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
	gl.vertexAttribPointer(shaderProgram.vertexPositionAttribute, cubeVertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0);
		
	gl.bindBuffer(gl.ARRAY_BUFFER, cubeVertexTextureCoordBuffer);
	gl.vertexAttribPointer(shaderProgram.textureCoordAttribute, cubeVertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0);

	gl.activeTexture(gl.TEXTURE0);
	gl.bindTexture(gl.TEXTURE_2D, webGLTextureWall);
			
	gl.uniform1i(shaderProgram.samplerUniform, 0);
		
	gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, cubeVertexIndexBuffer);

}

function setUpFloor(tile){

	if (tile == 0 || tile == 2 || tile == 1){
		gl.activeTexture(gl.TEXTURE0);
		gl.bindTexture(gl.TEXTURE_2D, webGLTextureFloor);
	}
	else{
		gl.activeTexture(gl.TEXTURE0);
		gl.bindTexture(gl.TEXTURE_2D, webGLTextureEND);
	}	
		
}

function setUpPlayer(){
	
	gl.bindBuffer(gl.ARRAY_BUFFER, playerVertexPositionBuffer);
	gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices_player), gl.STATIC_DRAW);
	gl.vertexAttribPointer(shaderProgram.vertexPositionAttribute, 
		playerVertexPositionBuffer.itemSize, 
		gl.FLOAT, false, 0, 0);

	gl.bindBuffer(gl.ARRAY_BUFFER, playerVertexTextureCoordBuffer);
	gl.vertexAttribPointer(shaderProgram.textureCoordAttribute, playerVertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0);
		
	gl.activeTexture(gl.TEXTURE0);
	gl.bindTexture(gl.TEXTURE_2D, webGLTexturePlayer);
	
	gl.uniform1i(shaderProgram.samplerUniform, 0);
		
	gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, playerVertexIndexBuffer);


}