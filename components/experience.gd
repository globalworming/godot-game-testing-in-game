extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_collision_delayed()
	
func enable_collision_delayed():
	await get_tree().create_timer(1).timeout
	var body = $body
	body.collision_layer = 1
	body.collision_mask = 1
	body.mass=0.01
