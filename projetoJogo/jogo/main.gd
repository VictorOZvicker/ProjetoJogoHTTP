extends Node2D

var target_area: Vector2
var target_scene = preload("res://jogo/scenes/target.tscn")
var current_target


var name_scene = load("res://jogo/scenes/ask_name.tscn")

func _process(_delta: float):
	$time_progress.value = $game_timer.time_left

func _ready() -> void:
	Game.get_player().start_game.connect(on_game_start)
	target_area = $Area2D/CollisionShape2D.shape.size / 2
	name_scene = name_scene.instantiate()
	add_child(name_scene)

func generate_target():
	var pos = Vector2(
		randf_range(-target_area.x, target_area.x),
		randf_range(-target_area.y, target_area.y)
	)
	var target = target_scene.instantiate()
	target.global_position = $Area2D/CollisionShape2D.global_position + pos
	$targets.add_child(target)
	return target

func on_game_start():
	$target_timer.start()
	$game_timer.start()
	Game.get_player().score_changed.connect(on_score_changed)

func on_score_changed():
	$score_text.text = "Score: %d" % Game.get_player().get_score()

func _on_timer_timeout() -> void:
	if(current_target == null):
		current_target = generate_target()

func _on_game_timer_timeout() -> void:
	end_game()

func send_score():
	var body = JSON.stringify({"player": Game.get_player().get_name(), "score": Game.get_player().get_score()})
	var headers = ["Content-Type: application/json"]
	var err = $HTTPRequest.request("http://127.0.0.1:8000/scores", headers, HTTPClient.METHOD_POST, body)
	if err != OK:
		return false
	var result = await $HTTPRequest.request_completed
	var response_code = result[1]
	return response_code == 200
	
func end_game():
	$target_timer.queue_free()
	var result = await send_score()
	
	if result:
		get_tree().change_scene_to_file("res://jogo/scenes/kill_screen.tscn")
