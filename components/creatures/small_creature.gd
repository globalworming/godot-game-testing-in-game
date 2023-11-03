extends Node2D


@onready var body = $body
@onready var collider = $body/collision
@onready var squasher = $body/squash_area/CollisionShape2D
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
	

func _on_ball_in_vicinity(_ball: RigidBody2D) -> void:
	#var ball_mass = ball.mass
	#var my_mass = body.mass
	##print("""
	##my mass %f
	##ball mass %f
	##""" % [my_mass, ball_mass])
	#var am_i_sqashable = ball_mass * 5 > my_mass
	#if am_i_sqashable: 
	#	collider.set_deferred("disabled", true)
	#	squasher.set_deferred("disabled", false)
	#else:
	#	collider.set_deferred("disabled", false)
	#	squasher.set_deferred("disabled", true)
	pass


		
func squash():
	if squashed: return
	squashed = true
	$body/Puddle.visible = true
	$body/Creature.visible = false
	body.set_deferred("freeze", true)
	squasher.set_deferred("disabled", true)
	Statistics.creatures_squashed += 1	
	await get_tree().create_timer(1).timeout
	get_parent().remove_child(self)

func _process(_delta: float) -> void:
	if health <= 0:
		squash()
	if (route != null):
		advance_route(_delta)		
		
#func _physics_process(_delta: float) -> void:
		
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
	
	#if (abs(difference) < deg_to_rad(15) ): 
	#	body.lock_rotation = true
	#else:		
	#	body.lock_rotation = false
		
	#if (difference > 0):
	#	body.apply_torque(20) 
	#if (difference < 0):
	#	body.apply_torque(-20) 
				
	if (abs(difference) > PI/4):
		body.apply_central_force((body.global_position - node_to_follow.global_position).normalized() * delta * 20000) 	
				
	
