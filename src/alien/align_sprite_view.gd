extends SpriteBase3D

@onready var _p: CharacterBody3D = $".."
@onready var _controller: AnimationTree = $"../AnimationTree"

func _process(_delta):
	# Get the planet‐up and active camera
	var planet_up = _p._planet_up
	var cam = get_viewport().get_camera_3d()
	if cam == null:
		return

	# 1) BILLBOARD: rotate sprite so its +Z faces the camera (but stays upright on planet_up)
	var to_camera = cam.global_transform.origin - global_transform.origin
	var flat_dir = to_camera - planet_up * to_camera.dot(planet_up)
	if flat_dir.length() > 0.01:
		# look_at() aims the node’s -Z toward the target, so we invert
		look_at(global_transform.origin - flat_dir, planet_up)

	# 2) PROJECT the player’s velocity onto the walking plane
	var projected_vel = _p.velocity - planet_up * _p.velocity.dot(planet_up)

	# 3) BUILD a “sprite‐camera” at the sprite’s position, looking at the real camera
	var forward = (cam.global_transform.origin - global_transform.origin).normalized()
	var right   = planet_up.cross(forward).normalized()
	var up      = forward.cross(right)
	var sprite_cam_basis = Basis(right, up, forward)

	# 4) TRANSFORM the planar velocity into this sprite‐camera’s local space
	var local_vel = sprite_cam_basis.inverse() * projected_vel

	# 5) PACK into a 2D blend vector (X=strafe, Y=away/toward)
	var blend = Vector2(local_vel.x, -local_vel.z)

	# 6) APPLY to your AnimationTree blend parameters
	_controller.set("parameters/Walk/blend_position", blend)
	_controller.set("parameters/Idle/blend_position", blend)
