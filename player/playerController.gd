extends CharacterBody3D

@onready var sprite: AnimatedSprite3D = $Sprite
var flip_speed : float = 17.0
var face_right : bool = false
var face_up : bool = false

var gravity : float = 1.0
var speed : float = 5.0  # Movement speed
var jump_force : float = 20.0  # Jump strength

func _physics_process(delta: float):
	# Input for movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_foward", "move_back")
	input_dir = input_dir.normalized()  # Ensure consistent speed in diagonal directions
	
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity
	
	# Handle jumping
	if is_on_floor() and Input.is_action_just_pressed("move_jump"):
		velocity.y = jump_force

	# Apply horizontal movement
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.y * speed

	# Animation switching for facing forwards/backwards
	var new_animation : String = "idle"
	var new_suffix : String = ""

	# Handle sprite flipping (paper mario style)
	# Left/Right
	if input_dir.x > 0.0:
		face_right = false
	elif input_dir.x < 0.0:
		face_right = true

	# Up/Down
	if abs(input_dir.x) > abs(input_dir.y):
		face_up = false
	else:
		if input_dir.y < 0.0:
			face_up = true
		elif input_dir.y > 0.0:
			face_up = false

	# Animation handler
	if is_on_floor():
		if input_dir != Vector2.ZERO:
			new_animation = "walk"
		else:
			new_animation = "idle"

	if face_up:
		new_suffix = "_up"

	if face_right:
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 0.0, flip_speed)
	else:
		sprite.rotation_degrees.y = move_toward(sprite.rotation_degrees.y, 180.0, flip_speed)

	sprite.play(new_animation + new_suffix)

	# Move the character
	move_and_slide()
