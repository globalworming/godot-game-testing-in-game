extends Node2D

var events = [Events.first()]
var current_event: Event;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	current_event = events.pop_front();
	current_event.start.call(self)
	Statistics.next_minute.connect(next_event)

func next_event():
	current_event.stop.call(self)
	current_event = events.pop_front();
	current_event.start.call(self)
