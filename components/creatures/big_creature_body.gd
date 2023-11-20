extends RigidBody2D

@onready var creature = get_parent()

func on_ball_collision(_ball: RigidBody2D, _force: float): 
	var damage = 15
	Statistics.damage_dealt += min(creature.health, damage)
	creature.health -= damage

func on_paddle_collision(_paddle: RigidBody2D): 
	var damage = 10
	Statistics.damage_dealt += min(creature.health, damage)
	creature.health -= damage
