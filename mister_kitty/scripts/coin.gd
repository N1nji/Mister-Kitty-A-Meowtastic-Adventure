extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("Moeda coletada por: ", body.name)
	$anim.play("collect")


func _on_anim_animation_finished() -> void:
	print("Animação de coleta concluída, removendo a moeda.")
	queue_free()
