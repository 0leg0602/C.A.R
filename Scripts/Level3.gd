extends Node3D

var rng = RandomNumberGenerator.new()
var move = false
var speed = 4
var start = Vector3(0, 5, 0)
var end = Vector3(0, 5, 10)
var timeGameOverleft = "30"
var x = 0
var y = 0 

var car
func _ready():
	
	if global.hardcore:
		$SpotLight1.light_color = Color.RED
		#speed = 5
		#$car/Camera3D.queue_free() 
		#var camera = Camera3D.new()
		#$Path.add_child(camera)
		#camera.global_position = Vector3(50,30,2)
		#camera.look_at(Vector3(0,0,0))
		
		
	car = global.assets["Car"].duplicate()
	get_tree().root.get_node("Game").add_child(car)
	car.position = Vector3(0,3,0)
	
	var pause_menu = global.assets["PauseMenu"].duplicate()
	get_tree().root.get_node("Game").add_child(pause_menu)
	
	global.refresh_theme()
		

func _on_area_3d_body_entered(body):
	if body == car:
		if !move:
			move = true
			%TimerGameOver.start()
			%TimerFinish.start()
		%TimerGameOver.paused = true
		%TimeGameOverLable.set("theme_override_colors/font_disabled_color", Color.WHITE)
		%TimerFinish.paused = false
		%TimeFinishLable.set("theme_override_colors/font_disabled_color", Color.GREEN)


func _on_area_3d_body_exited(body):
	if body == car:
		%TimerGameOver.paused = false
		%TimeGameOverLable.set("theme_override_colors/font_disabled_color", Color.RED)
		%TimerFinish.paused = true
		%TimeFinishLable.set("theme_override_colors/font_disabled_color", Color.WHITE)

func _physics_process(delta):
	
	%TimeGameOverLable.text = str(%TimerGameOver.time_left).left(4)
	if str(%TimerFinish.time_left).left(3).ends_with("."):
		%TimeFinishLable.text =  str(%TimerFinish.time_left).left(4)
	else:
		%TimeFinishLable.text =  str(%TimerFinish.time_left).left(3)
	
	if move:
		
		
		if $SpotLight1.position == end:
			if global.hardcore:
				x = rng.randf_range(-10.0, 10.0)
				y = rng.randf_range(-10.0, 10.0)
			else:
				x = rng.randf_range(-40.0, 40.0)
				y = rng.randf_range(-40.0, 40.0)
			start = end 
			end = Vector3(x, 5, y)
			
		$SpotLight1.position = $SpotLight1.position.move_toward(end, delta * speed)

func _on_timer_game_over_timeout():
	global.gameover(false)

func _on_timer_finish_timeout():
	global.gameover(true)
