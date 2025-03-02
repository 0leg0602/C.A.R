extends HBoxContainer

var keybind_to_change = ["",""]


func button_press(button, action, keybind):
	button.text = "press any button"
	print("pressed: ", action, keybind)
	
	keybind_to_change = [action, keybind]
	print("changed: ", keybind_to_change)
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	redraw_buttons()
	
	var action = get_node("ActionName").text
	for i in ["1", "2", "3"]:
		get_node("Button"+i).connect("pressed", func(): button_press(get_node("Button"+i), action, i))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func redraw_buttons():
	#print(keybind_to_change)
	#print(keybind_to_change == ["",""])
	var action = get_node("ActionName").text
	for i in ["1", "2", "3"]:
		
		var start_sub_string
		var end_sub_string
		
		if "InputEventKey" in global.keybinds[action][i]:
			start_sub_string = global.keybinds[action][i].find("(")+1
			end_sub_string = global.keybinds[action][i].find(")")
			get_node("Button"+i).text = global.keybinds[action][i].substr(start_sub_string, end_sub_string-start_sub_string)
		elif "InputEventJoypadButton" in global.keybinds[action][i]:
			start_sub_string = global.keybinds[action][i].find("button_index=")+13
			end_sub_string = global.keybinds[action][i].find(",", start_sub_string)
			get_node("Button"+i).text = "GPB: " + global.keybinds[action][i].substr(start_sub_string, end_sub_string-start_sub_string)
		elif "InputEventJoypadMotion" in global.keybinds[action][i]:
			
			start_sub_string = global.keybinds[action][i].find("axis=")+5
			end_sub_string = global.keybinds[action][i].find(",", start_sub_string)
			var axis = global.keybinds[action][i].substr(start_sub_string, end_sub_string-start_sub_string)
			
			start_sub_string = global.keybinds[action][i].find("axis_value=")+11
			var axis_value = global.keybinds[action][i].substr(start_sub_string, -1)
			
			get_node("Button"+i).text = "GPM: " + axis + ", " + axis_value
		else:
			get_node("Button"+i).text = global.keybinds[action][i]
			
		
		
		
		
func _input(event):
	#if event is InputEventMouseMotion:
		#print(event)
		#if event.pressed == true:
			#if get_node("ActionName").text == keybind_to_change[0]:
				#if keybind_to_change != ["",""]:
					#global.keybinds[keybind_to_change[0]][keybind_to_change[1]] = "%s" % event
					#global.save()
					#global.rebind_all_actions()
					#keybind_to_change = ["",""]
					#redraw_buttons()
	if event is InputEventKey or event is InputEventJoypadButton or event is InputEventJoypadMotion:
		if event is not InputEventJoypadMotion and event.pressed == true or event is InputEventJoypadMotion and abs(event.axis_value) == 1:
			if get_node("ActionName").text == keybind_to_change[0]:
				#print(event)
				#print(keybind_to_change)
				if keybind_to_change != ["",""]:
					if  event is InputEventKey and event.as_text_key_label() == "Backspace":
						global.keybinds[keybind_to_change[0]][keybind_to_change[1]] = "none"
					else:
						global.keybinds[keybind_to_change[0]][keybind_to_change[1]] = "%s" % event
					global.save()
					global.rebind_all_actions()
					keybind_to_change = ["",""]
					redraw_buttons()
