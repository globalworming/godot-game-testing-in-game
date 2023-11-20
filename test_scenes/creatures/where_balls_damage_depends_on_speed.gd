extends Node2D


var damage_before = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var damage = Statistics.damage_dealt;
	if (damage != damage_before):
		if (damage - damage_before) < 90: 
			push_error("more damage expected")
			TestStatus.test_error.emit()
		damage_before = damage
		
	if (Statistics.creatures_squashed == 1) :
		TestStatus.test_success.emit()
