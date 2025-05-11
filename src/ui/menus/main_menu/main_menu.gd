extends Control

func _on_play_button_up() -> void:
	UI.sfx_player.queue("transition_level1")
	UI.songs_mixer.set("parameters/conditions/is_level1", true)
	UI.sfx_player.queue("start_game")
