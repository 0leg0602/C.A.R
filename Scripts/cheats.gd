extends PanelContainer

var option_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_button = $VBoxContainer/LevelLoader/LevelOptionButton
	for i in global.levels:
		option_button.add_item(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_setlevel_button_pressed() -> void:
	global.set_level(option_button.selected+1,false)
	
