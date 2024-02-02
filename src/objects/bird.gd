extends CharacterBody2D
class_name Bird

# Size
@export var width = 16
@export var height = 9

# Movement

@export var move_tick : int = 0
@export var moveDelay : int = 50
@export var moveSpeed : int = 10
@export var descentDelay : int = 3 * moveDelay
# Attack
@export var nextAttackTick : int = 200
var attackDelay : int = 200
var projectile = preload("res://src/objects/Projectiles/Rock.tscn")
var rock : Rock = null
# Type
@export var birdType : String = "pie"
var pieHP = 1
var corboHP = 2
var martin_pecheurHP = 3
var martin_pecheurAttackDelay = attackDelay
var corboAttackDelay = attackDelay + 75
var pieAttackDelay = attackDelay + 150

# HP
@export var maxHP : int = 1
@export var currentHP : int = maxHP


func _physics_process(_delta):
	if(!GlobalScript.game_paused):
		# update frame
		if(GlobalScript.gameTick % 20 > 10) :
			$Sprite2D.texture = load("res://asset/sprite/"+birdType+"_1.png")
		else:
			$Sprite2D.texture = load("res://asset/sprite/"+birdType+"_2.png")
		# update position
		if(GlobalScript.gameTick - move_tick >= moveDelay || GlobalScript.gameTick / moveSpeed >= 20 * moveSpeed):
			if(GlobalScript.gameTick / moveSpeed % 2 == 0):
				self.position += Vector2(0, 0.25)
			else:
				self.position += Vector2(0, -0.25)
			if(GlobalScript.gameTick % (descentDelay) == 0) : 
				#TODO trouver une autre façon de timer (?)
				self.position += Vector2(0, height/2)

	# update shooting
		if(GlobalScript.gameTick % nextAttackTick == 0):
			shoot()
			nextAttackTick = GlobalScript.gameTick + attackDelay + randi()%(attackDelay/20)-(attackDelay)/10


	
func notify(_projectile : Area2D):
	currentHP -= 1 #TODO remplacer par projectile.damage
	if(currentHP <= 0):
		get_node(".").get_parent().get_node("/root/Game_level").deleteBird(self)
		queue_free()

func initializeBird(thisBirdType : String, thisBirdPosition : Vector2):
	birdType = thisBirdType
	position = thisBirdPosition
	#TODO faire un switch
	if(birdType == "martin_pecheur"): #TODO changer en constante
		currentHP = martin_pecheurHP
		attackDelay = martin_pecheurAttackDelay
	else :
		if(birdType == "corbo"): #TODO changer en constante
			currentHP = corboHP
			attackDelay = corboAttackDelay
		else:
			currentHP = pieHP
			attackDelay = pieAttackDelay
	
func shoot():
	#spawn a projectile
	rock = Rock.new()
	var bullet = projectile.instantiate()
	var bullet_position = self.position + Vector2(+rock.width/2, +height)
	bullet.position = Vector2(bullet_position)
	get_parent().add_child(bullet)

# Pour changer le sprite pendant le code : 
# $Sprite2D.texture = load("res://asset/sprite/pie_2.png")
