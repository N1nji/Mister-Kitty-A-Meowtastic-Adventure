extends Control
class_name dialogscreen

var _step: float = 0.05
var _id: int = 0
var data: Dictionary = {}

@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null

var is_text_displayed: bool = false  # Flag para controlar se o texto já foi totalmente exibido
var is_in_area = false

func _ready() -> void:
	_initialize_dialog()


func _process(_delta: float) -> void:
	# Se o jogador pressiona "O" (advance_message)
	if Input.is_action_just_pressed("advance_message"):
		if is_text_displayed:
			_advance_dialog()
		else:
			# Mostra o texto todo de uma vez se ainda estiver aparecendo
			_dialog.visible_characters = _dialog.text.length()
			is_text_displayed = true
 
func _initialize_dialog() -> void:
	# Carrega os dados do diálogo atual
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	_faceset.texture = load(data[_id]["faceset"])

	_dialog.visible_characters = 0
	is_text_displayed = false
	_display_text_step()

func _display_text_step() -> void:
	# Exibição gradual do texto
	while _dialog.visible_characters < _dialog.text.length():
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1

	# Quando o texto for completamente exibido, marca a flag como verdadeiro
	is_text_displayed = true

func _advance_dialog() -> void:
	# Avança para o próximo diálogo
	_id += 1

	if _id >= data.size():
		queue_free()  # Se não houver mais diálogos, fecha a janela
		return
	
	_initialize_dialog()  # Inicia o próximo diálogo
