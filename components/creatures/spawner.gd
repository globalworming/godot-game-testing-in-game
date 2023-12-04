class_name Spawner extends Node2D

@export var creature: Resource = preload("res://components/creatures/small_creature.tscn")
var secs = 1
var offset
@export var autostart = false
var started = false

## number of creatures to spawn before stopping, 0 meaning infinite
@export var max_spawns = 0
var spawns = 0

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
	if max_spawns > 0 && spawns >= max_spawns: return
	var to_spawn = creature.instantiate() as Node2D
	to_spawn.position = position
	get_parent().add_child(to_spawn)
	spawns += 1
	
