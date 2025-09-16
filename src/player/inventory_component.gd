extends Node

@export var _inventory: InventoryResource

func _init_inventory():
	

func _ready() -> void:
	

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("drop_item"):
		if _inventory._backpack.size() > 0:
			var item = _inventory._pop_backpack()
			var item_node = item.scene.instantiate()
			item_node.global_position = $"../Marker3D".global_position
			$"../../".add_child(item_node)


func _on_pick_items_body_entered(body: Node3D) -> void:
	if body is ItemBody:
		var item_resource: ItemResource = body.resource
		
		if _inventory._backpack.size() < 3:
			_inventory._append_to_backpack(item_resource.duplicate())
			UI.sfx_player.play("item_picked")
			body.queue_free()
	else:
		push_warning("Tried to pickup somethign that is not an ItemBody")
