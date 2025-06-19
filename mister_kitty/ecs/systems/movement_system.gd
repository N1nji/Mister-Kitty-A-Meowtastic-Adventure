extends Node

func process(entities: Array, delta: float) -> void:
	for entity in entities:
		var movement = entity.get_node_or_null("MovementComponent")
		if movement:
			entity.velocity.x = movement.direction.x * movement.speed
