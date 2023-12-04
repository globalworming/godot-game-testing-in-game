class_name Event extends Node


var start: Callable
var stop: Callable
var difficulty: int

func _init(_difficulty, _start: Callable, _stop: Callable):
	start = _start
	stop = _stop
	difficulty = _difficulty
