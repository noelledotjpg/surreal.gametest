extends Sprite3D

# Oscillation parameters
@export var amplitude: float = 0.2  # Maximum displacement from the initial position
@export var speed: float = 0.5      # Speed of oscillation

# Internal variables
var _start_y: float = 0.0
var _time_elapsed: float = 0.0

func _ready():
	# Save the initial Y position
	_start_y = global_transform.origin.y

func _process(delta: float):
	# Increment time elapsed
	_time_elapsed += delta * speed
	# Update the Y position with sine wave
	global_transform.origin.y = _start_y + amplitude * sin(_time_elapsed)
