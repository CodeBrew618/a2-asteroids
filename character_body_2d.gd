extends CharacterBody2D


const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
const laserPath = preload("res://laser.tscn")
var move = 5.0

func _physics_process(delta: float) -> void:
	pass
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		self.rotation += delta*move
		$AnimatedSprite2D.play("Rotate right")
		#play("Rotate right")
		
	elif Input.is_action_pressed("ui_left"):
		self.rotation -= delta*move
		$AnimatedSprite2D.play("Rotate left")
		#play("Rotate left")
		
	elif Input.is_action_just_pressed("ui_select"):
		shoot()
		
		
	else:
		$AnimatedSprite2D.play("idle")
		
	
		
func shoot():
	var laser = laserPath.instantiate()
	get_parent().add_child(laser)
	laser.position = $Marker2D.global_position
	laser.rotation = self.rotation
	

	
	
	
	
	
	
	
	
	
	
	

	
