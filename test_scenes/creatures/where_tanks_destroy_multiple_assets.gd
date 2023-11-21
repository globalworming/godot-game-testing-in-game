extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	($flipper.find_child("Health", true) as Health).set_value(100, 100)
	for bumper in find_children("big_bumper*"):
		(bumper.find_child("Health", true) as Health).set_value(10, 10)
	
