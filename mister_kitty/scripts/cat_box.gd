extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $anim_cat
@onready var area_sign:= $area_sign as Area2D
@onready var label: Label = $Label

#@onready var area_sign:= get_node("/root/warning_sign")
# Called when the node enters the scene tree for the first time.
var is_in_area = false
var is_interacting = false  # Controle de interação

func _ready() -> void:
	anim.play("idle")
	



func _unhandled_input(event):
	if is_in_area and !is_interacting:
		if event.is_action_pressed("interact") or event.is_action_pressed("ui_touch"):
			label.visible = false
			is_interacting = true
			anim.play("interact")  # Toca animação de abrir a caixa
			await anim.animation_finished  # Espera a animação terminar
			DialogManager.is_message_active
			while DialogManager.is_message_active:
				anim.play("interacting")  # Gato fica nessa animação durante o diálogo
				await get_tree().process_frame
				if not DialogManager.is_message_active:
					anim.play("interact_finish")
					is_interacting = false





func _on_area_sign_body_entered(body: Node2D) -> void:
	anim.play("shake_cat")
	is_in_area = true
	label.visible = true
	label.text = "Pressione 'I' para interagir e 'O' para passar"
	print("entrou na area")


func _on_area_sign_body_exited(body: Node2D) -> void:
	is_in_area = false
	label.visible = false
	if anim.animation == "interact" or anim.animation == "interacting":
		anim.play("interact_finish")
	print("saiu da areá ok")

		
