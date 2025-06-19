extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $anim_cat
@onready var area_sign:= $area_sign as Area2D
@onready var label: Label = $Label

#@onready var area_sign:= get_node("/root/warning_sign")
# Called when the node enters the scene tree for the first time.
var is_in_area = false
var is_interacting = false  # Controle de interação

# Inicia o jogo com a animção do catbox parado
func _ready() -> void:
	anim.play("idle")

func _process(_delta):
	# Se terminou o diálogo, reseta tudo
	if is_interacting and !DialogManager.is_message_active:
		is_interacting = false
		anim.play("interact_finish")

func _unhandled_input(event):
	if is_in_area and !is_interacting:
		if event.is_action_pressed("interact") or event.is_action_pressed("ui_touch"):
			print("chamando3")
			label.visible = false
			is_interacting = true
			DialogManager.current_source_node = self
			anim.play("interact")  # Toca animação de abrir a caixa
			await anim.animation_finished  # Espera a animação terminar
			DialogManager.is_message_active
			while DialogManager.is_message_active:
				anim.play("interacting")  # Gato fica nessa animação durante o diálogo
				await get_tree().process_frame
				if not DialogManager.is_message_active:
					anim.play("interact_finish")
					is_interacting = false
					
# Animção do catbox ao detectar o player dentro da área
func _on_area_sign_body_entered(body: Node2D) -> void:
	anim.play("shake_cat")
	is_in_area = true
	label.visible = true
	label.text = "Pressione 'I' para interagir e 'O' para passar"
	print("entrou na area")

# Animção do catbox fechando quando o player sai da área
func _on_area_sign_body_exited(body: Node2D) -> void:
	is_in_area = false
	label.visible = false

	# Se estava interagindo, interrompe forçadamente
	if is_interacting:
		is_interacting = false
		anim.play("interact_finish")

		# Se tiver uma DialogBox ativa, remove
		if DialogManager.dialog_box and is_instance_valid(DialogManager.dialog_box):
			DialogManager.dialog_box.queue_free()
			DialogManager.dialog_box = null
			DialogManager.is_message_active = false
	else:
		anim.play("idle")
