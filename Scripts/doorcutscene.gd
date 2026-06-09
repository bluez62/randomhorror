extends Area3D

@onready var PlayhouseDoor: AnimationPlayer = $"../PlayhouseDoor/AnimationPlayer"
@onready var Collision: StaticBody3D = $"../PlayhouseDoor/StaticBody3D"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		PlayhouseDoor.play("DoorClose")
		set_deferred("disabled", true)
		await PlayhouseDoor.animation_finished
		Collision.set_deferred("disabled", false)
		
