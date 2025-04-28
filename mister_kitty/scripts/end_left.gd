extends StaticBody2D

@export var limit_x: float = 100
@onready var push_force = Vector2(200, 0) # exemplo: empurra pra esquerda

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Função temporaria para impedir o player de passar da área  do jogo
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#body.apply_push(push_force)
	#if body is CharacterBody2D:
		#body.position.x = lerp(body.position.x, limit_x, 0.3)
