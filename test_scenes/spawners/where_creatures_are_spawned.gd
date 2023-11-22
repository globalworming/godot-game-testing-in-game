extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$spawner.creature = preload("res://components/creatures/small_creature.tscn")
	$spawner.secs = 0.5
	$spawner.start()
