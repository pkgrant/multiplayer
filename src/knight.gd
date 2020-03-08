extends KinematicBody2D

export (int) var speed = 100

var velocity 	    = Vector2()
var moving   	    = false
var idle		    = true
var attack		    = false
var orientation     = 0
var animation       = "idle"
var attack_anims    = ["attack1", "attack2", "attack3"]
var i = 0;
var attack_cooldown = .28
var cd				= .0

func _physics_process(delta):
	update_knight(delta)
	
	if !attack:
		velocity = move_and_slide(velocity)

func update_knight(delta):
	
	move()
	face()
	
	#check attack first
	if !attack:
		if (Input.is_action_just_pressed("click") or
			Input.is_action_pressed("click")):
				
			$AnimationPlayer.play(attack_anims[i])
			i = (i + 1) % 3
			attack = true
		
	if attack:
		moving = false
		cd = cd + delta
		if cd > attack_cooldown:
			attack = false
			cd 	   = 0
	
	if attack:
		pass
	elif moving:
		animation = "walk"
		play_animation(animation)
	elif idle:
		animation = "idle"
		play_animation(animation)
	
	

func move():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		moving = true
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		moving = true
	if Input.is_action_pressed("down"):
		velocity.y += 1
		moving = true
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		moving = true

	velocity = velocity.normalized() * speed
	idle 	 = false
	
	if velocity.length() == 0:
		moving = false
		idle   = true

func face():
	#Need a way to preserve diagonal movement to face, it's really sensative
	if moving:
		rotation = atan2(velocity.x, -velocity.y)
		orientation = rotation
	else:
		rotation = orientation

func attack():
	pass

func play_animation(act):
	$AnimationPlayer.play(act)
		
func attack_animator(delta):
	if Input.is_action_just_pressed("click"):
		$AnimationPlayer.play("attack1")
