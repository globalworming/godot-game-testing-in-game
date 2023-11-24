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
	($switch_on if enabled else $switch_off).play()
	$body/indicator.color = Color.DEEP_PINK if enabled else Color.CORNFLOWER_BLUE
