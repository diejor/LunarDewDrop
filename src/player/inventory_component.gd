extends Node

func _spawn_item(item: ItemBody):
	item.process_mode = Node.PROCESS_MODE_INHERIT
	item.visible = true
	item.reparent($"../../")
	item.global_position = %DropItemMarker.global_position

func _pickup_item(item: ItemBody):
	item.reparent(%Backpack)
	item.process_mode = Node.PROCESS_MODE_DISABLED
	item.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("drop_item"):
		if %Backpack.get_child_count() != 0:
			var last_item = %Backpack.get_child(-1)
			assert(last_item is ItemBody, "Spawning an item must be of type ItemBody")
			_spawn_item(last_item)
			

func _on_pick_items_body_entered(body: Node3D) -> void:
	assert(body is ItemBody, "Player only pickups items of type ItemBody")
	if %Backpack.get_child_count() < 3:
		_pickup_item(body)
