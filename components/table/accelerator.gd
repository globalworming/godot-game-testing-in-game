extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	for body in get_overlapping_bodies():
		var linearVelocity: Vector2 = body.linear_velocity
		body.apply_central_force(linearVelocity.normalized() * delta * 150000)
