extends Area2D

@export var creatures_required = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var creatures = get_overlapping_bodies().size()
	$Label.text = "creatures %d/%d" % [creatures, creatures_required]
	if (creatures >= creatures_required): TestStatus.test_success.emit()
