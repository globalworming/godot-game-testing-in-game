extends Node2D

var _timer

# Called when the node enters the scene tree for the first time.
func _ready():
	_timer = Timer.new()
	_timer.autostart = true
	_timer.connect("timeout", _on_Timer_timeout)
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	add_child(_timer)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#Input.action_press("move_left")
	pass
	
func _on_Timer2_timeout():
	Input.action_release("move_left")
	
func _on_Timer_timeout():
	Input.action_press("move_left")
	var _timer2 = Timer.new()
	_timer2.autostart = true
	_timer2.connect("timeout", _on_Timer2_timeout)
	_timer2.set_wait_time(.2)
	_timer2.set_one_shot(true) # Make sure it loops
	add_child(_timer2)
