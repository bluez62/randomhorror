extends CharacterBody3D

#Variables
var WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5
var sprint = 200
const MAX_SPRINT = 200
var sprintDebug = false

#Camera sensitivity
const SENSITIVITY = 0.003

@onready var camera: Camera3D = $Camera3D
@onready var SprintLabel: Label = $"../CanvasLayer/SprintLabel"
@onready var DialogueLabel: Label = $"../CanvasLayer/DialogueLabel"
@onready var FadeBox: ColorRect = $"../CanvasLayer/Fade"
@onready var interaction_ray: RayCast3D = $Camera3D/RayCast3D
@onready var PaperLabel: Label = $"../CanvasLayer/PaperLabel"

func _ready() -> void:
	pass
	#UNUSED CODE BELOW
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#Mouse movements
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if GlobalNode.canMove:
			rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))

#Interact Code
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if interaction_ray.is_colliding():
			var hit_object = interaction_ray.get_collider()
			if hit_object.has_method("interact"):
				hit_object.interact()

	#Code to exit the note item.
	if event.is_action_pressed("ui_cancel"):
		if GlobalNode.paperopen:
			var PaperTween = create_tween()
			PaperTween.tween_property(PaperLabel, "modulate:a", 0.0, 1)
			await PaperTween.finished
			GlobalNode.canMove = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			GlobalNode.paperopen = false

#Movement and stuff
func _physics_process(delta: float) -> void:
	#Debug Code (does not work and i'm not sure how to fix)
	if sprintDebug:
		WALK_SPEED = 20.0
	#Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if GlobalNode.canMove:
			velocity.y = JUMP_VELOCITY

	#Sprint
	var current_speed = WALK_SPEED
	if Input.is_action_pressed("ui_sprint") and GlobalNode.canMove:
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

	#Movement
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and GlobalNode.canMove:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
