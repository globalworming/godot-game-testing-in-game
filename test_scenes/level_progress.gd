extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Experience.experience_gained.connect(update)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update() -> void:
	value = Experience.experience % 100
