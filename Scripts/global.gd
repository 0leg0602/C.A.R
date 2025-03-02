extends Node

const SAVE_PATH = "user://data.json"

var hardcore = false

var is_gameover = false

var ui_size
var use_touchscreen
var levels
var keybinds

var mouse_control = false


func _ready():
	var save_dict
	
	
	if FileAccess.file_exists(SAVE_PATH):
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		var json := JSON.new()
		json.parse(file.get_line())
		save_dict = json.get_data() as Dictionary
		#print(save_dict)
	else:
		var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		
		var sugested_ui_size
		var sugested_touchscreen_use
	
		
		if DisplayServer.is_touchscreen_available():
			sugested_ui_size = 7
			sugested_touchscreen_use = true
		else:
			sugested_ui_size = 4
			sugested_touchscreen_use = false
		
		save_dict = {
			use_touchscreen = sugested_touchscreen_use,
			ui_size = sugested_ui_size,
			levels = {
				"level1" : {
					"is_completed" : false,
					"best_time" : "none"
				},
				"level2" : {
					"is_completed" : false,
					"best_time" : "none"
				},
				"level3" : {
					"is_completed" : false,
					"best_time" : "none"
				},
				"level4" : {
					"is_completed" : false,
					"best_time" : "none"
				},
			},
			keybinds = {
				"forward" : {
					"1" : "InputEventKey: keycode=87 (W), mods=none, physical=false, pressed=true, echo=false",
					"2" : "InputEventKey: keycode=4194320 (Up), mods=none, physical=false, pressed=true, echo=false",
					"3" : "InputEventJoypadMotion: axis=3, axis_value=-1.00"
				},
				"backward" : {
					"1" : "InputEventKey: keycode=83 (S), mods=none, physical=true, pressed=false, echo=false",
					"2" : "InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false",
					"3" : "InputEventJoypadMotion: axis=3, axis_value=1.00"
				},
				"right" : {
					"1" : "InputEventKey: keycode=68 (D), mods=none, physical=true, pressed=false, echo=false",
					"2" : "InputEventKey: keycode=4194321 (Right), mods=none, physical=true, pressed=false, echo=false",
					"3" : "InputEventJoypadMotion: axis=0, axis_value=1.00"
				},
				"left" : {
					"1" : "InputEventKey: keycode=65 (A), mods=none, physical=true, pressed=false, echo=false",
					"2" : "InputEventKey: keycode=4194319 (Left), mods=none, physical=true, pressed=false, echo=false",
					"3" : "InputEventJoypadMotion: axis=0, axis_value=-1.00"
				},
				"brake" : {
					"1" : "InputEventKey: keycode=32 (Space), mods=none, physical=true, pressed=false, echo=false",
					"2" : "InputEventJoypadMotion: axis=4, axis_value=1.00",
					"3" : "none"
				},
				"pause" : {
					"1" : "InputEventKey: keycode=4194305 (Escape), mods=none, physical=true, pressed=false, echo=false",
					"2" : "InputEventJoypadButton: button_index=4, pressed=true, pressure=0.00",
					"3" : "none"
				},
				"restart" : {
					"1" : "InputEventKey: keycode=82 (R), mods=none, physical=true, pressed=false, echo=false",
					"2" : "InputEventJoypadButton: button_index=0, pressed=true, pressure=0.00",
					"3" : "none"
				},
				"quit" : {
					"1" : "InputEventKey: keycode=81 (Q), mods=none, physical=true, pressed=false, echo=false",
					"2" : "none",
					"3" : "none"
				},
				"reverse" : {
					"1" : "none",
					"2" : "none",
					"3" : "none"
				},
			},
		}
		file.store_line(JSON.stringify(save_dict))
		
	use_touchscreen = save_dict.use_touchscreen
	ui_size = save_dict.ui_size
	levels = save_dict.levels
	keybinds = save_dict.keybinds
	refresh_theme()
	rebind_all_actions()

func save():
	var file := FileAccess.open(global.SAVE_PATH, FileAccess.WRITE)
	var save_dict = {
		use_touchscreen = global.use_touchscreen,
		ui_size = global.ui_size,
		levels = global.levels,
		keybinds = global.keybinds,
		}
	file.store_line(JSON.stringify(save_dict))

func pause():
	if !is_gameover:
		if get_tree().paused:
			get_tree().paused = false
			if use_touchscreen:
				get_tree().root.get_node("Game").get_node("Car").get_node("Controls").visible = true
			get_tree().root.get_node("Game").get_node("PauseMenu").visible = false
		else:
			get_tree().paused = true
			if use_touchscreen:
				get_tree().root.get_node("Game").get_node("Car").get_node("Controls").visible = false
			get_tree().root.get_node("Game").get_node("PauseMenu").visible = true
			
func gameover(is_game_won):
	get_tree().paused = true
	is_gameover = true
	get_tree().root.get_node("Game").get_node("PauseMenu").visible = true
	get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("StatusLabel").text = "GAME OVER"
	get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("ButtonResume").visible = false
	if is_game_won:
		get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("TimeStatusLabel").visible = true
		var level_name = get_tree().root.get_node("Game").get_meta("level_name")
		var finish_time = get_tree().root.get_node("Game").get_node("Car").get_node("UI").get_node("StopWatchLabel").text
		levels[level_name]["is_completed"] = true
		if levels[level_name]["best_time"] == "none":
			levels[level_name]["best_time"] = finish_time
			get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("TimeStatusLabel").text = "Level completed in " + finish_time + " sec"
		else:
			if int(levels[level_name]["best_time"]) > int(finish_time):
				levels[level_name]["best_time"] = finish_time
				get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("TimeStatusLabel").text = "New best time: " + finish_time + " sec"
			else:
				get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("TimeStatusLabel").text = "Level completed in " + finish_time + " sec"
			
		save()
		get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("ButtonContinue").visible = true
		get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("StatusLabel").set("theme_override_colors/font_color", Color.GREEN)
	else:
		get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("StatusLabel").set("theme_override_colors/font_color", Color.RED)
		
func restart():
	get_tree().root.get_node("Game").get_node("PauseMenu").get_node("MainGrid").get_node("StatusLabel").set("theme_override_colors/font_color", Color.WHITE)
	global.is_gameover = false
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func refresh_theme():
	var PauseMenuTheme = preload("res://Themes/PauseMenu.tres")
	var screen_size = get_tree().get_root().size
	PauseMenuTheme.set_font_size("font_size","Button", (screen_size[1]/100)*ui_size)
	PauseMenuTheme.set_font_size("font_size","Label", (screen_size[1]/100)*ui_size*1.8)
	
	if get_tree().root.get_node_or_null("Game") != null:
		if use_touchscreen:
			get_tree().root.get_node("Game").get_node("Car").get_node("Controls").visible = true
		else:
			get_tree().root.get_node("Game").get_node("Car").get_node("Controls").visible = false

func rebind_all_actions():
	InputMap.load_from_project_settings()
	for i in InputMap.get_actions():
		if i.find("ui_") == -1:
			#print(i,":",InputMap.action_get_events(i))
			InputMap.erase_action(i)
			
	for i in keybinds:
		InputMap.add_action(i)
		for eventN in ["1", "2", "3"]:
			if keybinds[i][eventN].begins_with("InputEventKey"):
				var ev = InputEventKey.new()
				var start_sub_string = keybinds[i][eventN].find("keycode=")+8
				var end_sub_string = keybinds[i][eventN].find(" ", start_sub_string)
				
				ev.physical_keycode = int(keybinds[i][eventN].substr(start_sub_string, end_sub_string-start_sub_string))
				InputMap.action_add_event(i, ev)
			if keybinds[i][eventN].begins_with("InputEventJoypadButton"):
				var ev = InputEventJoypadButton.new()
				var start_sub_string = keybinds[i][eventN].find("button_index=")+13
				var end_sub_string = keybinds[i][eventN].find(",", start_sub_string)
				ev.button_index = int(keybinds[i][eventN].substr(start_sub_string, end_sub_string-start_sub_string))
				InputMap.action_add_event(i, ev)
			if keybinds[i][eventN].begins_with("InputEventJoypadMotion"):
				var ev = InputEventJoypadMotion.new()
				var start_sub_string = keybinds[i][eventN].find("axis=")+5
				var end_sub_string = keybinds[i][eventN].find(",", start_sub_string)
				ev.axis = int(keybinds[i][eventN].substr(start_sub_string, end_sub_string-start_sub_string))
				
				start_sub_string = keybinds[i][eventN].find("axis_value=")+11
				ev.axis_value = float(keybinds[i][eventN].substr(start_sub_string, -1))
				InputMap.action_add_event(i, ev)

func set_level(level_number,is_hardcore):
	if is_hardcore:
		hardcore = true
	get_tree().change_scene_to_packed(scenes["Level"+str(level_number)])
	get_tree().paused = false

var assets_scene = load("res://Scenes/Assets.tscn").instantiate()

var scenes = {"Menu": load("res://Scenes/Menu.tscn"), "Level1": load("res://Scenes/Level1.tscn"), "Level2": load("res://Scenes/Level2.tscn"), "Level3": load("res://Scenes/Level3.tscn"), "Level4": load("res://Scenes/Level4.tscn")}
var assets = {"Car": assets_scene.get_node("Car"), "Key": assets_scene.get_node("Key"), "PauseMenu": assets_scene.get_node("PauseMenu"), "Settings": assets_scene.get_node("Settings")}
