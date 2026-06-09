extends Control


func _ready() -> void:
	$name_input.max_length = 20

func _on_name_input_text_submitted(new_text: String) -> void:
	Game.get_player().set_name(new_text)
	Game.get_player().start_game.emit()
	queue_free()
