extends CharacterBody3D

# Movement speeds
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5
var sprint = 200
const MAX_SPRINT = 200

# Camera sensitivity
const SENSITIVITY = 0.003

# Node reference (Make sure you have a Camera3D as a child of your player)
@onready var camera: Camera3D = $Camera3D
@onready var SprintLabel: Label = $"../CanvasLayer/SprintLabel"
@onready var DialogueLabel: Label = $"../CanvasLayer/DialogueLabel"
@onready var FadeBox: ColorRect = $"../CanvasLayer/Fade"

func _ready() -> void:
	pass
	# Captures the mouse cursor and hides it when the game starts
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if GlobalNode.canMove == 1:
			# Rotate the player horizontally (left/right)
			rotate_y(-event.relative.x * SENSITIVITY)
			
			# Rotate the camera vertically (up/down) and clamp it so you can't flip upside down
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _unhandled_input(event: InputEvent) -> void:
	# Optional: Press Escape to free the mouse cursor
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if GlobalNode.canMove == 1:
			velocity.y = JUMP_VELOCITY

	# Determine current speed based on whether the sprint key is held down
	# (You'll want to map "sprint" to Shift in your Input Map, or change this string)
	var current_speed = WALK_SPEED
	if Input.is_action_pressed("ui_sprint") and GlobalNode.canMove == 1:
		if sprint > 0:
			current_speed = SPRINT_SPEED
			sprint -= 0.5
			SprintLabel.text = "Sprint: %d" % sprint
			if sprint <= 0:
				sprint = 0
	else:
		sprint += 0.25
		SprintLabel.text = "Sprint: %d" % sprint
		if sprint >= 200:
			sprint = 200

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and GlobalNode.canMove == 1:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
