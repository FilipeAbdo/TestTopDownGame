class_name PlayerAnimationManager
extends AnimationPlayer
const PlayerActions = preload("res://Scripts/PlayerActions.gd")
const Actions = preload("res://Scripts/PlayerActions.gd").Actions
const AttackTypes = preload("res://Scripts/PlayerActions.gd").AttackTypes

@onready var animation_player = $"."

signal animationFinished(animation:Actions)
signal animationStarted
signal animationLooped

var lastAnimationTriggered:Actions = Actions.IDLE

func playAttackAnimation(attackType:AttackTypes):
	lastAnimationTriggered = Actions.ATTACK
	play(PlayerActions.getAnimationForAttackType(attackType))

func playAnimation(action:Actions):
	lastAnimationTriggered = action
	play(PlayerActions.getAnimationForAction(action))

func _process(_delta):
	if animation_player.current_animation == "":
		play(PlayerActions.getAnimationForAction(Actions.IDLE))
		animationFinished.emit(lastAnimationTriggered)

func getCurrentAnimation() -> Actions:
	var localCurrentAnimation = animation_player.current_animation
	if(localCurrentAnimation != ""):
		return PlayerActions.getActionForAnimation(localCurrentAnimation)
		
	return Actions.IDLE
