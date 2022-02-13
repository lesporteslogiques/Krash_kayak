extends Node2D


var timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
		
	$StartText.move_local_y(0.15 * cos(7*timer) )
	$StartText/Label.rect_rotation = 3 * cos(7*timer)
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://level.tscn")
