extends Node

func process(entities: Array, delta: float) -> void:
	for entity in entities:
		var health = entity.get_node_or_null("HealthComponent")
		if health:
			if health.hp <= 0:
				entity.queue_free()
