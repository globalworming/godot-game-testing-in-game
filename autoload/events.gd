extends Node
const spawner = preload("res://components/creatures/spawner.tscn")
const tank = preload("res://components/creatures/tank.tscn")
const paddle_slower = preload("res://components/creatures/small_creature.tscn")

var to_clean_up: Array[Node] = []


func random():
	var _events = []
	for i in range (0, 15):
		_events.push_back(Events.random_of_dificulty(i))
	return _events

func random_of_dificulty(i):
	var _events = events.filter(
		func (e: Event): 
			return e.difficulty == i
	)
	if (_events.size() == 0): return null
	return _events.pick_random()

var events = [
Event.new(
	0,
	func (table: Node2D):
		var _spawner1: Spawner = spawner.instantiate()
		_spawner1.creature = tank
		_spawner1.secs = 15
		_spawner1.global_position = table.get_node("spawn_point1").global_position
		table.add_child(_spawner1)
		_spawner1.start()
		to_clean_up.push_back(_spawner1)

		await get_tree().create_timer(3).timeout
		var _spawner2 = spawner.instantiate()
		_spawner2.creature = tank
		_spawner2.secs = 13
		_spawner2.global_position = table.get_node("spawn_point2").global_position
		table.add_child(_spawner2)
		_spawner2.start()
		to_clean_up.push_back(_spawner2)

		await get_tree().create_timer(3).timeout
		var _spawner3 = spawner.instantiate()
		_spawner3.creature = paddle_slower
		_spawner3.secs = 5
		_spawner3.global_position = table.get_node("spawn_point3").global_position
		table.add_child(_spawner3)
		_spawner3.start()
		to_clean_up.push_back(_spawner3)
		pass,
	func (_table: Node2D):
		clean_up()
		pass
),
Event.new(
	1,
	func (table: Node2D):
		var _spawner1: Spawner = spawner.instantiate()
		_spawner1.creature = tank
		_spawner1.secs = 15
		_spawner1.global_position = table.get_node("spawn_point1").global_position
		table.add_child(_spawner1)
		_spawner1.start()
		to_clean_up.push_back(_spawner1)

		await get_tree().create_timer(3).timeout
		var _spawner2 = spawner.instantiate()
		_spawner2.creature = tank
		_spawner2.secs = 13
		_spawner2.global_position = table.get_node("spawn_point2").global_position
		table.add_child(_spawner2)
		_spawner2.start()
		to_clean_up.push_back(_spawner2)

		await get_tree().create_timer(3).timeout
		var _spawner3 = spawner.instantiate()
		_spawner3.creature = paddle_slower
		_spawner3.secs = 5
		_spawner3.global_position = table.get_node("spawn_point3").global_position
		table.add_child(_spawner3)
		_spawner3.start()
		to_clean_up.push_back(_spawner3)
		pass,
	func (_table: Node2D):
		clean_up()
		pass
)
]

func clean_up():
	for node in to_clean_up:
		if (node != null):
			if (!node.is_queued_for_deletion()): node.queue_free()
