extends CharacterBody2D

var speed = 200
var attack_cool_down = 1
var animationPlayer = null

var idle = 0
var walking = 1
var attacking = 2

var playerState = idle

func _ready():
	animationPlayer = get_node("AnimationPlayer")

var last_player_state = idle
var is_state_transition = false
func readInput():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * speed
	var move_command = (direction != Vector2(0,0))
	var attack_command = Input.is_action_pressed("atack") and !is_attack_in_cooldown()
	if(get_player_state() == idle):
		if(attack_command):
			set_player_state(attacking)
		elif(move_command):
			set_player_state(walking)
	elif(get_player_state() == walking):
		move_and_slide()
		if(attack_command):
			set_player_state(attacking)
		elif(!move_command):
			set_player_state(idle)
	elif(get_player_state() == attacking):
		if(!is_playing_attack_animation()):
			if(move_command):
				set_player_state(walking)
				move_and_slide()
			else:
				set_player_state(idle)
				
	if(get_player_state() != last_player_state):
		is_state_transition = true
		last_player_state = get_player_state()
	else:
		is_state_transition = false

var attackTime = attack_cool_down + 1
func animate():
	attackTime += get_process_delta_time()
	if is_atacking():
		set_attack_animation()
		if(is_state_transition):
			attackTime = 0
	elif is_walking():
		animationPlayer.play("walk")
	else:
		animationPlayer.play("idle")		

func set_player_state(state):
	playerState = state

func get_player_state():
	return playerState

func _physics_process(delta):
	readInput()
	animate()
	
func is_walking():
	return get_player_state() == walking
	
func is_atacking():
	return get_player_state() == attacking

func is_playing_attack_animation():
	return animationPlayer.current_animation == "sword_atack" or animationPlayer.current_animation == "sword_atack2"
	
func is_attack_in_cooldown():
	return attackTime <= attack_cool_down

var last_attack_animation = 2
func set_attack_animation():
	if(!is_playing_attack_animation()):
		if(last_attack_animation == 1 and attackTime <= 1.2 * attack_cool_down):
			last_attack_animation = 2
			animationPlayer.play("sword_atack2")
		else:
			last_attack_animation = 1
			animationPlayer.play("sword_atack")
			
