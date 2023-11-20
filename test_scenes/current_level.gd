extends Label

func _ready() -> void:
	Experience.level_up.connect(update)
	update()

func update():
	text = "level %s" % Experience.level()
