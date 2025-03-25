extends Node2D

@onready var mister_kitty = get_node_or_null("/root/World-01/mister_kitty")  # Caminho absoluto
@export var follow_speed: float = 2.0  # Velocidade de seguimento
@export var offset: Vector2 = Vector2(50, 20)  # Posição relativa do Sol em relação ao player
@onready var anim: AnimationPlayer = $anim
@onready var texture: Sprite2D = $texturesun

@export var follow_player = false  # O sol começa parado
var is_area_sun = false
var is_interacting = true

func _ready() -> void:
	anim.play("raio")

func _process(delta):
	if follow_player and mister_kitty:
		var target_position = mister_kitty.position + offset  # Define a posição alvo com base no player
		position = position.lerp(target_position, follow_speed * delta)  # Movimenta suavemente
	if Input.is_action_pressed("advance_message") or Input.is_action_pressed("interact"):
		texture.hide()


func _on_area_sun_body_entered(body: Node2D) -> void:
		texture.show()
		if Input.is_action_pressed("advance_message") or Input.is_action_pressed("interact"):
			texture.hide()
			is_interacting = true
	


func _on_area_sun_body_exited(body: Node2D) -> void:
			follow_player = true
			texture.hide()
			
