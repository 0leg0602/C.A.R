extends Node3D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(2):
		var random_barrier_number = rng.randi_range(1, 3)
		match random_barrier_number:
			1:
				print("1")
				if $Barrier1:
					$Barrier1.queue_free()
			2:
				print("2")
				if $Barrier2:
					$Barrier2.queue_free()
			3:
				print("3")
				if $Barrier3:
					$Barrier3.queue_free()
			_:
				print("ERROR")
	
	print("Done\n")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
