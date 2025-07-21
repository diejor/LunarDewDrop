extends Control

@export var status: ItemKeeper
@export var inventory: ItemKeeper

func _ready() -> void:
	print("first item is: ", status.item_1)
