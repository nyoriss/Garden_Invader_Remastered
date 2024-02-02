class_name Player_rabbit
extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,0)

# Attributs 
@export var current_frame = 0
@export var width = 14
@export var height = 16
#Attack variables
var carrot : Carrot = null
@export var isShooting = false
@export var lastAttackTick = 0
@export var attackDelay = 35
# animation variables
var projectile = preload("res://src/objects/Projectiles/carrot.tscn")

# HP
@export var maxHP = 3
@export var currentHP = maxHP


@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")


func _ready():
	#self.position = Vector2(100, 150)
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	# get input directions
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if(!GlobalScript.game_paused):
		var shooting = Input.get_action_strength("space")
		
		if(shooting && GlobalScript.gameTick - lastAttackTick >= attackDelay):
			isShooting = true
			# Créer projectile
			shoot()
			lastAttackTick = GlobalScript.gameTick

			#Arrête de l'animation de tir
		if(GlobalScript.gameTick - lastAttackTick >= attackDelay/2) :
			isShooting = false
			
		update_animation_parameters(input_direction)
		
		# update velocity
		velocity = input_direction * move_speed
		move_and_slide()

func update_animation_parameters(move_input : Vector2):
	if(move_input == Vector2.ZERO) :
		current_frame = 0
	else :
		if(GlobalScript.gameTick % 20 > 10) :
			current_frame = 1
		else:
			current_frame = 2
	if(isShooting):
		current_frame += 3
		
	$Sprite2D.frame = current_frame

func shoot():
	#spawn a projectile
	carrot = Carrot.new()
	var bullet = projectile.instantiate()
	var bullet_position = self.position + Vector2(-carrot.width/2, -height)
	bullet.position = Vector2(bullet_position)
	get_parent().add_child(bullet)

func notify(_projectile : Area2D):
	currentHP -= 1 #TODO remplacer par projectile.damage
	if(currentHP <= 0):
		print("Tu n'as plus de vie, tu as perdu :(")
		get_node(".").get_parent().loseGame()
