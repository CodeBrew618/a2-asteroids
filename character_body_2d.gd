extends CharacterBody2D

const SPEED = 300.0
const laserPath = preload("res://Laser/lasers.tscn")
var move = 5.0
const FIRE_FORCE = -200.0
var shipVelocity = Vector2()
var viewport_size = Vector2()
var warping = false
var warp_timer = Timer.new()



func _ready() -> void:
	
	viewport_size = get_viewport().size
	add_child(warp_timer)
	position = viewport_size/2


func _physics_process(delta: float) -> void:
	if not warping:
		var collision_force = Vector2(100, 0)  # Example force, modify as needed
		move_and_slide()

func _process(delta: float) -> void:
	if warping:
		return
	
	if Input.is_action_pressed("ui_right"):
		self.rotation += delta*move
		$AnimatedSprite2D.play("Rotate right")
		#play("Rotate right")
		
	elif Input.is_action_pressed("ui_left"):
		self.rotation -= delta*move
		$AnimatedSprite2D.play("Rotate left")
		#play("Rotate left")
		
	elif Input.is_action_just_pressed("ui_select"):
		$AnimatedSprite2D.play("Firing Bullet")
		shoot()
		
		
	else:
		$AnimatedSprite2D.play("idle")
		
	warp()
		
func shoot():
	if warping:
		return
	
	var laser = laserPath.instantiate()
	get_parent().add_child(laser)
	laser.position = $Marker2D.global_position
	laser.rotation = self.rotation
	
	var force_direction = Vector2.UP.rotated(rotation)
	velocity += force_direction *FIRE_FORCE
	
	
func warp():
	if warping:
		return
		
	if position.x < 0:
		warping = true
		position.x = viewport_size.x
		$AnimatedSprite2D.play("Warping")
		warp_timer.start(0.5)
		await warp_timer.timeout
		
	elif position.x > viewport_size.x:
		warping = true
		position.x = 0
		$AnimatedSprite2D.play("Warping")
		warp_timer.start(0.5)
		await warp_timer.timeout
		
	if position.y < 0:
		warping = true
		position.y = viewport_size.y
		$AnimatedSprite2D.play("Warping")
		warp_timer.start(0.5)
		await warp_timer.timeout
	elif position.y > viewport_size.y:
		warping = true
		position.y = 0
		$AnimatedSprite2D.play("Warping")
		warp_timer.start(0.5)
		await warp_timer.timeout
		
	warping = false
		
		
func apply_collision_force(collision_force: Vector2) -> void:
	
	velocity += collision_force
