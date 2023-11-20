class_name Squashable extends Node

signal  squashed

var is_squashed = false
@export var corpse_texture: CompressedTexture2D
@export var squash_sound: AudioStreamMP3

func squash(): 
	if is_squashed: return
	is_squashed = true
	Statistics.creatures_squashed += 1
	squashed.emit()
	var corpse = $corpse
	corpse.texture = corpse_texture
	var timer: Timer = $corpse/Timer
	var body = get_parent();
	var parent = body.get_parent()
	corpse.reparent(parent)
	corpse.global_position = get_parent().global_position
	corpse.restart()
	timer.timeout.connect(corpse.queue_free)
	timer.start(5)
	var crack: AudioStreamPlayer2D = $crack
	crack.stream = squash_sound
	crack.reparent(parent)
	crack.playing = true
	crack.finished.connect(crack.queue_free)
	body.queue_free()
