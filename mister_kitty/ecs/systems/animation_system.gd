extends Node


func process(entities: Array, delta: float) -> void:
	for entity in entities:
		var ai = entity.get_node_or_null("AIComponent")
		var animation_player = entity.get_node_or_null("anim")
		
		if not ai or not animation_player:
			continue
			
			match ai.behavior:
				AI.BehaviorType.chase:
					animation_player.play("chase")
				AI.BehaviorType.idle:
					animation_player.play("idle")
				AI.BehaviorType.patrol:
					animation_player.play("patrol")
		
