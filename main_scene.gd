extends Node2D

const asteroid_scene = preload("res://Asteroid/asteroids.tscn")
var spawn_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.wait_time = 2.0
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.timeout.connect(Callable(self, "_on_spawn_timer_timeout"))
	asteroid_scene.connect("asteroid_destroyed", Callable(self, "_on_asteroid_destroyed"))
	

# Called when the timer times out to spawn a new asteroid.
func _on_spawn_timer_timeout() -> void:
	var asteroid = asteroid_scene.instantiate()
	var screen_size = get_viewport_rect().size
	var x_pos = randf_range(-100, -10) if randf_range(0, 1) < 0.5 else randf_range(screen_size.x + 10, screen_size.x + 100)
	var y_pos = randf_range(-100, -10) if randf_range(0, 1) < 0.5 else randf_range(screen_size.y + 10, screen_size.y + 100)

	var spawn_location = Vector2(x_pos, y_pos)
	asteroid.position = spawn_location
	add_child(asteroid)
