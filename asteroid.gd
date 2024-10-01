extends RigidBody2D

var speed = Vector2()
var rotational_speed = 0
var laser_scene = preload("res://laser.tscn")
var center_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Disable gravity for this object
	gravity_scale = 0
	
	# Get the size of the viewport and set initial position outside the screen
	var viewport_size = get_viewport().get_visible_rect().size
	position = get_random_spawn_position(viewport_size)
	
	# Set random scale for the asteroid
	scale = Vector2(randf_range(0.5, 1.5), randf_range(0.5, 1.5))
	
	# Set random rotational speed for spinning effect
	rotational_speed = randf_range(-2.0, 2.0)
	
	# Calculate direction toward the center of the screen
	var direction_to_center = (viewport_size / 2 - global_position).normalized()
	
	# Set random speed for the asteroid and apply impulse to move toward the center
	speed = direction_to_center * randf_range(100, 200)
	apply_impulse(Vector2.ZERO, speed)
	
	# Connect the signal for collisions with the laser
	self.body_entered.connect(_on_Asteroid_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += rotational_speed * delta

# Function called when the asteroid collides with a laser
func _on_Asteroid_body_entered(body: Node) -> void:
	if body.is_in_group("laser"):
		queue_free()  # Destroy the asteroid

# Function to randomly spawn the asteroid outside the screen
func get_random_spawn_position(viewport_size: Vector2):
	var side = randi() % 4  # Pick a random side (0=left, 1=right, 2=top, 3=bottom)
	
	match side:
		0:  # Left side
			return Vector2(-50, randf_range(0, viewport_size.y))  # 50 units off the left edge
		1:  # Right side
			return Vector2(viewport_size.x + 50, randf_range(0, viewport_size.y))  # 50 units off the right edge
		2:  # Top side
			return Vector2(randf_range(0, viewport_size.x), -50)  # 50 units off the top edge
		3:  # Bottom side
			return Vector2(randf_range(0, viewport_size.x), viewport_size.y + 50)  # 50 units off the bottom edge
