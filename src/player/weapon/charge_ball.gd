extends PlanetBody

@export var _speed: float = 4.

func _ready() -> void:
	super._ready()
	$Charge.emitting = true
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_alien_collision_body_entered(body: Node3D) -> void:
	body.handle_hit.hit()
	queue_free()
