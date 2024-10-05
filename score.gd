extends Label
var score = 0
var asteroid = preload("res://Asteroid/asteroids.tscn")

@onready var asteroid_explode_checker = $Asteroids


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(score)

func _process(delta: float) -> void:	
		text = str(score)
	
	
	
func _on_asteroid_destroyed() ->void:
	score += 1
	print(text)
	text = str(score)
	
