extends RigidBody2D


@onready var squasher = $squash_area/CollisionShape2D
@export var health: float = 20.0
@export_node_path("Path2D") var route
var node_to_follow: PathFollow2D
var is_squashed = false
var experience = preload("res://components/experience.tscn")

signal squashed

func _ready() -> void:
	if route != null:
		var route_to_follow = get_node(route)
		node_to_follow = PathFollow2D.new()
		node_to_follow.loop = false
		route_to_follow.add_child(node_to_follow)
		
func squash():
	if is_squashed: return
	is_squashed = true
	squashed.emit()
	Statistics.creatures_squashed += 1	
	disable_any_interactions()
	$Puddle.visible = true
	$Creature.visible = false
	$crack.play()
	await get_tree().create_timer(1).timeout
	get_parent().remove_child(self)
	
func disable_any_interactions():
	collision_layer = 0
	set_deferred("freeze", true)
	squasher.set_deferred("disabled", true)

func _process(_delta: float) -> void:
	if (route != null):
		advance_route(_delta)
		
func advance_route(delta):
	var distance_to_follow_node = global_position.distance_to(node_to_follow.global_position)
	
	if (distance_to_follow_node < 100):
		node_to_follow.progress += 15
	rotate_to_follow_node(delta)
	move_towards_follow_node(delta)
	
func move_towards_follow_node(delta):
	if (linear_velocity.length() <= 500):
		apply_central_force((global_position - node_to_follow.global_position).normalized() * delta * -300000) 
	else: linear_velocity = linear_velocity.normalized() * 500
	

func rotate_to_follow_node(delta):
	var target_rotation = global_position.angle_to_point(node_to_follow.global_position) -PI / 2
	var difference = fmod(target_rotation - rotation, PI)
	
	if (abs(difference) < deg_to_rad(15) ): 
		lock_rotation = true
	else:		
		lock_rotation = false
		
	if (difference > 0):
		apply_torque(100) 
	if (difference < 0):
		apply_torque(-100) 
				
	if (abs(difference) > PI/4):
		apply_central_force((global_position - node_to_follow.global_position).normalized() * delta * 20000) 
