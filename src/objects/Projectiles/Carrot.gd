class_name Rock
extends Area2D

@export var move_speed : float = 100
@export var width = 5
@export var height = 14

func _physics_process(_delta):
	
	var input_direction = Vector2(
		0,
		-1
	)
	if(!GlobalScript.game_paused):
		self.position = self.position + input_direction # * move_speed


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if (is_instance_of(body, Bird)):
		body.notify(self)
		queue_free()
