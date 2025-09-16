class_name InventoryResource
extends Resource

@export var _health: Array[HealthResource]
@export var _backpack: Array[ItemResource]

func _append_health_point(health_point):
	_health.append(health_point)
	emit_changed()

func _append_to_backpack(item):
	_backpack.append(item)
	emit_changed()

func _pop_health():
	emit_changed()
	return _health.pop_back()
	
func _pop_backpack():
	emit_changed()
	return _backpack.pop_back()
	

func _validate_health():
	if _health.size() > 3:
		push_warning("Player has more than 3 health points")
		
func _validate_backpack():
	if _backpack.size() > 3:
		push_warning("Player has more than 3 items in the backpack")
