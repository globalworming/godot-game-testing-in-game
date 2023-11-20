class_name Health extends Node2D

@export var current_value = 0
@export var max_value = 200
signal zero

func _ready() -> void:
	$progress.max_value = max_value
	$progress.value = current_value
	
func _process(_delta: float) -> void:
	$progress.value = current_value	

func damage(amount: int):
	if (current_value <= 0): return
	Statistics.damage_dealt += min(current_value, amount)
	current_value -= amount 
	if (current_value <= 0): zero.emit()
