extends Node

@onready var anim: AnimatedSprite2D = $anim

func process(entities: Array, delta: float) -> void:
	for entity in entities:
		process_entity(entity, delta)

func process_entity(entity, delta):
	var ai = entity.get_node_or_null("AIComponent")
	var movement = entity.get_node_or_null("MovementComponent")
	#var animation = entity.get_node_or_null("AnimationComponent")
	var animation = entity.get_node_or_null("anim")  # Certo agora!

	
	if not ai or not movement:
		return

	match ai.behavior:
		AI.BehaviorType.idle:
			movement.direction = Vector2.ZERO
			if animation:
				animation.play("idle")

		AI.BehaviorType.patrol:
			if not entity.has_method("get_direction_from_patrol"): return
			movement.direction = entity.get_direction_from_patrol()
			if animation:
				animation.play("patrol")

		AI.BehaviorType.chase:
			if ai.target:
				var dir = (ai.target.global_position - entity.global_position).normalized()
				movement.direction = dir
				#entity.look_at(ai.target.global_position)
				if animation:
					animation.play("chase")
