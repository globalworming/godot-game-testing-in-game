extends Node
const spawner = preload("res://components/creatures/spawner.tscn")
const tank = preload("res://components/creatures/tank.tscn")
const paddle_slower = preload("res://components/creatures/small_creature.tscn")

var to_clean_up: Array[Node] = []

func first():
	return Event.new(
		func (table: Node2D):
			var _spawner: Spawner = spawner.instantiate()
			_spawner.creature = tank
			_spawner.secs = 15
			_spawner.global_position = table.get_node("spawn_point1").global_position
			table.add_child(_spawner)
			_spawner.start()
			to_clean_up.push_back(_spawner)
	
			await get_tree().create_timer(3).timeout
			_spawner = spawner.instantiate()
			_spawner.creature = tank
			_spawner.secs = 13
			_spawner.global_position = table.get_node("spawn_point2").global_position
			table.add_child(_spawner)
			_spawner.start()
			to_clean_up.push_back(_spawner)
	
			await get_tree().create_timer(3).timeout
			_spawner = spawner.instantiate()
			_spawner.creature = paddle_slower
			_spawner.secs = 5
			_spawner.global_position = table.get_node("spawn_point3").global_position
			table.add_child(_spawner)
			_spawner.start()
			to_clean_up.push_back(_spawner)
			pass,
		func (table: Node2D):
			clean_up()
			pass	
	)

func clean_up():
	for node in to_clean_up:
		node.queue_free()
