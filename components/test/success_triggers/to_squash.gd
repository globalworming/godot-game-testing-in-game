extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = """
	to squash: %d
	""" % (get_parent().to_squash - Statistics.creatures_squashed)
