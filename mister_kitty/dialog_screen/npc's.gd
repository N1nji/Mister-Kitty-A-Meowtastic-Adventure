extends Area2D
class_name NPC

@export_category("Dialog Settings")
@export var dialog_screen: PackedScene
@export var _hud: CanvasLayer
@export var npc_texxture: Texture2D

var player_in_area := false

@export var dialog_data: Dictionary = {
	0: {
		"title": "Gato Branco",
		"dialog": "Pode me ajudar?",
		"faceset": "res://dialog_screen_facesets/Chat_icon_mister_kitty.png"
	}
	
}

func _read():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _unhandled_input(event):
	if player_in_area and event.is_action_pressed("interact"):
		_show_dialog()
	
func _on_body_entered(body):
	if body.name == "mister_kitty":
		player_in_area = true
		print("entrou")
		
func _on_body_exited(body):
	if body.name == "mister_kitty":
		player_in_area = false
		
func _show_dialog():
	var dialog = dialog_screen.instantiate()
	dialog.data = dialog_data
	_hud.add_child(dialog)
