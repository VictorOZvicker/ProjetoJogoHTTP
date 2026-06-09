extends HBoxContainer


func prepare(player, score):
	$player.text = player
	$score.text = str(score)
