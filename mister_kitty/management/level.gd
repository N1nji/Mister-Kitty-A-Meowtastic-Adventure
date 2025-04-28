extends Node2D
class_name level

@onready var area_sun: Area2D = $"../BG/cat_sun/sun/area_sun"
@onready var collision: CollisionShape2D = $"../BG/cat_sun/sun/area_sun/collision"


const _DIALOG_SCREEN: PackedScene = preload("res://dialog_screen/dialog_screen.tscn")

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://dialog_screen_facesets/chat_icon_sun_cat3.png",
		"dialog": "Olá, você parece ser novo aqui!",
		"title": "Cat Sun"
	},
	
	1: {
		"faceset": "res://dialog_screen_facesets/chat_icon_sun_cat3.png",
		"dialog": "Sei que deve estar se perguntando... do porque um sol a noite",
		"title": "Cat Sun"
	},

	2: {
		"faceset": "res://dialog_screen_facesets/chat_icon_sun_cat3.png",
		"dialog": "E a resposta para isso é... eu e a lua trocamos de turno!",
		"title": "Cat Sun"
	},
	
	3: {
		"faceset": "res://dialog_screen_facesets/Chat_icon_mister_kitty.png",
		"dialog": "Miau!",
		"title": "Mister Kitty"
	},


}


@export_category("Objects")
@export var _hud: CanvasLayer = null

var is_dialog_active: bool = false  # Flag para controlar se o diálogo já foi ativado

# Func teste que não deu certo >:(
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("interact") and !is_dialog_active:  # Ativa o diálogo com 'I' (interagir)
		#is_dialog_active = true
		#var _new_dialog: dialogscreen = _DIALOG_SCREEN.instantiate()
		#_new_dialog.data = _dialog_data
		#_hud.add_child(_new_dialog)
		
var player_in_area = false  # Variável pra saber se o player tá dentro da área

func _ready():
	# Conectando os sinais da área do sol
	area_sun.body_entered.connect(_on_area_sun_body_entered)
	area_sun.body_exited.connect(_on_area_sun_body_exited)
	
func _input(event):
	# Só inicia o diálogo se o player estiver na área e apertar "interact"
	if player_in_area and event.is_action_pressed("interact"):
		start_dialog()

# Inicia o dialoog apenas se o player estiver na area
func start_dialog():
	var _new_dialog: dialogscreen = _DIALOG_SCREEN.instantiate()
	_new_dialog.data = _dialog_data
	_hud.add_child(_new_dialog)
	
	var sun = get_node_or_null("/root/World-01/BG/cat_sun/sun")
	if sun:
		sun.follow_player = true

# Método chamado quando o player entra na área
func _on_area_sun_body_entered(body):
	if body.name == "mister_kitty":  # Garante que é o player
		player_in_area = true
		print("Player entrou na área do sol!")

# Método chamado quando o player sai da área
func _on_area_sun_body_exited(body):
	if body.name == "mister_kitty":  # Garante que é o player
		player_in_area = false
		print("Player saiu da área do sol!")
