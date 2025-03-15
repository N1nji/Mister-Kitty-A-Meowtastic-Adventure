extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "mister_kitty":
		body.velocity.y = body.JUMP_FORCE
		owner.anim.play("hurt")
		
