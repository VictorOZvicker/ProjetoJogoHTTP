extends Node2D

var score_value: int = randi_range(1, 5)

func _on_button_pressed():
	Game.get_player().add_score(score_value)
	queue_free()
	return null
