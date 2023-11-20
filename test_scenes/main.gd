extends Node


var tests: Array[String]
var next_test: Node
var my_instance_number: int
var number_of_instances: int
var _instance_socket: TCPServer = TCPServer.new()
var resized = false;

func _ready():
	TestStatus.test_success.connect(_test_success)
	TestStatus.test_error.connect(func ():
		push_error("failed ", next_test.name)
		_test_success()
	)
	var dirs = Files.list_dirs("res://test_scenes")
	tests = list_tests(dirs)
	tests.sort()
	find_my_instance()
	short_wait_then_next()
	
func _test_success():
	next()

func next(): 
	if number_of_instances > 1 && !resized:
		adjust_screen()
		resized = true 
	Statistics.reset()
	
	if (next_test != null): 
		for n in range(0, number_of_instances - 1):
			# discard next n, other instances run this
			tests.pop_front()
			
	var _next = tests.pop_front();
	if _next != null: 
		print("run test " + _next)
		
		if next_test:
			call_deferred("remove_child", next_test)
		
		next_test = load(_next).instantiate()
		var label = Label.new()
		label.text = _next
		label.label_settings = load("res://label_settings/some_other_setting.tres")
		next_test.add_child(label)
		call_deferred("add_child", next_test)
	else:
		get_tree().quit(0)


func next_offset(): 
	#print("my instance ", my_instance_number)
	number_of_instances = find_number_of_instances()
	#print("total instances ", number_of_instances)
	assert(number_of_instances > 0, "Unable to determine instances number")	
		
	for n in range(0, my_instance_number - 1):
		# discard first n
		tests.pop_front()
	next()

		
func list_tests(paths: Array[String]) -> Array[String]: 
	var test_paths: Array[String] = [];
	for path in paths:
		test_paths.append_array(Files.list_files(path, "where", "tscn"))
	return test_paths;

func short_wait_then_next():
	await get_tree().create_timer(0.3).timeout
	next_offset()

func find_my_instance():
	for n in range(1,5):
		if _instance_socket.listen(5000 + n) == OK:
			my_instance_number = n
			break
	assert(my_instance_number > 0, "Unable to determine instance number. Seems like all TCP ports are in use")	
	
func find_number_of_instances() -> int:
	var _instances_socket: TCPServer = TCPServer.new()
	for n in range(4,0,-1):
		if _instances_socket.listen(5000 + n) == ERR_ALREADY_IN_USE:
			return n
		else:
			_instances_socket.stop()
	return 0

func adjust_screen():
	get_window().mode = Window.MODE_WINDOWED
	var size = DisplayServer.window_get_size() * 0.5
	DisplayServer.window_set_max_size(size)
	if (my_instance_number == 1):
		DisplayServer.window_set_position(Vector2i(0,0))
	if (my_instance_number == 2):
		DisplayServer.window_set_position(Vector2i(size.x,0))
	if (my_instance_number == 3):
		DisplayServer.window_set_position(Vector2i(0,size.y))
	if (my_instance_number == 4):
		DisplayServer.window_set_position(Vector2i(size.x,size.y))
		
	
