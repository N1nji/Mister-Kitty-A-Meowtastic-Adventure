extends Area2D

@export var enemy_life := 2
@onready var anim := $"../anim"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "mister_kitty":
		body.velocity.y = body.JUMP_FORCE
		owner.anim.play("hurt")
		await anim.animation_finished
		anim.play("walk")
		enemy_life -= 1
		if enemy_life < 0:
			anim.play("death")
		
