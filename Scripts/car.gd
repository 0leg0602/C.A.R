extends VehicleBody3D

var switch = false

var CONSTANT_ENGINE_POWER = 50

var time_elapsed = 0

var screen_size

func _ready() -> void:
	screen_size = get_tree().get_root().size

func _physics_process(delta):
	
	var engine_power = CONSTANT_ENGINE_POWER
	
	if global.mouse_control:
	
		var mouse_pos = get_viewport().get_mouse_position()
		
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		engine_force = ((mouse_pos[1]/screen_size[1])*2-1) * CONSTANT_ENGINE_POWER * -1
		
		steering = ((mouse_pos[0]/screen_size[0])*2-1) * -1
	else:
		steering = lerp(steering, Input.get_axis("right","left") * 0.4, 5 * delta)
		
		if Input.get_action_strength("brake") == 0:
			if Input.get_action_strength("reverse") == 1:
				engine_force = Input.get_axis("forward","backward") * engine_power
			else:
				engine_force = Input.get_axis("backward","forward") * engine_power
		else: 
			engine_force = 0
		
			#

		#
			#
			#if switch:
				#engine_force = Input.get_axis("forward","backward") * engine_power
			#else:
				#engine_force = Input.get_axis("backward","forward") * engine_power
		
		brake = Input.get_action_strength("brake") * 5

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_QUOTELEFT:
			if event.get_keycode_with_modifiers() == 301989984:
				$UI/Cheats.visible = !$UI/Cheats.visible
		

func _process(delta: float) -> void:
	time_elapsed += delta
	$UI/StopWatchLabel.text = str(round(time_elapsed))

func _on_forward_pressed():
	Input.action_press("forward")


func _on_forward_released():
	Input.action_release("forward")


func _on_back_pressed():
	Input.action_press("backward")


func _on_back_released():
	Input.action_release("backward")


func _on_left_pressed():
	Input.action_press("left")


func _on_left_released():
	Input.action_release("left")


func _on_right_pressed():
	Input.action_press("right")


func _on_right_released():
	Input.action_release("right")


func _on_break_pressed():
	Input.action_press("brake")


func _on_break_released():
	Input.action_release("brake")
