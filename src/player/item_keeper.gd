class_name ItemKeeper
extends Resource

@export var item_1: Texture
@export var item_2: Texture
@export var item_3: Texture

# Hold references to items
@export var current_items = []

func is_full() -> bool:
	return len(current_items) == 3
