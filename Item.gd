extends Node2D


var living_time = 0
var water_lane = 0
var active = true


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position.x = 220
	global_position.y = 176 - (1+water_lane) * GlobalVars.lane_height


func _process(delta):
	living_time += delta
	
	if position.x < 0:
		queue_free()
	
	var y_offset = 2 * (sin(4 * living_time) - 0.5)
	$Sprite.position.y = y_offset
	move_local_x(delta * GlobalVars.water_current)


func _on_Area2D_body_entered(body):
	if active and body.get_parent().name == "Player":
		var player = body.get_parent()
		$Player.play()
		player.hurt()
		#$Particles.emitting = true
		$Particles.restart()
		$Sprite.visible = false
		active = false
