extends Node2D

@onready var mister_kitty := $mister_kitty as CharacterBody2D
@onready var camera := $camera as Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mister_kitty.follow_camera(camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
