extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#TODO créer les fonctions dans le globalscript ?
func _on_try_again_button_pressed():
	launch_game()

func _on_main_menu_button_pressed():
	main_menu()


func launch_game():
	# Changer de scène
	#TODO call the initialize of game_level
	GlobalScript.game_launching = true
	get_tree().change_scene_to_file("res://src/levels/game_level.tscn")

func main_menu():
	# Changer de scène
	get_tree().change_scene_to_file("res://src/levels/main_menu.tscn")

