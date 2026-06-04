extends Area3D

@onready var Dialogue: Label = $"../CanvasLayer/DialogueLabel"
@onready var TheLittleTurtle: CharacterBody3D = $"../TheLittleTurtle"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		TheLittleTurtle.global_position.x = 107.7
		TheLittleTurtle.global_position.y = -5.774
		TheLittleTurtle.global_position.z = 0.0
		TheLittleTurtle.visible = true
		GlobalNode.follow = 1
		Dialogue.visible = true
		Dialogue.text = "Wh.. What!?"
		start_typewriter_effect()
		await get_tree().create_timer(1.5).timeout
		Dialogue.visible = false


func start_typewriter_effect():
	# Reset visible characters to 0
	Dialogue.visible_ratio = 0.2
	# Create a tween to animate the visible_ratio from 0 to 1 over 2 seconds
	var tween = create_tween()
	tween.tween_property(Dialogue, "visible_ratio", 1.0, 1.5)
