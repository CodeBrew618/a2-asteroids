extends Label
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".text = str(score)
	print($".".text)
	print("ready label")

func _process(delta: float) -> void:
	$".".text = str(score)
	
	
	
func _on_asteroid_destroyed() ->void:
	score += 1
	print($".".text)
	$".".text = str(score)
	
