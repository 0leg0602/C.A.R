extends Node3D

var chosen_way = "none"

func _ready():
	
	
	
	if global.hardcore:
		pass
		#$SpotLight1.light_color = Color.RED
		#$SpotLight2.light_color = Color.RED
		#$SpotLight3.light_color = Color.RED
		#$SpotLight4.light_color = Color.RED
		#$SpotLight5.light_color = Color.RED
		#$SpotLight6.light_color = Color.RED
		#$Platform1/SpotLightPlatform1.light_color = Color.RED
		#$Platform1/SpotLightPlatform1.light_energy = 0.2
		#$Platform1/SpotLightPlatform1.spot_angle = 35
		#$Platform2/SpotLightPlatform1.light_color = Color.RED
		#$Platform2/SpotLightPlatform1.spot_angle = 35
		#$Platform3/SpotLightPlatform1.light_color = Color.RED
		#$Platform3/SpotLightPlatform1.spot_angle = 35
		#$car/Camera3D.queue_free() 
		#var camera = Camera3D.new()
		#$Path.add_child(camera)
		#camera.global_position = Vector3(50,30,2)
		#camera.look_at(Vector3(0,0,0))
		
	$Path.create_trimesh_collision()
	var car = global.assets["Car"].duplicate()
	get_tree().root.get_node("Game").add_child(car)
	$Car.position = Vector3(0,3,0)
	
	var pause_menu = global.assets["PauseMenu"].duplicate()
	get_tree().root.get_node("Game").add_child(pause_menu)
	
	global.refresh_theme()



func _physics_process(delta):
	pass


func _on_trigger_game_over_body_entered(body):
	if body == $Car:
		global.gameover(false)


func _on_trigger_finish_body_entered(body):
	if body == $Car:
		global.gameover(true)





func _on_light_trigger_1_body_entered(body):
	if body == $Car:
		$SpotLight3.visible = true


func _on_light_trigger_2_body_entered(body):
	if body == $Car:
		$SpotLight4.visible = true


func _on_light_trigger_3_body_entered(body):
	if body == $Car:
		$SpotLight5.visible = true


func _on_wall1_trigger_body_entered(body):
	if body == $Car:
		if chosen_way == "none":
			$StaticWall2.queue_free()
			$CorrectWay.position = Vector3(18.991, 5.825, 58.893)
			$CorrectWay.rotation_degrees = Vector3(0, 35, 0)
			chosen_way = "right"
			
			#$CorrectWay/PlatformAnimation.play("RESET")
			#$CorrectWay/Platform.rotation_degrees = Vector3(0, 0, 0)

		if chosen_way == "left":
			$CorrectWay/CorrectWaySpotLight1.visible = true
		else:
			$StaticWall1/WallSpotLight.visible = true
			$StaticWall1/WallText.visible = true



func _on_wall2_trigger_body_entered(body):
	if body == $Car:
		if chosen_way == "none":
			$StaticWall1.queue_free()
			$CorrectWay.position  = Vector3(-18.991, 5.825, 58.893)
			$CorrectWay.rotation_degrees = Vector3(0, -35, 0)
			chosen_way = "left"
			
			#$CorrectWay/PlatformAnimation.play("RESET")
			#$CorrectWay/Platform.rotation_degrees = Vector3(0, 0, 0)
		if chosen_way == "right":
			$CorrectWay/CorrectWaySpotLight1.visible = true
		else:
			$StaticWall2/WallSpotLight.visible = true
			$StaticWall2/WallText.visible = true


func _on_light_trigger_4_body_entered(body):
	if body == $Car:
		$SpotLight6.visible = true


func _on_light_trigger_5_body_entered(body):
	if body == $Car:
		$SpotLight7.visible = true


func _on_correct_way_light_trigger_1_body_entered(body):
	if body == $Car:
		$CorrectWay/CorrectWaySpotLight2.visible = true
		$CorrectWay/Path3D/PathFollow3D/Platform/PlatformSpotLight1.visible = true
		$CorrectWay/Path3D/PathFollow3D/Platform/PlatformSpotLight2.visible = true
		$CorrectWay/Path3D/PathFollow3D/Platform/PlatformSpotLight3.visible = true
		$CorrectWay/PushCube/BoxMesh/TextMesh.visible = true
		
		$CorrectWay/help_lights/help_lights1.visible = true
		
		#$CorrectWay/PlatformAnimation.get_animation("PlatformMove").track_insert_key(0, 0, $TableOfContents4/TableOfContentsBlock5.position)
		#$CorrectWay/PlatformAnimation.play("PlatformMove")


func _on_on_platform_trigger_1_body_exited(body):
	if body == $CorrectWay/PushCube:
		if $Car in $CorrectWay/Path3D/PathFollow3D/Platform/OnPlatformTrigger1.get_overlapping_bodies():
			$CorrectWay/PlatformAnimation.play("PlatformMove")


func _on_wall_3_trigger_1_body_entered(body):
	if body == $CorrectWay/Path3D/PathFollow3D/Platform:
		$CorrectWay/StaticWall3/WallAnimation.play("Show")
