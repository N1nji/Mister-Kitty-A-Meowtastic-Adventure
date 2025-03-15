shader_type canvas_item; // Define que este é um shader para elementos 2D

//uniform float move_speed = 0.5; // Controla a velocidade do movimento da textura

void vertex() {
	 // Função chamada para cada vértice do objeto.
    // Não está sendo usada aqui, pois a transformação ocorre no fragment shader.
}

void fragment() {
	//COLOR = texture(TEXTURE, vec2(UV.x +  TIME * move_speed, UV.y));
	 // Define a cor do fragmento usando a textura.
    // A coordenada X da textura é deslocada ao longo do tempo para criar um efeito de movimento.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
