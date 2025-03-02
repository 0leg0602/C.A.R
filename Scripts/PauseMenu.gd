extends Control

var settings

func _ready():
	settings = global.assets["Settings"].duplicate()
	add_child(settings)


func _input(_ev):
	if settings.visible == false:
		if get_tree().paused:
			if Input.get_action_strength("restart"):
				global.restart()
			if Input.get_action_strength("quit"):
				get_tree().change_scene_to_packed(global.scenes["Menu"])
		if Input.is_action_just_pressed("pause"):
			global.pause()
	
			

func _on_button_restart_pressed():
	global.restart()

func _on_button_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(global.scenes["Menu"])

func _on_button_continue_pressed():
	var level_name = get_tree().get_current_scene().get_meta("level_name")
	global.set_level(int(level_name.substr(5,level_name.length()-5))+1,false)
	


func _on_button_resume_pressed():
	global.pause()


func _on_button_settings_pressed():
	get_node("MainGrid").visible = false
	get_node("Settings").visible = true
