extends CharacterBody2D

const box_pieces = preload("res://prefabs/box_pieces.tscn")
const coin_instance = preload("res://prefabs/coin_rigid.tscn")

@onready var animation_player := $anim as AnimationPlayer
@onready var spawn_coin := $spawn_coin as Marker2D
@export var pieces : PackedStringArray
@export var hitpoints := 3
var impulse := 200


func break_sprite():
		for piece in pieces.size():
			var piece_instance = box_pieces.instantiate()
			get_parent().add_child(piece_instance)
			piece_instance.get_node("texture").texture = load(pieces[piece])
			piece_instance.global_position = global_position
			piece_instance.apply_impulse(Vector2(randi_range(-impulse, impulse), randi_range(-impulse, -impulse * 2)))
			queue_free()
			
func create_coin():
	var coin = coin_instance.instantiate()
	call_deferred("add_child", coin)  # Agora a moeda será adicionada de forma segura
	call_deferred("set_coin_position", coin)
func set_coin_position(coin):
	coin.global_position = spawn_coin.global_position
	coin.apply_impulse(Vector2(randi_range(-20, 20), -120))
