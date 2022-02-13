extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var width = 14*16

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(-5.5 * delta * GlobalVars.game_speed)
	if global_position.x <= -(width):
		move_local_x(width)
