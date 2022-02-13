extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position.x = -randi() % 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(delta * GlobalVars.water_current)
	if global_position.x <= -(7*32):
		move_local_x(7*32)
