extends CharacterBody2D

const SPEED = 300.0
const laserPath = preload("res://Laser/lasers.tscn")
var move = 5.0
const FIRE_FORCE = -200.0
var shipVelocity = Vector2()
var viewport_size = Vector2()
var warping = false
var warp_timer = Timer.new()

var life = 10
var health_bar: ProgressBar
var is_dead = false

var die_timer = Timer.new()


func _ready() -> void:
	
	viewport_size = get_viewport().size
	add_child(warp_timer)
	position = viewport_size/2

	connect("on_area_entered", Callable(self,"_on_area_entered"))
	$"../gui/ProgressBar".value = life
	$AnimatedSprite2D.animation_finished.connect(Callable(self, "_on_animation_finished"))
	

func _physics_process(delta: float) -> void:
	if not warping:
		var collision_force = Vector2(200, 0) 
		
	move_and_slide()

func _process(delta: float) -> void:
	if warping:
		return
	var collision = move_and_collide(Vector2())  
	if collision and collision.get_collider().is_in_group("asteroid") and life > 0: 
		decrease_life(1)
		
		$CPUParticles2D.emitting = true
		$"crush-sfx".play()
		await $"crush-sfx".finished
	
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
		
	elif life <= 0:
		$AnimatedSprite2D.play("Die")
		get_tree().reload_current_scene()
	
	else:
		$AnimatedSprite2D.play("idle")
		
	warp()
		
func shoot():
	if warping:
		return
	$"shoot-sfx".play()
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
	
func decrease_life(damage:int):
	life -= damage
	$"../gui/ProgressBar".value = life
	if life == 0:
		$AnimatedSprite2D.play("Die")
		await $AnimatedSprite2D.animation_finished

func _on_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Die":
		get_tree().reload_current_scene()
