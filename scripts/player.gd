extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var DOUBLE_JUMP = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#Handle double jump.
	if Input.is_action_just_pressed("jump") and !is_on_floor() and DOUBLE_JUMP!=1:
		velocity.y =JUMP_VELOCITY
		DOUBLE_JUMP = 1
	#Reset double jump.
	if is_on_floor():
		DOUBLE_JUMP = 0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
