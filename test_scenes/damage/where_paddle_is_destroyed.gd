extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$tank.set_level(10)
	$flipper/paddle/Health.set_value(50, 50) 
