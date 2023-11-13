extends Area2D

@export_node_path("Node2D") var exit
@onready var _exit: Node2D = get_node(exit)
var to_tunnel: RigidBody2D
var exited: bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !to_tunnel: pick_body_to_tunnel()
	if to_tunnel: tunnel(delta)

func pick_body_to_tunnel():
	for body in get_overlapping_bodies():
		if !body.is_in_group("ball"): return
		if !(body is RigidBody2D): return
		if !body.linear_velocity.length() < 512: return 
		if (body.global_position.distance_to(global_position) < 32):
			body.freeze = true
			body.global_position = global_position
			to_tunnel = body
			exited = false

func tunnel(delta):
	if exited:
		var new_scale = to_tunnel.scale * (1 + 3 * delta)
		if (new_scale.length() > Vector2.ONE.length()): 
			to_tunnel.scale = Vector2.ONE
			to_tunnel.freeze = false
			to_tunnel = null
			return
		to_tunnel.scale = new_scale
		return
	var new_scale = to_tunnel.scale * (1 - 3 * delta)
	if new_scale.length() < 0.1: 
		exited = true
		to_tunnel.global_position = _exit.global_position
	to_tunnel.scale = to_tunnel.scale * (1 - 3 * delta)
	
