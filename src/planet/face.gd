extends Decal

var drewdrops_left = 3

func _ready() -> void:
	%AnimationPlayerMoon.play("close_mouth")
	$AnimationPlayerText.play("loop_text")

func set_remaining_text():
	$InPopup/SubViewport/Control/Label.text = str(drewdrops_left) + "x LEFT!"

func _on_area_3d_body_entered(body: Node3D) -> void:
	%AnimationPlayerMoon.play("open_mouth")


func _on_area_3d_body_exited(body: Node3D) -> void:
	%AnimationPlayerMoon.play("close_mouth")


func _on_items_body_entered(body: Node3D) -> void:
	if body.type == "dewdrop":
		drewdrops_left -= 1
		body.queue_free()
		UI.sfx_player.play("food_eaten")
