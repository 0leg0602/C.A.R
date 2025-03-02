extends Control

var screen_size
var settings


func _ready():
	var myTheme = preload("res://Themes/Menu.tres")
	screen_size = get_tree().get_root().size
	myTheme.set_font_size("font_size","Button", (screen_size[1]/100)*global.ui_size)
	$MainGrid/ButtonTitle.add_theme_font_size_override("font_size", (screen_size[1]/100)*global.ui_size*2)
	
	settings = global.assets["Settings"].duplicate()
	get_tree().root.get_node("Menu").add_child(settings)
	
	$VersionLabel.text = ProjectSettings.get_setting("application/config/version")
	

func _on_button_title_pressed():
	if $MainGrid/ButtonTitle.text == "C.A.R":
		if global.ui_size > 4:
			$MainGrid/ButtonTitle.add_theme_font_size_override("font_size", (screen_size[1]/100)*4)
		$MainGrid/ButtonTitle.text = "Center for automotive research"
	else:
		$MainGrid/ButtonTitle.add_theme_font_size_override("font_size", (screen_size[1]/100)*global.ui_size*2)
		$MainGrid/ButtonTitle.text = "C.A.R"


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_levels_pressed():
	$MainGrid/LevelsScrollContainer.visible = !$MainGrid/LevelsScrollContainer.visible

func _input(ev):
	if ev is InputEventKey and settings.visible == false:
		if ev.pressed:
			if Input.get_action_strength("quit") == 1:
				get_tree().quit()
				
			if ev.keycode == KEY_1:
				global.set_level(1,false)
			if ev.keycode == KEY_F1:
				global.set_level(1,true)
				
			if global.levels["level1"]["is_completed"]:
				if ev.keycode == KEY_2:
					global.set_level(2,false)
				if ev.keycode == KEY_F2:
					global.set_level(2,true)
			if global.levels["level2"]["is_completed"]:
				if ev.keycode == KEY_3:
					global.set_level(3,false)
				if ev.keycode == KEY_F3:
					global.set_level(3,true)


func _on_button_settings_pressed():
	settings.visible = true
	$MainGrid.visible = false
