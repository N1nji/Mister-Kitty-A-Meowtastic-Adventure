extends AnimatedSprite2D

@onready var bg_sprite: AnimatedSprite2D = $"."

var base_resolution := Vector2(1920, 1080) # Resolução base do teu jogo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_resolution = get_viewport().get_visible_rect().size
	var factor = min(
		current_resolution.x / base_resolution.x,
		current_resolution.y / base_resolution.y
	)

	# Multiplicador manual (tipo um zoom)
	var multiplier = 7.79
	scale = Vector2(factor, factor) * multiplier
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
