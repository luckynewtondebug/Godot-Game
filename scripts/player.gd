extends CharacterBody2D

@export var SPEED = 130
const JUMP_VELOCITY = -300.0
var DOUBLE_JUMP = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_particle_player: AnimationPlayer = $JumpParticle/JumpParticlePlayer
@onready var run_particle: GPUParticles2D = $RunParticle
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Movement Particles
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") and is_on_floor():
		run_particle.emitting = true
	else:
		run_particle.emitting = false
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump_particle_player.play("jump")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("jump") and !is_on_floor() and DOUBLE_JUMP!=1:
		velocity.y =JUMP_VELOCITY
		DOUBLE_JUMP = 1
	
	if Input.is_action_pressed("run"):
		SPEED = 130*1.5
	else:
		SPEED = 130
	#Reset double jump.
	if is_on_floor():
		DOUBLE_JUMP = 0
	# Running command
	if Input.is_action_just_pressed("run"):
		pass
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction == -1:
		animated_sprite_2d.flip_h = true
	elif direction == 1:
		animated_sprite_2d.flip_h = false
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		elif Input.is_action_pressed("run"):
			animated_sprite_2d.play("sprint")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
	
	move_and_slide()
