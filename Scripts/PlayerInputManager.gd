const Actions = preload("res://Scripts/PlayerActions.gd").Actions
const AttackTypes = preload("res://Scripts/PlayerActions.gd").AttackTypes

class InputClass:
	var orientationX:DirEnum
	var orientationY:DirEnum
	var direction:Vector2
	var action:Actions
	var attackType:AttackTypes
	
enum DirEnum{
	IDLE,
	UP,
	DOWN,
	LEFT,
	RIGHT
}

class PlayerInputManager:
	
	
	static func processInput() -> InputClass:
		var inputData = InputClass.new()
		inputData.direction = Input.get_vector("left", "right", "up", "down")
		
		if(inputData.direction.x > 0):
			inputData.orientationX = DirEnum.RIGHT
		elif(inputData.direction.x < 0):
			inputData.orientationX = DirEnum.LEFT
		else:
			inputData.orientationX = DirEnum.IDLE
		
		if(inputData.direction.y > 0):
			inputData.orientationY = DirEnum.UP
		if(inputData.direction.y < 0):
			inputData.orientationY = DirEnum.DOWN
		else:
			inputData.orientationY = DirEnum.IDLE		
		
		inputData.action = _processAction(inputData)
		inputData.attackType = _processAttackType(inputData)
			
		return inputData
		
	static func _processAttackType(inputData:InputClass) -> AttackTypes:
		if(inputData.action == Actions.ATTACK):
			if(Input.is_action_pressed("attack")):
				return AttackTypes.SWORD_LIGHT_ATTACK
				
		return AttackTypes.NONE
			
		
	static func _processAction(inputData:InputClass) -> Actions:
		
		if(Input.is_action_pressed("attack")):
			return Actions.ATTACK
			
		elif(inputData.direction != Vector2(0,0)):
			return Actions.WALK
			
		return Actions.IDLE
		
