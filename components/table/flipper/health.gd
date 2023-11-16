class_name Health extends Node

var current_value = 200


func _ready() -> void:
	$progress.max_value = current_value
	$progress.value = current_value
	
func _process(_delta: float) -> void:
	$progress.value = current_value	
