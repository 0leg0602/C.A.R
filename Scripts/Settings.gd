extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	int(global.use_touchscreen)
	$VBoxContainer/TabContainer/Controls/HBoxContainerForInputModeOption/InputModeOption.select(int(global.use_touchscreen))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	pass
		
	
	


func _on_save_and_return_button_pressed():
	if get_tree().root.get_node_or_null("Menu") != null or get_tree().root.get_node_or_null("Game") != null:
		visible = false
		get_parent().get_node("MainGrid").visible = true


func _on_input_mode_option_item_selected(index):
	#print("index: ", index)
	global.mouse_control = false
	if index == 1:
		global.use_touchscreen = true
	else:
		global.use_touchscreen = false
	
	if index == 2:
		global.mouse_control = true
	global.save()
