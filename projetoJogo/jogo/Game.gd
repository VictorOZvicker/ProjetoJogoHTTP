extends Node

var _player := Player.new()

func get_player() -> Player:
	assert(self._player != null, "Player has not been initialized!")
	return self._player
