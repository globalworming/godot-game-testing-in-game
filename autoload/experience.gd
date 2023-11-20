extends Node

signal level_up
signal experience_gained

var experience: int = 0

func gain(amount: int):
	amount = adjust_for_level(amount)
	var current_level = level()
	experience += amount
	Statistics.experience_collected += amount
	experience_gained.emit()
	var next_level = level()
	for i in  range(next_level - current_level):
		level_up.emit()
		
func level():
	return floorf(experience / 100.0)

func adjust_for_level(amount): 
	return amount * (1.0 - tanh(level() * 0.01))
