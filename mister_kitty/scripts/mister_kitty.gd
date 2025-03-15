extends CharacterBody2D


const SPEED = 170.0
const JUMP_FORCE = -400.0

var gravity = 1000
var is_jumping := false
var is_hurted := false
var is_dead := false
var mister_kitty_life := 7
var knockback_vector := Vector2.ZERO
var direction


@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D

func _physics_process(delta: float) -> void:
	#Impede o Player de se mover quando morrer (antes estava sendo possível andar enquanto a animação
	#rodava
	if is_dead:
		velocity = Vector2.ZERO  # Para o movimento
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Obtém a direção do movimento com base nas teclas pressionadas (esquerda/direita)
	direction = Input.get_axis("ui_left", "ui_right")
	
	# Se houver entrada (tecla pressionada), define a velocidade na direção escolhida
	if direction != 0:
		velocity.x = direction * SPEED # Ajusta a velocidade com base na direção
		animation.scale.x = direction # Espelha o sprite dependendo do lado que o personagem está indo
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Se houver um impacto (knockback), aplica essa força ao movimento
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector # Define a velocidade como o vetor de impacto
	
	_set_state()
	move_and_slide()

	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
		



func _on_hurtbox_body_entered(body: Node2D) -> void:
# if body.is_in_group("enemies"):
		#queue_free()
	if mister_kitty_life < 0:
		is_dead = true
		animation.play("death")
		await animation.animation_finished
		queue_free()
	else:
		if $ray_right.is_colliding():
			take_damage(Vector2(-200, -200))
		elif $ray_left.is_colliding():
			take_damage(Vector2(200, -200))
			
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	mister_kitty_life -= 1
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		
		is_hurted = true
		await get_tree().create_timer(.3).timeout
		is_hurted = false 
		
func _set_state(): 
	var state ="idle"
	
	if mister_kitty_life < 0:
		state = "death"
	
	if !is_on_floor(): #if is_on_floor == false
		if velocity.y > 0:  # Está caindo
			state = "fall"
		else:
			state = "jump"
	elif direction != 0:
		state = "run"
		
	if is_hurted:
		state = "hurt"
		
	if animation.name != state:
		animation.play(state)

func _on_head_collider_body_entered(body: Node2D) -> void:
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
		else:
			body.animation_player.play("hit")
			body.create_coin()
