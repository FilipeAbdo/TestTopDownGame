class_name Player
extends CharacterBody2D

const Actions = preload("res://Scripts/PlayerActions.gd").Actions
const PlayerStateMachine = preload("res://Scripts/PlayerStateMachine.gd").PlayerStateMachine

const PlayerInputManager = preload("res://Scripts/PlayerInputManager.gd").PlayerInputManager
const InputClass = preload("res://Scripts/PlayerInputManager.gd").InputClass
const DirEnum = preload("res://Scripts/PlayerInputManager.gd").DirEnum

@onready var sprite_2d = $Sprite2D

@export var speed:float = 200
@export_range(0,5,.1) var attack_cool_down:float = 1

@onready var animationPlayer = $AnimationPlayer
var playerState:PlayerStateMachine = PlayerStateMachine.new(Actions.IDLE)

var last_player_state = Actions.IDLE
var is_state_transition = false

func _ready():
	animationPlayer.playAnimation(Actions.IDLE)

func readInput():
	var inputData:InputClass = PlayerInputManager.processInput()
	
	velocity = inputData.direction.normalized() * speed
	
	if(inputData.orientationX == DirEnum.LEFT):
		sprite_2d.flip_h = true
	elif(inputData.orientationX == DirEnum.RIGHT):
		sprite_2d.flip_h = false
	
	playerState.processState(inputData, animationPlayer)
	
	if(is_walking()):
		move_and_slide()

func _physics_process(_delta):
	readInput()
	
func is_walking():
	return playerState.getState() == Actions.WALK
	
func _on_animation_player_animation_finished(animation:Actions):
	print("Finished animation: " + Actions.find_key(animation))
