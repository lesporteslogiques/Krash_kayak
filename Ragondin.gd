extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var water_lane = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Squik.play()
	global_position.x = -10
	global_position.y = 176 - (1+water_lane) * GlobalVars.lane_height


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if randf() < 0.004:
		$Squik.play()
	
	if position.x > 230:
		queue_free()
	
	move_local_x(delta * -4 * GlobalVars.water_current)


func _on_Area2D_body_entered(body):
	if body.get_parent().name == "Player":
		var player = body.get_parent()
		player.hurt()


func _on_Area2D_area_entered(area):
	area.get_parent().queue_free()
	pass # Replace with function body.
