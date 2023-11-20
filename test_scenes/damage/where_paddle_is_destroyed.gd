extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$flipper/paddle/Health.set_value(50, 50) 
