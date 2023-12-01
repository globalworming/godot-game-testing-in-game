class_name Spawner extends Node2D

@export var creature: Resource = preload("res://components/creatures/small_creature.tscn")
var secs = 0.5
var offset
@export var autostart = false
var started = false

func _ready() -> void:
	$Timer.timeout.connect(spawn)
	if autostart: start()

func start():
	$Timer.start(secs)
	started = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !started: return 
	$progress.max_value =  $Timer.wait_time * 100
	$progress.value = 100 * ($Timer.wait_time - $Timer.time_left)
	pass

func spawn():
	var to_spawn = creature.instantiate() as Node2D
	to_spawn.position = position
	get_parent().add_child(to_spawn)
	
