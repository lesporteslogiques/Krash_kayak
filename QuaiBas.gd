extends Node2D


var width = 176


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	move_local_x(-16 * delta * GlobalVars.game_speed)
	if global_position.x <= -(width):
		move_local_x(width)
