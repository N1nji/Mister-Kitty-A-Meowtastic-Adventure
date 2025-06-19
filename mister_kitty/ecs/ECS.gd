extends Node


var entities: Array = []
var systems: Array = []

func _ready():
	# Register systems automaticamente
	register_system(preload("res://ecs/systems/ai_system.gd").new())
	register_system(preload("res://ecs/systems/animation_system.gd").new())
	register_system(preload("res://ecs/systems/health_system.gd").new())
	register_system(preload("res://ecs/systems/movement_system.gd").new())


func register_entity(entity: Node):
	if not entities.has(entity):
		entities.append(entity)
		
func register_system(system: Node):
	if not systems.has(system):
		systems.append(system)
		
func _process(delta):
	for system in systems:
		if system.has_method("process"):
			system.process(entities, delta)
		
