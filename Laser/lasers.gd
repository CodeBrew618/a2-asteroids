extends Area2D

const SPEED = 600.0
var velocity = Vector2()

func _ready() -> void:
	
	connect("on_area_entered", Callable(self,"_on_area_entered"))
	
	velocity = Vector2.UP.rotated(rotation) * SPEED
	connect("body_entered", Callable(self,"_on_body_entered"))
	
	
	var timer = Timer.new()
	timer.wait_time = 1.5 
	timer.one_shot = true 
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timeout"))  # Connect timeout to function
	timer.start()  
	
	
func _physics_process(delta: float) -> void:
	velocity = Vector2.UP.rotated(rotation) * SPEED
	position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		print("ohhaaaaaa!!!")
		queue_free()
		
func _on_timeout() -> void:
	
	queue_free()
