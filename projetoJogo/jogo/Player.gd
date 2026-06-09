class_name Player

var _name: String
var _score: int

signal score_changed()
signal start_game()

func _init():
	self.start_game.connect(on_game_start)

func get_name() -> String:
	return self._name

func get_score() -> int:
	return self._score

func set_name(name: String):
	self._name = name

func add_score(amount: int = 1):
	self._score += amount
	self.score_changed.emit()

func on_game_start():
	self._score = 0
	self.score_changed.emit()
