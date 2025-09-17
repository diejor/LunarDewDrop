extends CanvasLayer

signal ButtonPressed(button_name:StringName)

var height:float  = 648
var width:float = 1152
@onready var sfx_player: AnimationPlayer = $SFXPlayer
@onready var songs_player: AnimationPlayer = $SongsPlayer
@onready var songs_mixer: AnimationTree = $SongsMixer

@export var level1 = preload("res://src/levels/level_1.tscn")
@export var level2 = preload("res://src/levels/level_2.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		$MainMenu.visible = false
		$HUD.visible = false
		$Pause.visible = true
		get_tree().paused = true

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(level1)
	$Pause.visible = false
	$HUD.visible = false
	$MainMenu.visible = true
	sfx_player.play("reset_game")
