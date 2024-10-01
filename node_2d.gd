extends RigidBody2D



var speed = Vector2()
var rotational_speed = 0.0
var center_position = Vector2()
var asteroid_scale = Vector2()
var minRotate= -10.0
var maxRotate= 10.0

var life = 1



func _ready() -> void:	
	add_to_group("asteroid")
	var viewport_size = get_viewport().get_visible_rect().size
	
	# Randomize the asteroid's position and scale
	position = Vector2(randf_range(0.0, viewport_size.x), randf_range(0.0, viewport_size.y))
	scale = Vector2(randf_range(1.0, 2.0), randf_range(1.0, 2.0))
	asteroid_scale = scale

	rotational_speed = randf_range(minRotate, maxRotate)
	

	center_position = viewport_size / 2
	var direction_to_center = (center_position - position).normalized()
	
	# Set the speed and apply an initial impulse toward the center
	var initial_speed = randf_range(100.0, 200.0)  
	speed = direction_to_center * initial_speed
	#apply_impulse(Vector2.ZERO, speed)
	
	# Connect the collision signal
	

func _physics_process(delta: float) -> void:

	scale = asteroid_scale
	rotation += rotational_speed * delta
	position += speed*delta
	
	
func damage(amount: int):
	life -=amount
	if life <= 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collisionable"):
		print("we are colliasioned")
