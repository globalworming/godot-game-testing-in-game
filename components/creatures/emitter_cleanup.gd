extends GPUParticles2D

var wait_to_clean_up = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not wait_to_clean_up: return
	if not emitting:
		queue_free()
