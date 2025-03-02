extends ScrollContainer

var levels_container
var MenuTheme

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	levels_container = $HBoxContainer
	MenuTheme = preload("res://Themes/Menu.tres")
	
	var previous_item
	
	for i in global.levels:
		var level_number = i.substr(5,i.length()-5)
		
		var level_container = VBoxContainer.new()
		level_container.name = i+"VBoxContainer"
		levels_container.add_child(level_container)
		
		var level_button = Button.new()
		level_button.name = i+"Button"
		level_button.text = level_number
		level_button.theme = MenuTheme
		level_button.focus_mode = Control.FOCUS_NONE
		if previous_item == null or global.levels[previous_item]["is_completed"]:
			level_button.disabled = false
		else:
			level_button.disabled = true
		level_container.add_child(level_button)
		level_button.connect("pressed", func(): button_press(level_number))
		
		var level_label = Label.new()
		level_button.name = i+"Label"
		if global.levels[i]["is_completed"]:
			level_label.text = "Best time: " + str(global.levels[i]["best_time"])
		else:
			level_label.text = "Not completed"
		level_container.add_child(level_label)
		
		var level_separator = VSeparator.new()
		level_separator.name = i+"VSeparator"
		levels_container.add_child(level_separator)
		
		
		print(i,global.levels[i])
		previous_item = i
	levels_container.get_child(-1).queue_free()

func button_press(level_number):
	global.set_level(int(level_number),false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
