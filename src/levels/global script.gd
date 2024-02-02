extends Node

var gameTick = 0
var window_width = 768 * 1.5 #1152 #1500 #TODO changer pour avoir une bonne taille
var window_height = 750 #576 * 1.5 #750  #TODO changer pour avoir une bonne taille
var game_paused : bool = true
var game_launching : bool

# Game difficulty
var pie_number : int
var corbo_number : int
var martin_pecheur_number : int
var current_difficulty : String
var GAME_EASY : String = "Easy"
var GAME_MEDIUM : String = "Medium"
var GAME_HARD : String = "Hard"

#TODO check si utile, voir comment mettre en place les difficultés
