extends CharacterBody2D


const SPEED = 600.0
#const JUMP_VELOCITY = -400.0



func _physics_process(delta: float) -> void:

	velocity = Vector2.UP.rotated(rotation)*SPEED
		
		
	var collision_info = move_and_collide(velocity.normalized()*delta*SPEED)
	if collision_info:
		queue_free()
