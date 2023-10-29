extends Node2D

const Ball = preload("res://components/ball.tscn")
const Block = preload("res://components/on_hit_test_success_block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var ball = Ball.instantiate()
	ball.set_position(get_viewport_rect().size / 2)
	var block = Block.instantiate()
	block.set_position(Vector2(0, 100) + get_viewport_rect().size / 2)
	
	add_child(ball)
	add_child(block)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
