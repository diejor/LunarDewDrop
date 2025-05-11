extends SpriteBase3D

@onready var _p: CharacterBody3D = $".."
@onready var _controller: AnimationTree = $"../AnimationTree"

func _process(_delta):
	# Get the current camera (make sure your camera is the active one)
	var planet_up = _p._planet_up
	var cam = get_viewport().get_camera_3d()
	if cam == null:
		return  # Safety check in case there's no camera

	# Orient the sprite toward the camera (projected onto the movement plane)
	var to_camera = cam.global_transform.origin - global_transform.origin
	var projected_dir = to_camera - planet_up * to_camera.dot(planet_up)
	if projected_dir.length() > 0.01:
		look_at(global_transform.origin + projected_dir, planet_up)
	
	# --- Compute the blend vector using the camera's full transform ---
	
	# 1. Project the player's velocity onto the plane defined by planet_up.
	var projected_vel = _p.velocity - planet_up * _p.velocity.dot(planet_up)
	
	# 2. Get the camera's full transform (including any horizontal or vertical offsets)
	var cam_transform = cam.get_camera_transform()
	
	# 3. Convert the projected velocity from world space into the camera's local coordinate system.
	#    This aligns the velocity vector with the camera's adjusted orientation.
	var cam_local_vel = cam_transform.basis.inverse() * projected_vel
	
	# 4. Build the 2D blend vector.
	#    In camera space, we typically take:
	#      - The X axis for right/left.
	#      - The negative Z axis for forward/backward.
	var blend_vector = Vector2(-cam_local_vel.x, -cam_local_vel.z)
	
	# 5. Update the AnimationTree parameters with the new blend vector.
	_controller.set("parameters/Walk/blend_position", blend_vector)
	_controller.set("parameters/Idle/blend_position", blend_vector)
