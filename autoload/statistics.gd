extends Node

var creatures_squashed = 0
var damage_dealt = 0
var experience_collected = 0
var player_assets_destroyed = 0
var start_time_msec = Time.get_ticks_msec()
var current_minute: int = 0

signal next_minute

func reset():
	creatures_squashed = 0
	damage_dealt = 0
	experience_collected = 0
	player_assets_destroyed = 0
	start_time_msec = Time.get_ticks_msec()

func _process(_delta: float) -> void:
	var _current_minute = floor(time_passed_msec() / 1000 / 60)
	if (_current_minute > current_minute):
		next_minute.emit()
		current_minute = current_minute

func time_passed_msec(): return Time.get_ticks_msec() - start_time_msec
func minutes_passed(): return  int(float(time_passed_msec()) / 1000 / 60)

func _to_string() -> String:
	return """
	creatures_squashed %d
	damage_dealt %d
	experience_collected %d
	player_assets_destroyed %d
	time_passed %d
	""" % [
		creatures_squashed, 
		damage_dealt, 
		experience_collected, 
		player_assets_destroyed, 
		time_passed_msec()
	]
