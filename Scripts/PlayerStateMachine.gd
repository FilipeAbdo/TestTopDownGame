
signal lightAttack
signal walk
signal idle
signal interact
signal harverst

const PlayerActions = preload("res://Scripts/PlayerActions.gd")
const Actions = preload("res://Scripts/PlayerActions.gd").Actions
const InputClass = preload("res://Scripts/PlayerInputManager.gd").InputClass
const PlayerAnimationManager = preload("res://Scripts/PlayerAnimationManager.gd")

class PlayerStateMachine:
	var _current_state: Actions = 0

	func _init(initState:Actions):
		_current_state = initState
		
	func setState(state:Actions):
		_current_state = state
		
	func getState():
		return _current_state

	func processState(input:InputClass, animationManager:PlayerAnimationManager):
		match _current_state:
			Actions.IDLE:
				_processIdleState(input, animationManager)
			Actions.WALK:
				_processWalkState(input, animationManager)
			Actions.ATTACK:
				_processAttackState(input, animationManager)
			Actions.INTERACT:
				_processInteractState(input, animationManager)
			Actions.HARVERST:
				_processHarvestState(input, animationManager)
				
		if(_current_state == Actions.IDLE and input.action != Actions.IDLE):
			processState(input, animationManager)

	func _processIdleState(input:InputClass, animationManager:PlayerAnimationManager):
		match input.action:
			Actions.WALK:
				setState(Actions.WALK)
				animationManager.playAnimation(Actions.WALK)
			Actions.ATTACK:
				setState(Actions.ATTACK)
				animationManager.playAttackAnimation(input.attackType)
			Actions.INTERACT:
				setState(Actions.INTERACT)
				animationManager.playAnimation(Actions.INTERACT)
			Actions.HARVERST:
				setState(Actions.HARVERST)
				animationManager.playAnimation(Actions.HARVERST)
			_:
				setState(Actions.IDLE)
				animationManager.playAnimation(Actions.IDLE)

	func _processWalkState(input:InputClass, animationManager:PlayerAnimationManager):
		match input.action:
			Actions.IDLE:
				setState(Actions.IDLE)
			Actions.ATTACK:
				setState(Actions.IDLE)
			Actions.INTERACT:
				setState(Actions.IDLE)
			Actions.HARVERST:
				setState(Actions.IDLE)
				
		if(getState() == Actions.IDLE):
			animationManager.playAnimation(Actions.IDLE)

	func _processAttackState(input:InputClass, animationManager:PlayerAnimationManager):
		var currentAnimation = animationManager.current_animation
		var action = PlayerActions.getActionForAnimation(animationManager.current_animation)
		if(action != Actions.ATTACK):
			setState(Actions.IDLE)
		
	func _processInteractState(input:InputClass, animationManager:PlayerAnimationManager):
		if(!animationManager.is_playing()):
			setState(Actions.IDLE)
		
	func _processHarvestState(input:InputClass, animationManager:PlayerAnimationManager):
		if(!animationManager.is_playing()):
			setState(Actions.IDLE)
