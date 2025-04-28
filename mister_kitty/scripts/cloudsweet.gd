extends CharacterBody2D

@onready var original_position = position
@onready var area = get_node("area")
@onready var texture := $texture as Sprite2D

var tween_ativo = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "mister_kitty": # ou qualquer nome do seu player
		#body.velocity.y = body.JUMP_FORCE
		abaixar_nuvem()
		
func abaixar_nuvem():
		var abaixar_para = original_position + Vector2(0, 20)
		var tween = create_tween()
		tween.tween_property(self, "position", abaixar_para, 0.1)
		tween.tween_property(self, "position", original_position, 0.2)
		tween.finished.connect(func(): tween_ativo = false)
