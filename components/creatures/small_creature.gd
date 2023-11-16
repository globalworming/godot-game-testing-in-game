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

func _physics_process(delta: float) -> void:
	if (route != null):
		advance_route()
		Movement.rotate_to(delta, node_to_follow, self, 100000, 5)
		Movement.move_forward(delta, self, 1000000)

		
func advance_route():
	var distance_to_follow_node = global_position.distance_to(node_to_follow.global_position)
	if (distance_to_follow_node < 100):
		node_to_follow.progress += 50
