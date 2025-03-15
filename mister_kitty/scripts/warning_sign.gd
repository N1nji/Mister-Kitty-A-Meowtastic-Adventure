extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_sign: Area2D = $area_sign

const lines : Array[String] = [
	"Olá caro aventureiro",
	"Obrigado por adquirir o meu jogo",
	"Espero que esteja preparado...",
	"para uma grande aventura :D"
]


func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") or event.is_action_pressed("ui_touch"):
			if !DialogManager.is_message_active:
				DialogManager.start_message(global_position, lines)
				
			else:
				DialogManager._unhandled_input(event)  # 🔹 Chama direto para forçar a passagem de diálogo
						
	else:
		texture.hide()
		if DialogManager.dialog_box and DialogManager.dialog_box.has_method("queue"):
			DialogManager.dialog_box.queue()
			DialogManager.is_message_active = false
