extends RigidBody2D

@export var amount = 30

func on_ball_collision(_ball: RigidBody2D, _force: float): 
	if !visible: return
	visible = false
	collision_layer = 0
	Experience.gain(amount)
	$ding.play()
	await $ding.finished
	get_parent().remove_child(self)
	
