extends Node2D
const asteroid_scene = preload("res://Asteroid/asteroids.tscn")
var spawn_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.wait_time = 5.0
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.timeout.connect(Callable(self,"_on_spawn_timer_timeout"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_spawn_timer_timeout() -> void:
	var asteroid = asteroid_scene.instantiate()
	var spawn_location = Vector2(randf_range(-200,2000),randf_range(-200,2000))
	asteroid.position = spawn_location
	
	add_child(asteroid)
