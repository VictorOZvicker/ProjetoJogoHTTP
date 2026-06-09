extends Control

var score_line_scene = load("res://jogo/scenes/score_line.tscn")

func _ready() -> void:
	$score_text.text = "%s\nScore: %d" % [Game.get_player().get_name(), Game.get_player().get_score()]
	$HTTPRequest.request("http://127.0.0.1:8000/scores/top", [], HTTPClient.METHOD_GET)
	
	
func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://jogo/Main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var data = JSON.parse_string(body.get_string_from_utf8())
	
	if data == null:
		print("Deu erro")
		return
	
	for ob in data:
		var score_line = score_line_scene.instantiate()
		score_line.prepare(ob["player"], ob["score"])
		$HBoxContainer.add_child(score_line)
