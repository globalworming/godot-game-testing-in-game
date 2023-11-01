extends Node


var tests: Array[String]
var next_test: Node

func _ready():
	TestStatus.test_success.connect(_test_success)
	var dirs = Files.list_dirs("res://test_scenes")
	tests = list_tests(dirs)
	tests.sort()
	next()

func _test_success():
	next()

func next(): 
	var _next = tests.pop_front();
	if _next != null: 
		print("run test " + _next)
		Statistics.reset()
		if next_test != null: 
			call_deferred("remove_child", next_test)
		next_test = load(_next).instantiate()
		call_deferred("add_child", next_test)
	else:
		print("success")
		get_tree().quit(0)
		
func list_tests(paths: Array[String]) -> Array[String]: 
	var test_paths: Array[String] = [];
	for path in paths:
		test_paths.append_array(Files.list_files(path, "where", "tscn"))
	return test_paths;
