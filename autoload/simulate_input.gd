extends Node

func tap(action: StringName):
	var a = InputEventAction.new()
	a.action = action
	a.pressed = true
	Input.parse_input_event(a)
	await get_tree().create_timer(0.1).timeout
	a = InputEventAction.new()
	a.action = action
	a.pressed = false
	Input.parse_input_event(a)
	

func wait(f):
	return get_tree().create_timer(f).timeout
