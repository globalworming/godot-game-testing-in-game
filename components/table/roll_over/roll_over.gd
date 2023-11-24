extends Node2D

@export var enabled: bool = false
@export var experience: int = 10

func _ready() -> void:
	apply_color()


func switch(body: Node2D):
#	if enabled: return
	if !body.is_in_group("ball"): return
	enabled = !enabled
	($rollover_on if enabled else $rollover_off).play()
	apply_color()
	Experience.gain(experience)
	
func apply_color():
	$indicator.color = Color.DEEP_PINK if enabled else Color.CORNFLOWER_BLUE
	
