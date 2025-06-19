extends Node2D

@onready var mister_kitty := $mister_kitty as CharacterBody2D
@onready var camera := $camera as Camera2D

func _physics_process(delta):
	pass

func _ready() -> void:
	mister_kitty.follow_camera(camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
