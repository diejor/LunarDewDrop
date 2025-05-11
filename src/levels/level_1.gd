extends Node3D

signal LevelStarted()

func _ready() -> void:
	UI.ButtonPressed.connect(on_ui_button_up)

func on_ui_button_up(button_name: StringName):
	if button_name == "Play":
		LevelStarted.emit()
		%AnimationPlayerLevel.play("start_level")
