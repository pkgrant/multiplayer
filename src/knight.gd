extends KinematicBody2D

export (int) var speed = 100

var velocity 	= Vector2()
var moving   	= false
var orientation = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	update()
	velocity = move_and_slide(velocity)

func update():
	move()
	face()
	
	play_attack_animation()

func move():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		moving = true
	if Input.is_action_pressed("left"):
		velocity.x += -1
		moving = true
	if Input.is_action_pressed("down"):
		velocity.y += 1
		moving = true
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		moving = true

	velocity = velocity.normalized() * speed
	
	if velocity.length() == 0:
		moving = false
	play_walk_animation()

func face():
	#Need a way to preserve diagonal movement to face, it's really sensative
	if moving:
		rotation = atan2(velocity.x, -velocity.y)
		orientation = rotation
	else:
		rotation = orientation

func play_walk_animation():
	if moving:		
		#REFACTOR ANIMATION STATES SO ONLY ONE CAN PLAY AT A TIME
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
		
func play_attack_animation():
	if Input.is_action_just_pressed("click"):
		$AnimationPlayer.play("attack1")
