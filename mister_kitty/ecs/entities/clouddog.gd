extends CharacterBody2D

@onready var movement = $MovementComponent
@onready var ai = $AIComponent
@onready var texture: Sprite2D = $texture
@onready var health = $HealthComponent
@onready var detector: RayCast2D = $detector
@onready var detector_2: RayCast2D = $detector2
@onready var target = $"../mister_kitty"

func _ready():
	Ecs.register_entity(self)
	ai.target = $"../mister_kitty"
	ai.behavior = AI.BehaviorType.chase


func _physics_process(delta):
	# Movimento horizontal
	velocity.x = movement.direction.x * movement.speed

	# Gravidade
	velocity.y += 20 * delta

	# Pulo se for chase e estiver no chão
	if ai.behavior == AI.BehaviorType.chase and is_on_floor():
		velocity.y = movement.jump_strength
		
	# Virar sprite
	if movement.direction.x > 0:
		texture.flip_h = true
	elif movement.direction.x < 0:
		texture.flip_h = false

	move_and_slide()

		
		
