class_name Squashable extends Node

signal  squashed

var is_squashed = false
@export var corpse_texture: CompressedTexture2D

func squash(): 
	if is_squashed: return
	is_squashed = true
	Statistics.creatures_squashed += 1
	get_node("sound").play()
	var corpse: GPUParticles2D = $corpse
	corpse.texture = corpse_texture
	var body = get_parent();
	var parent = body.get_parent()
	corpse.global_position = body.global_position
	corpse.reparent(parent)
	corpse.restart()
	corpse.wait_to_clean_up = true
	squashed.emit()
	body.queue_free()
