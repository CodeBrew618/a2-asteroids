extends RigidBody2D

var speed = Vector2()
var rotational_speed = 0.0
var center_position = Vector2()
var asteroid_scale = Vector2()
var minRotate = -10.0
var maxRotate = 10.0
var life = 1
signal asteroid_destroyed


func _ready() -> void:
	
	gravity_scale = 0
	var viewport_size = get_viewport().get_visible_rect().size
	
	position = Vector2(randf_range(0.0, viewport_size.x), randf_range(0.0, viewport_size.y))
	scale = Vector2(randf_range(1.0, 2.0), randf_range(1.0, 2.0))
	asteroid_scale = scale

	rotational_speed = randf_range(minRotate, maxRotate)

	center_position = viewport_size / 2
	var direction_to_center = (center_position - position).normalized()
	
	var initial_speed = randf_range(100.0, 200.0)
	speed = direction_to_center * initial_speed

	asteroid_destroyed.connect(Callable($Label,"_on_asteroid_destroyed"))
	apply_central_impulse(speed)

	#connect("area_2d_area_entered", Callable(self, "_on_area_2d_area_entered"))

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	scale = asteroid_scale
	rotation += rotational_speed * delta
		
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("laser"):
		print("Triggered by area2D signal")
		$"asteroid-explode-sfx".play()
		
		emit_signal("asteroid_destroyed")
		await $"asteroid-explode-sfx".finished
		queue_free()

#func _on_body_entered(body: Node) -> void:
	#if body.is_in_group("laser"):
		#print("Triggered by body enter signal")
		
