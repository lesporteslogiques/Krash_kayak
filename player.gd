extends Node2D

signal player_hit


var hurting_cooldown = 0.0
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
	
	if hurting_cooldown > 0:
		hurting_cooldown -= delta
		if fmod(hurting_cooldown, 0.2) < 0.1:
			visible = false
		else:
			visible = true
	else:
		visible = true


func hurt():
	if not hurting_cooldown > 0:
		emit_signal("player_hit")
		hurting_cooldown = 1.5
