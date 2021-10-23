
function drawWalls(angleXX, angleYY, angleZZ, sx, sy, sz,tx, ty, tz,mvMatrix) {

	applyMvMatrix(angleXX, angleYY, angleZZ, sx, sy, sz,tx, ty, tz,mvMatrix);
	
	gl.drawElements(gl.TRIANGLES, cubeVertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0);
	gl.bindTexture(gl.TEXTURE_2D, null);
}

function drawFloor(angleXX, angleYY, angleZZ, sx, sy, sz,tx, ty, tz,mvMatrix) {
	
	applyMvMatrix(angleXX, angleYY, angleZZ, sx, sy, sz,tx, ty, tz,mvMatrix);

	gl.drawElements(gl.TRIANGLES, cubeVertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0);
	gl.bindTexture(gl.TEXTURE_2D, null);
}

function drawPlayer(angleXX, angleYY, angleZZ, sx, sy, sz,tx, ty, tz,mvMatrix){

	applyMvMatrix(angleXX, angleYY, angleZZ, sx, sy, sz,tx, ty, tz,mvMatrix);
	
	gl.drawElements(gl.TRIANGLES, playerVertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0);
	gl.bindTexture(gl.TEXTURE_2D, null);

}

function applyMvMatrix(angleXX, angleYY, angleZZ, 
    sx, sy, sz,
    tx, ty, tz,
    mvMatrix){
	
	mvMatrix = mult( mvMatrix, translationMatrix( tx, ty, tz ) );
	mvMatrix = mult( mvMatrix, rotationZZMatrix( angleZZ ) );
	mvMatrix = mult( mvMatrix, rotationYYMatrix( angleYY ) );
	mvMatrix = mult( mvMatrix, rotationXXMatrix( angleXX ) );
	mvMatrix = mult( mvMatrix, scalingMatrix( sx, sy, sz ) );
				
	// Passing the Model View Matrix to apply the current transformation
	var mvUniform = gl.getUniformLocation(shaderProgram, "uMVMatrix");
	gl.uniformMatrix4fv(mvUniform, false, new Float32Array(flatten(mvMatrix)));
}
