extends Area3D

# Adjust the path "$AnimationPlayer" to match whatever your animation node is named
@onready var anim_player: AnimationPlayer = $Switch/SwitchOn

var is_activated: bool = false

func interact() -> void:
	if !GlobalNode.PowerOn:
		GlobalNode.PowerOn = true
		print("Switch activated!")
		GlobalNode.StoryFlag = 3
		
		# Play your visual change animation
		anim_player.play("On")
