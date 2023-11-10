extends Node2D

@export var enabled: bool = false
var prevent_switch_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prevent_switch_timer.autostart = false
	prevent_switch_timer.one_shot = true
	add_child(prevent_switch_timer)


func switch():
	if !prevent_switch_timer.is_stopped(): return
	prevent_switch_timer.start(0.1)
	enabled = !enabled
	$indicator.color = Color(1, 0.2, 0.2) if enabled else Color( 0.1, 0.1, 0,1)
