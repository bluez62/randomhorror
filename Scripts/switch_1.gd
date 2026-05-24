extends Area3D

@onready var anim_player: AnimationPlayer = $Switch/SwitchOn
@onready var TheLittleTurtle: CharacterBody3D = $"../TheLittleTurtle"
@onready var Dialogue: Label = $"../CanvasLayer/DialogueLabel"
@onready var Blocker: MeshInstance3D = $"../Blocker"
@onready var BlockCol: StaticBody3D = $"../Blocker/StaticBody3D"

func interact() -> void:
	if !GlobalNode.PowerOn:
		GlobalNode.PowerOn = true
		GlobalNode.StoryFlag = 3
		TheLittleTurtle.visible = false
		Dialogue.visible = true
		BlockCol.set_collision_mask_value(2, true)
		Blocker.visible = true
		anim_player.play("On")
		Dialogue.text = "[You]\nNice! The power is back on!\nI should go back to the main room now."
		start_typewriter_effect()
		await get_tree().create_timer(5).timeout
		Dialogue.visible = false

func start_typewriter_effect():
	Dialogue.visible_ratio = 0.2
	var tween = create_tween()
	tween.tween_property(Dialogue, "visible_ratio", 1.0, 1.5)
