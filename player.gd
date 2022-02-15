extends Node2D

signal player_hit



var living_time = 0
var water_lane = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	living_time += delta
	var y_offset = 2 * (sin(4 * living_time) - 0.5)
	$AnimatedSprite.position.y = y_offset
	
	

func hurt():
	emit_signal("player_hit")
