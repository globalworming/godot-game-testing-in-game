extends Node

var creatures_squashed = 0
var damage_dealt = 0

func reset():
	creatures_squashed = 0
	damage_dealt = 0

func _to_string() -> String:
	return """
	creatures_squashed %d
	damage_dealt %d
	""" % [
		creatures_squashed, damage_dealt
	]
