extends CharacterBody3D

#starting variables
@export var speed: float = 4.0
@export var player_node: Node3D 

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var Eyes: RayCast3D = $Eyes
@onready var Player: CharacterBody3D = $"../Player"

#error debug stuff
func _ready() -> void:
	if player_node == null:
		print("Player Missing! (if i somehow changed the player node in inspector to nothing then thats why)")
	else:
		print("Player Found: ", player_node.name)

#some stuff for pathfinding
@export var rotation_speed: float = 25.0

var player2: CharacterBody3D = null

#checks if the player is within a big area3d that follows the monster
func _on_ray_cast_checker_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player2 = body

func _on_ray_cast_checker_body_exited(body: Node) -> void:
	if body == player2:
		player2 = null

#checks if the player is in the area3d, and if so then looks in the direction of the player, if the player is seen (so theres no wall in between monster and player) then go to player.
func _physics_process(_delta: float) -> void:
	if player2:
		var local_target = Eyes.to_local(player2.global_position)
		Eyes.target_position = local_target
		
		if Eyes.is_colliding():
			var collider = Eyes.get_collider()
			if collider == player2 and GlobalNode.follow == 1:
				print_debug("SEES PLAYER!")
				nav_agent.target_position = player_node.global_position

			
	if not player_node:
		return
		
	
	#CRITICAL fix to stop crashes.
	if not nav_agent.is_target_reachable():
		return

	if nav_agent.is_navigation_finished():
		return
	
	#calculate next position.
	var next_path_position: Vector3 = nav_agent.get_next_path_position()
	var current_position: Vector3 = global_position
	
	# calculate direction
	var next_path_position2 = nav_agent.get_next_path_position()
	var new_velocity = (next_path_position2 - global_position).normalized() * speed
	new_velocity.y = 0.0 # Lock vertical movement
	
	#stuff to move
	velocity = new_velocity
	move_and_slide()


#placeholder function for jumpscare. will be updated to have a real jumpscare later.
func _on_jumpscare_body_entered(body: Node3D) -> void:
	if body == player_node:
		print("jumpscare")
