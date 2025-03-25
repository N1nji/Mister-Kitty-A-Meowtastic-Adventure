extends CharacterBody2D


const SPEED = 900.0
const JUMP_VELOCITY = -400.0
@export var enemy_life := 2

@onready var wall_detector := $wall_detector as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer

var direction := -1

var gravity = 1000

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1

	if direction == -1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	
	velocity.x = direction * SPEED * delta

	move_and_slide()




 
func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()
