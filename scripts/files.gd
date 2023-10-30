extends Node
class_name Files


static func list_dirs(path) -> Array[String]: 
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

static func list_files(path, startsWith, endsWith) -> Array[String]: 
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

	
