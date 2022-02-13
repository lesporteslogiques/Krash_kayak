extends Node2D


var timer = 0
onready var lanes = [$Lane1, $Lane2, $Lane3, $Lane4, $Lane5]
onready var lifebar = $TopLayer/Lifebar
onready var player = find_node("Player")

var bouteille_builder = preload("res://Bouteille.tscn")
var bidon_builder = preload("res://Bidon.tscn")
var ragondin_builder = preload("res://Ragondin.tscn")
var bateau_builder = preload("res://GwinMary.tscn")
var gwin_mary = null


# Called when the node enters the scene tree for the first time.
func _ready():	
	player.connect("player_hit", self, "_on_player_hit")
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	timer += delta
	GlobalVars.water_current = GlobalVars.start_water_current * (1 + timer*0.06)
	player.get_node("AnimatedSprite").set_speed_scale(1 + timer*0.06) 
	
	if not gwin_mary and timer > 20:
		gwin_mary = bateau_builder.instance()
		gwin_mary.position.x = 0
		$MidLayer.add_child(gwin_mary)
	
	if gwin_mary != null:
		if player.position.y < 158:	# Go to bottom lane
			player.move_local_y(8 * delta)
		
		gwin_mary.move_local_x(-30 * delta)
		if gwin_mary.position.x < -650:
			# Remove gwin Mary
			$MidLayer.remove_child(gwin_mary)
			gwin_mary.queue_free()
			gwin_mary = null
			timer = 0
			lifebar.value = 100
			player.water_lane = 0
	
	if not gwin_mary and randf() < 0.01:
		var new_item = null
		if randf() < 0.5:
			new_item = bidon_builder.instance()
		else:
			new_item = bouteille_builder.instance()
			
		var n_lane = randi() % GlobalVars.num_lanes
		new_item.water_lane = n_lane
		$MidLayer.add_child(new_item)
	
	if not gwin_mary and randf() < 0.001:
		var ragondin = ragondin_builder.instance()
		var n_lane = randi() % GlobalVars.num_lanes
		ragondin.water_lane = n_lane
		$MidLayer.add_child(ragondin)
	
	if Input.is_action_pressed("ui_left"):
		player.move_local_x(-GlobalVars.player_speed * delta)
		player.get_node("AnimatedSprite").play("default")
	
	if Input.is_action_pressed("ui_right"):
		player.move_local_x(GlobalVars.player_speed * delta)
		player.get_node("AnimatedSprite").play("default")
	
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		player.get_node("AnimatedSprite").stop()
	
	
	if not gwin_mary and Input.is_action_just_pressed("ui_up"):
		if player.water_lane < len(lanes)-1:
			player.move_local_y(-GlobalVars.lane_height)
			player.water_lane += 1
			#_move_to_lane(player, player.water_lane)
	
	if not gwin_mary and Input.is_action_just_pressed("ui_down"):
		if player.water_lane > 0:
			player.move_local_y(GlobalVars.lane_height)
			player.water_lane -= 1
			#_move_to_lane(player, player.water_lane)


#func _move_to_lane(node : Node, n : int):
#	var old_parent = node.get_parent()
#	if old_parent:
#		old_parent.remove_child(node)
#	lanes[n].add_child(node)


func _on_player_hit():
	if not gwin_mary:
		lifebar.value -= 25
		if lifebar.value <= 0:
			get_tree().change_scene("res://GameOver.tscn")
