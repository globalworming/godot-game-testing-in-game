extends Node2D

@export var rate = 150.0
@export_file("creature.tscn") var _creature = "res://components/creatures/small_creature.tscn"
@onready var creature = load(_creature)
var timer = Timer.new()
@export_node_path("Path2D") var route


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(spawn)
	timer.autostart = true;
	timer.wait_time = 100.0 / rate
	add_child(timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(timer.wait_time, " ", timer.time_left, " ",  timer.wait_time / timer.time_left)
	$Circle.rotation = -2*PI * timer.time_left / timer.wait_time
	pass

func spawn():
	var to_spawn = creature.instantiate()
	to_spawn.route = NodePath("../../" + route.get_name(route.get_name_count() - 1))
	add_child(to_spawn)
	to_spawn.scale = Vector2(0.01, 0.01)
	pass
