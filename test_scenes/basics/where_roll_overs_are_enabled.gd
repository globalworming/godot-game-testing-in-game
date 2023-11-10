extends Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (
		$roll_over.enabled && 
		$roll_over2.enabled && 
		$roll_over3.enabled && 
		$roll_over4.enabled): TestStatus.test_success.emit()
