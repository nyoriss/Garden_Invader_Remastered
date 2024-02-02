extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_easy_button_pressed():
	GlobalScript.current_difficulty = GlobalScript.GAME_EASY
	launch_game()

func _on_medium_button_pressed():
	GlobalScript.current_difficulty = GlobalScript.GAME_MEDIUM
	launch_game()

func _on_hard_button_pressed():
	GlobalScript.current_difficulty = GlobalScript.GAME_HARD
	launch_game()

func launch_game():
	# Changer de scène
	#TODO call the initialize of game_level
	GlobalScript.game_launching = true
	get_tree().change_scene_to_file("res://src/levels/game_level.tscn")

