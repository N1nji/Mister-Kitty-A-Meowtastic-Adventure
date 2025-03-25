extends Node

@onready var dialog_box_scene = preload("res://prefabs/dialog_box.tscn")
var message_lines : Array[String] = []
var current_line = 0

var dialog_box
var dialog_box_position := Vector2.ZERO

var is_message_active := false
var can_advance_message := false


func _ready():
	var area_sign := get_tree().root.find_child("area_sign", true, false) # Busca a área pelo nome
	if area_sign:
		area_sign.body_exited.connect(_on_area_sign_exited)


func start_message(position: Vector2, lines: Array[String]):
	if is_message_active:
		return
	
	message_lines = lines
	dialog_box_position = position
	current_line = 0  # 🔹 Reseta a linha para começar o diálogo certo
	show_text()
	is_message_active = true
	
func show_text():
	if dialog_box and is_instance_valid(dialog_box):
		dialog_box.queue_free()
		dialog_box = null  # Evita acessar um objeto já deletado
	dialog_box = dialog_box_scene.instantiate()
	dialog_box.text_display_finish.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	dialog_box.display_text(message_lines[current_line])
	can_advance_message = false
	
	
func _on_all_text_displayed():
	can_advance_message = true
	
func _unhandled_input(event):
	if (event.is_action_pressed("advance_message") or event.is_action_pressed("ui_touch") && is_message_active && can_advance_message):
		current_line += 1
		if current_line >= message_lines.size():
			is_message_active = false
			current_line = 0
			if dialog_box and is_instance_valid(dialog_box):
				dialog_box.call_deferred("queue_free")  # Chama a remoção de forma segura
				dialog_box = null
		else:
			show_text()	
		

func _on_area_sign_exited(_body: Node) -> void:
	if is_message_active:
		is_message_active = false
		current_line = 0
		can_advance_message = false
		if dialog_box and is_instance_valid(dialog_box):
			dialog_box.call_deferred("queue_free")
			dialog_box = null
