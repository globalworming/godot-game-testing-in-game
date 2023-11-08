extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	print(body.name)
	var angle = global_position.angle_to(body.global_position)
	$RigidBody2D.apply_central_impulse(Vector2.from_angle(angle - PI/2).normalized() * 3000)
	pass # Replace with function body.
