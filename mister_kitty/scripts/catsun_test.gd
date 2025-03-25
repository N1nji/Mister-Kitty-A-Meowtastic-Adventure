extends Node2D

@onready var mister_kitty = get_node_or_null("/root/World-01/mister_kitty")  # Caminho absoluto
@export var follow_speed: float = 2.0  # Velocidade de seguimento
@export var offset: Vector2 = Vector2(70, 200)  # Posição relativa do Sol em relação ao player


func _process(delta):
	if mister_kitty:
		var target_position = mister_kitty.position + offset  # Define a posição alvo com base no player
		position = position.lerp(target_position, follow_speed * delta)  # Movimenta suavemente
