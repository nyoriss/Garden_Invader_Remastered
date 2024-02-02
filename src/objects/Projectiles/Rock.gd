class_name Carrot
extends Area2D

@export var move_speed : float = 100
@export var width = 7
@export var height = 5

func _physics_process(_delta):
	
	var input_direction = Vector2(
		0,
		1
	)
	if(!GlobalScript.game_paused):
		self.position = self.position + input_direction # * move_speed
	# velocity = input_direction * move_speed
	# move_and_slide()


func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if (is_instance_of(body, Player_rabbit)):
		body.notify(self)
		queue_free()
	if (is_instance_of(body, Projectile_delete_line)):
		queue_free()
