extends Node2D

@onready var mister_kitty = get_node_or_null("/root/World-01/mister_kitty")
@onready var eyes = $"."  # Usa o nome correto do nó dos olhos
@export var follow_speed: float = 5.0  # Velocidade do movimento
@export var max_dist: float = 2.0  # Até onde os olhos podem se mover

var original_position: Vector2  # Posição inicial dos olhos

func _ready():
	original_position = eyes.position  # Salva onde os olhos começam

func _process(delta):
	if mister_kitty:
		var direction = (mister_kitty.global_position - eyes.global_position).normalized()
		var target_position = original_position + (direction * max_dist)

		# Suaviza o movimento dos olhos para não parecer robótico
		eyes.position = eyes.position.lerp(target_position, follow_speed * delta)
	
