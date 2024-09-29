extends AnimatedSprite2D

var move = 5.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		self.rotation += delta*move
		play("Rotate right")
		
	elif Input.is_action_pressed("ui_left"):
		self.rotation -= delta*move
		play("Rotate left")
		
	else:
		play("idle")
