extends Node3D



var car
func _ready():
	#$DoorsAnimation.play("RESET")
	
	if global.hardcore:
		pass
		
		
	car = global.assets["Car"].duplicate()
	get_tree().root.get_node("Game").add_child(car)
	car.position = Vector3(0,3,0)
	
	var pause_menu = global.assets["PauseMenu"].duplicate()
	get_tree().root.get_node("Game").add_child(pause_menu)
	
	global.refresh_theme()

func _physics_process(delta):
	pass

func _on_trigger_game_over_body_entered(body):
	if body == car:
		global.gameover(false)


func _on_light_trigger_1_body_entered(body: Node3D) -> void:
	if body == car:
		$SpotLight2.visible = true
		$SpotLight3.visible = true
		$Door1/Lock.visible = true
		$Door1/DoorSpotLight.visible = true


func _on_door_trigger_body_entered(body: Node3D) -> void:
	if body == $Ball1:
		$DoorsAnimation.play("Door1Disintegration")


func _on_doors_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Door1Disintegration":
		$DoorsAnimation.play("Door1Disintegration")
		$DoorsAnimation.play("RESET")
		$Door1.queue_free()
		$Ball1.queue_free()
