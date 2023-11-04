extends Node2D


@onready var body = $big_creature_body
@onready var collider = $big_creature_body/collision
@onready var puddle = $big_creature_body/Puddle
@onready var sprite = $big_creature_body/Creature
@export_range(0.0, 1000.0) var mass: float = 1.0
@export var health: float = 20.0
@export_node_path("Path2D") var route
var node_to_follow: PathFollow2D
var squashed = false

func _ready() -> void:
	if route != null:
		var route_to_follow = get_node(route)
		node_to_follow = PathFollow2D.new()
		node_to_follow.loop = false
		route_to_follow.add_child(node_to_follow)
		
func squash():
	if squashed: return
	squashed = true
	puddle.visible = true
	sprite.visible = false
	body.set_deferred("freeze", true)
	collider.set_deferred("disabled", true)
	Statistics.creatures_squashed += 1	
	await get_tree().create_timer(1).timeout
	get_parent().remove_child(self)

func _process(_delta: float) -> void:
	if health <= 0:
		squash()
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
		body.apply_torque(20) 
	if (difference < 0):
		body.apply_torque(-20) 
				
	if (abs(difference) > PI/4):
		body.apply_central_force((body.global_position - node_to_follow.global_position).normalized() * delta * 20000) 	
				
	
