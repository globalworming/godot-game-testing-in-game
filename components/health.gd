class_name Health extends Node2D

var current_value = 200
var max_value = 200
signal zero

func _ready() -> void:
	set_value(current_value, max_value)

func set_value(current: int, maximum: int):
	max_value = maximum
	current_value = current
	
	$progress.max_value = max_value
	$progress.value = current
	
func damage(amount: int):
	#print("%s/%s" % [$progress.value, $progress.max_value])
	if (current_value <= 0): return
	Statistics.damage_dealt += min(current_value, amount)
	current_value -= amount 
	if (current_value <= 0): zero.emit()
	$progress.value = current_value
