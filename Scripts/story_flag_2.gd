extends Area3D

@onready var Dialogue: Label = $"../CanvasLayer/DialogueLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		Dialogue.visible = true
		Dialogue.text = "[You]\nWoah.. It's dark in here."
		GlobalNode.StoryFlag = 2
		start_typewriter_effect()
		await get_tree().create_timer(3).timeout
		Dialogue.text = "[You]\nI need to find a light switch."
		start_typewriter_effect()
		await get_tree().create_timer(3).timeout
		Dialogue.visible = false

func start_typewriter_effect():
	# Reset visible characters to 0
	Dialogue.visible_ratio = 0.2
	# Create a tween to animate the visible_ratio from 0 to 1 over 2 seconds
	var tween = create_tween()
	tween.tween_property(Dialogue, "visible_ratio", 1.0, 1.5)
