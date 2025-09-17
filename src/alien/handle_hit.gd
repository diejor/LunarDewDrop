extends Node

var health = 3

func hit() -> void:
	print("alien hit")
	health -= 1
	UI.sfx_player.play("alien_hit")
	if health == 0:
		UI.sfx_player.play("enemy_killed")
		$"..".queue_free()
