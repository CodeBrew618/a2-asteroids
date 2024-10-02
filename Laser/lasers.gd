extends Area2D

const SPEED = 600.0
var velocity = Vector2()

func _ready() -> void:
	
	connect("on_area_entered", Callable(self,"_on_area_entered"))
	
	velocity = Vector2.UP.rotated(rotation) * SPEED
	connect("body_entered", Callable(self,"_on_body_entered"))
func _physics_process(delta: float) -> void:
	velocity = Vector2.UP.rotated(rotation) * SPEED
	position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		print("ohhaaaaaa!!!")
		queue_free()
