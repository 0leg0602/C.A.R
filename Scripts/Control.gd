extends Control

	
func _ready():
	var screen_size = get_tree().get_root().size
	$Forward.position = Vector2(0,screen_size[1]-(screen_size[1]/4)*2)
	$Forward.scale = Vector2(0.001 * screen_size[1]/4, 0.001 * screen_size[1]/4)
	
	$Back.position = Vector2(0,screen_size[1]-(screen_size[1]/4))
	$Back.scale = Vector2(0.001 * screen_size[1]/4, 0.001 * screen_size[1]/4)
	
	$Left.position = Vector2(screen_size[0]-(screen_size[1]/4)*2,screen_size[1]-screen_size[1]/4)
	$Left.scale = Vector2(0.001 * screen_size[1]/4, 0.001 * screen_size[1]/4)
	
	$Right.position = Vector2(screen_size[0]-screen_size[1]/4,screen_size[1]-screen_size[1]/4)
	$Right.scale = Vector2(0.001 * screen_size[1]/4, 0.001 * screen_size[1]/4)
	
	$Break.position = Vector2(screen_size[0]-screen_size[1]/4,screen_size[1]-(screen_size[1]/4)*2)
	$Break.scale = Vector2(0.001 * screen_size[1]/4, 0.001 * screen_size[1]/4)
	
	$Pause.position = Vector2(0,0)
	$Pause.scale = Vector2(0.001 * screen_size[1]/6, 0.001 * screen_size[1]/6)
	
		
func _process(delta):
	#$Label.text = str(Engine.get_frames_per_second())
	pass
	
	
func _on_pause_pressed():
	global.pause()
