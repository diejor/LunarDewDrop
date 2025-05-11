extends Node

var dewdrop: PackedScene = preload("res://src/drops/dew_drop.tscn")

var health = 3

func hit() -> void:
	print("alien hit")
	health -= 1
	UI.sfx_player.play("alien_hit")
	if health == 0:
		UI.sfx_player.play("enemy_killed")
		var dew_ref = dewdrop.instantiate()
		dew_ref.position = $"../Marker3D".global_position
		$"../..".add_child(dew_ref)
		$"..".queue_free()
