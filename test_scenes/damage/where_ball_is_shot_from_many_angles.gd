extends Node2D

var started = false
@onready var ball: RigidBody2D = $ball
@onready var tank: RigidBody2D = $tank
var damage = 0
var offset = Vector2(700, 700)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$on_damage_test_succes.damage_to_deal = 55000
	tank.get_node("Health").set_value(55000, 55000)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (started): return
	started = true
	for force in [3, 4, 5]:
		for i in range(0 + force, 360, 72):
			tank.freeze = true
			tank.position = Vector2(0, 0) + offset
			tank.freeze = false
			ball.freeze = true
			ball.position = (Vector2.UP * 500).rotated(deg_to_rad(i)) + offset
			ball.freeze = false
			ball.apply_central_impulse(ball.position.direction_to(tank.position).rotated(0.05).normalized() * 1000 * force)
			await get_tree().create_timer(0.2).timeout;
			#print (Statistics.damage_dealt - damage)
			damage = Statistics.damage_dealt

			
