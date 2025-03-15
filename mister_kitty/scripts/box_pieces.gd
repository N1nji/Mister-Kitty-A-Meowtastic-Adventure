extends RigidBody2D


func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_notifier_screen_exited() -> void: # Sinal para notificar quando o item sair da tela
	queue_free() # remove o item após sair da tela
