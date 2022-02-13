extends Node2D


onready var width = $Sprite.get_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(-1 * delta * GlobalVars.game_speed)
	if global_position.x <= -(width):
		move_local_x(width)