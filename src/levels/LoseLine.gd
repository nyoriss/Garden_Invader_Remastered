extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_2d_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	GlobalScript.game_paused = true
	print("Les oiseaux ont atteint ton jardin, tu as perdu :(")

