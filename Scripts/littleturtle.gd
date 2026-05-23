extends CharacterBody3D

@export var speed: float = 3.0
@export var player_node: Node3D 

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var Eyes: RayCast3D = $Eyes
@onready var Player: CharacterBody3D = $"../Player"

func _ready() -> void:
	# Check 1: Did we forget to link the player in the Inspector?
	if player_node == null:
		print("❌ DEBUG ERROR: 'player_node' is completely empty! You forgot to assign it in the Inspector.")
	else:
		print("✅ DEBUG SUCCESS: Found player node named: ", player_node.name)

@export var rotation_speed: float = 25.0 # Higher number means faster scanning

var player2: CharacterBody3D = null

# Connect this from your Area3D body_entered signal
func _on_ray_cast_checker_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player2 = body

# Connect this from your Area3D body_exited signal
func _on_ray_cast_checker_body_exited(body: Node) -> void:
	if body == player2:
		player2 = null

func _physics_process(_delta: float) -> void:
	if player2:
		# Convert the player's global position into the RayCast's local coordinates
		var local_target = Eyes.to_local(player2.global_position)
		# Directly set the ray's endpoint to point at the player
		Eyes.target_position = local_target
		
		if Eyes.is_colliding():
			var collider = Eyes.get_collider()
			if collider == player2 and GlobalNode.follow == 1:
				nav_agent.target_position = player_node.global_position

			
	if not player_node:
		return
		
	
	# 2. CRITICAL FIX: If the navigation map hasn't finished 
	# computing the path corners yet, skip this frame.
	if not nav_agent.is_target_reachable():
		return

	if nav_agent.is_navigation_finished():
		return
		
	# 3. Get the next point in the hallway
	var next_path_position: Vector3 = nav_agent.get_next_path_position()
	var current_position: Vector3 = global_position
	
	# 4. Calculate direction only to that next corner point
	var next_path_position2 = nav_agent.get_next_path_position()
	var new_velocity = (next_path_position2 - global_position).normalized() * speed
	new_velocity.y = 0.0 # Lock vertical movement
	
	velocity = new_velocity
	move_and_slide()


func _on_jumpscare_body_entered(body: Node3D) -> void:
	if body == player_node:
		print("jumpscare")
