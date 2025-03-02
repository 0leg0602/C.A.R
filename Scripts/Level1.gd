extends Node3D


func _ready():
	if global.hardcore:
		pass
		#$SpotLight1.light_color = Color.RED
		#$SpotLight2.light_color = Color.RED
		#$SpotLight3.light_color = Color.RED
		#$SpotLight4.light_color = Color.RED
		#$SpotLight5.light_color = Color.RED
		#$SpotLight6.light_color = Color.RED
		#$car/Camera3D.queue_free()
		#var camera = Camera3D.new()
		#$Path.add_child(camera)
		#camera.global_position = Vector3(50,30,2)
		#camera.look_at(Vector3(0,0,0))
		
	var car = global.assets["Car"].duplicate()
	get_tree().root.get_node("Game").add_child(car)
	
	var key = global.assets["Key"].duplicate()
	car.add_child(key.get_child(0).duplicate())
	car.add_child(key.get_child(1).duplicate())
	$Car.position = Vector3(0,3,0)
	
	
	var pause_menu = global.assets["PauseMenu"].duplicate()
	get_tree().root.get_node("Game").add_child(pause_menu)
	
	
	global.refresh_theme()
	
func _on_trigger_1_body_entered(_body):
	$SpotLight3.visible = true
	$Arrow2.visible = true


func _on_trigger_2_body_entered(_body):
	$SpotLight4.visible = true
	$Arrow3.visible = true


func _on_trigger_3_body_entered(_body):
	$SpotLight5.visible = true


func _on_trigger_4_body_entered(_body):
	$SpotLight6.visible = true
	$Wall/Lock.visible = true



func _on_trigger_wall_open_body_shape_entered(_body_rid, body, body_shape_index, _local_shape_index):
	if body == $Car and body_shape_index == 1:
		$Wall.queue_free()


func _on_trigger_game_over_body_entered(body):
	if body == $Car:
		global.gameover(false)


func _on_trigger_finish_body_entered(body):
	if body == $Car:
		global.gameover(true)
