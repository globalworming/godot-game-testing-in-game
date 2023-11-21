extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$spawner.creature = preload("res://components/creatures/small_creature.tscn")
	$spawner.secs = 0.5
	$spawner.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
