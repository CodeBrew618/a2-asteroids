extends Area2D


# Called when the node enters the scene tree for the first time.
const SPEED = 600.0
#const JUMP_VELOCITY = -400.0

var velocity = Vector2()

func _physics_process(delta: float) -> void:

	velocity = Vector2.UP.rotated(rotation)*SPEED
	position += velocity * delta
		
		
	


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if viewport.is_in_group("Damageable"):
		viewport.damage(1)


func _on_area_entered(area: CharacterBody2D) -> void:
	if area.is_in_group("Damageable"):
		area.damage(1)
