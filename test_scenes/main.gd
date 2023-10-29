extends Node


var tests: Array[String]
var next_test: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	TestStatus.test_success.connect(_test_success)
	print("main ready")
	var dirs = list_dirs("res://test_scenes")
	tests = list_tests(dirs)
	next()

func _test_success(): 
	next()

func next(): 
	var _next = tests.pop_front();
	if _next != null: 
		print("run test " + _next)
		if next_test != null: 
			call_deferred("remove_child", next_test)
		next_test = load(_next).instantiate()
		call_deferred("add_child", next_test)
	else:
		print("success")
		get_tree().quit(0)
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func list_tests(paths: Array[String]) -> Array[String]: 
	var test_paths: Array[String] = [];
	for path in paths:
		test_paths.append_array(list_files(path, "where", "tscn"))
		
		
	return test_paths;

func list_dirs(path) -> Array[String]: 
	var dir = DirAccess.open(path)
	var dirs: Array[String] = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				#print("Found directory: " + file_name)
				dirs.append(path + "/" + file_name)
				dirs.append_array(list_dirs(path + "/" + file_name))
			file_name = dir.get_next()
		return dirs
	else:
		assert(false, "bad dir")
		print("An error occurred when trying to access the path.")
		return dirs

func list_files(path, startsWith, endsWith) -> Array[String]: 
	var dir = DirAccess.open(path)
	var files: Array[String] = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			#print("Found file " + file_name)			
			if !dir.current_is_dir() && file_name.begins_with(startsWith) && file_name.ends_with(endsWith):
				#print("Found test " + file_name)				
				files.append(path + "/" + file_name)
			file_name = dir.get_next()
		return files
	else:
		assert(false, "bad dir")
		print("An error occurred when trying to access the path.")
		return []

	
