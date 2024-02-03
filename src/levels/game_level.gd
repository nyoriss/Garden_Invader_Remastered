extends Node2D

# Birds
var birdTypes = []
var birds = [] #liste d'oiseaux
var birdProjectiles = []
var birdClass = preload("res://src/objects/bird.tscn")
var birdObject = Bird.new()

#Player
var playerProjectiles = []

# Assets
var backgroundImage = preload("res://asset/game.png")

# Game difficulty
var pie_number : int
var corbo_number : int
var martin_pecheur_number : int

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalScript.game_launching = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(GlobalScript.game_launching):
		initializeGame()

	if(!GlobalScript.game_paused):
		GlobalScript.gameTick += 1
	if(birds.size()==0):
		print("gg t'as tué tous les oiseaux")
		GlobalScript.game_paused = true
		winGame()

func spawnBird(birdPosition : Vector2, birdType : String) :
	var birdInstanciated = birdClass.instantiate()
	#TODO méthode directement dans bird
	birdInstanciated.initializeBird(birdType, birdPosition)
	return birdInstanciated

func initializeEnemies():
	var birdsPerRow = 10;
	# var rows = 3
	var birdNb = pie_number + corbo_number + martin_pecheur_number

	var ecart = ((GlobalScript.window_width - (birdsPerRow * birdObject.width)) / (birdsPerRow+1.5)) / 3 / 2
	#TODO régler les ratio du dessus (trouver variables/origine)
	var row = ecart
	var column = ecart
	var enemyCount = 1
	var delays = []
	
	for i in range (1, birdNb+1) :
		delays.append(birdNb*i)
	
	for i in range (birdNb) :
		randomize()
		var birdType = birdTypes[i]
		var bird = spawnBird(Vector2(column, row), birdType)
		get_node(".").add_child(bird)
		birds.append(bird)
		var rand = delays[randi()%delays.size()]
		bird.nextAttackTick = rand # un random de la liste delays
		delays.erase(rand)
		if (enemyCount % birdsPerRow == 0):
			#Fin de ligne donc on change de ligne
			row += ecart;
			column = ecart;
		else :
			column += ecart * 2
		enemyCount += 1

func getBirdsTypes():
	for i in range (pie_number + corbo_number + martin_pecheur_number):
		var assigned = false
		if(i < martin_pecheur_number):
			birdTypes.append("martin_pecheur")
			assigned = true
		if(i < martin_pecheur_number + corbo_number && !assigned):
			birdTypes.append("corbo")
			assigned = true
		# Pie by default
		if(!assigned):
			birdTypes.append("pie")

func loseGame():
	GlobalScript.game_paused = true
	get_tree().change_scene_to_file("res://src/levels/losing_screen.tscn")

func winGame():
	GlobalScript.game_paused = true
	get_tree().change_scene_to_file("res://src/levels/winning_screen.tscn")

# fonction that add a projectile to the bird projectiles list 
func addBirdProjectile(projectile):
	birdProjectiles.append(projectile)

# fonction that add a projectile to the player projectiles list 
func addPlayerProjectile(projectile):
	playerProjectiles.append(projectile)

# fonction that delete a projectile from the bird projectiles list 
func deleteBirdProjectile(projectile):
	birdProjectiles.erase(projectile)
	projectile.queue_free()

# fonction that delete a projectile from the player projectiles list 
func deletePlayerProjectile(projectile):
	playerProjectiles.erase(projectile)
	projectile.queue_free()

# fonction that delete a bird from the bird list 
func deleteBird(bird : Bird):
	birds.erase(bird)
	bird.queue_free()

func initializeGame():
	GlobalScript.gameTick = 0
	GlobalScript.game_launching = false
	for bird in birds :
		deleteBird(bird)
	
	for projectile in birdProjectiles:
		deleteBirdProjectile(projectile)

	for projectile in playerProjectiles:
		deletePlayerProjectile(projectile)

	if(GlobalScript.current_difficulty == GlobalScript.GAME_HARD):
		pie_number = 10
		corbo_number = 10
		martin_pecheur_number = 10
	else : 
		if(GlobalScript.current_difficulty == GlobalScript.GAME_MEDIUM):
			pie_number = 20
			corbo_number = 10
			martin_pecheur_number = 0
		else : 
			#EASY by default
			pie_number = 30
			corbo_number = 0
			martin_pecheur_number = 0
	getBirdsTypes()
	GlobalScript.game_paused = false
	initializeEnemies()
	
