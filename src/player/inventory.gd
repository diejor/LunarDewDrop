extends Node

var dewdrop_tex = preload("res://assets/sprites/dewdrop.png")
var weapon_tex = preload("res://assets/sprites/weaponCharge.png")

var dewdrop_scene = preload("res://src/drops/dew_drop.tscn")
var weapon_scene = preload("res://src/drops/charge_drop.tscn")


func get_drop_scene(tex) -> PackedScene:
	if tex.load_path == dewdrop_tex.load_path:
		return dewdrop_scene
	if tex.load_path == weapon_tex.load_path:
		return weapon_scene
	return null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("drop_item"):
		var to_init: PackedScene
		if UI.item3.texture != null:
			to_init = get_drop_scene(UI.item3.texture)
			UI.item3.texture = null
		elif UI.item2.texture != null:
			to_init = get_drop_scene(UI.item2.texture)
			UI.item2.texture = null
		elif UI.item1.texture != null:
			to_init = get_drop_scene(UI.item1.texture)
			UI.item1.texture = null
			
		if to_init != null:
			var drop_ref = to_init.instantiate()
			drop_ref.position = $"../Marker3D".global_position
			$"../..".add_child(drop_ref)

func _on_pick_items_body_entered(body: Node3D) -> void:
	var type = body.type
	
	var type_tex = CompressedTexture2D.new()
	if type == "dewdrop":
		type_tex = dewdrop_tex.duplicate()
	elif type == "charge":
		type_tex = weapon_tex.duplicate()
	
	var consumed = false
	if UI.item1.texture == null:
		UI.item1.texture = type_tex
		consumed = true
	elif UI.item2.texture == null:
		UI.item2.texture = type_tex
		consumed = true
	elif UI.item3.texture == null:
		UI.item3.texture = type_tex
		consumed = true
	
	if consumed:
		UI.sfx_player.play("item_picked")
		body.queue_free()
