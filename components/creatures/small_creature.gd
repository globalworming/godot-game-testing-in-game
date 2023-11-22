extends RigidBody2D


@onready var squasher = $squash_area/CollisionShape2D
@export var health: float = 20.0
var route: Path2D
var node_to_follow: PathFollow2D
var is_squashed = false
var experience = preload("res://components/experience.tscn")

signal squashed

func _process(_delta: float) -> void:
	if route == null:
		var routes = get_parent().find_children("*", "Path2D")
		if routes.size() == 0: return 
		routes.sort_custom(closest)
		route = routes[0]
		node_to_follow = PathFollow2D.new()
		node_to_follow.loop = false
		route.add_child(node_to_follow)
		return
		

func closest(a:Path2D, b: Path2D):
	return (a.curve.get_baked_points()[0] + a.global_position).distance_to(global_position) < (b.curve.get_baked_points()[0] + b.global_position).distance_to(global_position)

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
	if (route != null && node_to_follow != null):
		advance_route()
		Movement.rotate_to(delta, node_to_follow, self, 100000, 5)
		Movement.move_towards(delta, node_to_follow, self, 1000000)

		
func advance_route():
	if node_to_follow.progress_ratio >= 1: node_to_follow.queue_free(); return
	var distance_to_follow_node = global_position.distance_to(node_to_follow.global_position)
	if (distance_to_follow_node < 100):
		node_to_follow.progress += 50
	
