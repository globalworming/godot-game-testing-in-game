extends Node2D


@onready var body = $body
@onready var squasher = $body/squash_area/CollisionShape2D
@export_range(0.0, 1000.0) var mass: float = 1.0
@export var health: float = 20.0
@export_node_path("Path2D") var route
var node_to_follow: PathFollow2D
var squashed = false
var experience = preload("res://components/experience.tscn")

func _ready() -> void:
	if route != null:
		var route_to_follow = get_node(route)
		node_to_follow = PathFollow2D.new()
		node_to_follow.loop = false
		route_to_follow.add_child(node_to_follow)
		
func squash():
	if squashed: return
	Statistics.creatures_squashed += 1	
	var _experience = experience.instantiate()
	_experience.global_position = global_position
	get_parent().call_deferred("add_child", _experience)
	_experience.get_node("body").apply_central_impulse(
		Vector2.from_angle(randf_range(0, 2 * PI)) * 1000)	
	disable_any_interactions()
	$body/Puddle.visible = true
	$body/Creature.visible = false
	await get_tree().create_timer(1).timeout
	get_parent().remove_child(self)
	

func disable_any_interactions():
	squashed = true
	body.set_deferred("freeze", true)
	squasher.set_deferred("disabled", true)

func _process(_delta: float) -> void:
	if (route != null):
		advance_route(_delta)
		
func advance_route(delta):
	var distance_to_follow_node = body.global_position.distance_to(node_to_follow.global_position)
	
	if (distance_to_follow_node < 100):
		node_to_follow.progress += 15
	rotate_to_follow_node(delta)
	move_towards_follow_node(delta)
	
func move_towards_follow_node(delta):
	if (body.linear_velocity.length() <= 500):
		body.apply_central_force((body.global_position - node_to_follow.global_position).normalized() * delta * -300000) 
	else: body.linear_velocity = body.linear_velocity.normalized() * 500
	

func rotate_to_follow_node(delta):
	var target_rotation = body.global_position.angle_to_point(node_to_follow.global_position) -PI / 2
	var difference = fmod(target_rotation - body.rotation, PI)
	
	if (abs(difference) < deg_to_rad(15) ): 
		body.lock_rotation = true
	else:		
		body.lock_rotation = false
		
	if (difference > 0):
		body.apply_torque(100) 
	if (difference < 0):
		body.apply_torque(-100) 
				
	if (abs(difference) > PI/4):
		body.apply_central_force((body.global_position - node_to_follow.global_position).normalized() * delta * 20000) 
