class_name PlayerActions

enum Actions{
	IDLE,
	WALK,
	ATTACK,
	INTERACT,
	HARVERST
}

enum AttackTypes{
	NONE,
	SWORD_LIGHT_ATTACK,
	SWORD_HEAVY_ATTACK,
	BOW_ATTACK
}

static var animations:Dictionary = {
	"IDLE": "idle",
	"WALK": "walk",
	"SWORD_LIGHT_ATTACK": "sword_attack",
	"SWORD_HEAVY_ATTACK": "sword_attack2",
	"TAKE_DAMAGE": "damage",
	"DIEING": "dieing",
	"INTERACT": "interact",
	"HARVERSTING": "harversting"	
}

static func getAnimationForAction(action:Actions):
	return animations[Actions.find_key(action)]

static func getAnimationForAttackType(attackType:AttackTypes):
	var animationKey = AttackTypes.find_key(attackType)
	var animationName = animations[animationKey]
	return animationName
	
static func getActionForAnimation(animation:String):
	if(animation.contains("attack")):
		return Actions.ATTACK
	else:
		var animationEnumName:String = getAnimationKey(animation)
		var animationValue = Actions.get(animationEnumName)
		return animationValue
	
static func getAnimationKey(animation:String):
	return animations.find_key(animation)
