extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = """
	player assets destroyed %d/%d
	""" %   [Statistics.player_assets_destroyed, get_parent().player_assets_to_destroy]
