extends Area3D

@onready var RedDoor = get_parent()
@onready var KeyCollect: AudioStreamPlayer = $"../../KeyCollect"
@onready var Dialogue: Label = $"../../CanvasLayer/DialogueLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact() -> void:
	if(GlobalNode.StoryFlag == 4):
		if(GlobalNode.HasRedKey):
			KeyCollect.play()
			GlobalNode.StoryFlag == 5
			RedDoor.queue_free()
			queue_free()
		else:
			Dialogue.text = "[You]\nIt looks like this door might\nrequire a key."
			Dialogue.visible = true
			start_typewriter_effect()
			await get_tree().create_timer(3).timeout
			Dialogue.visible = false
	else:
		Dialogue.text = "[You]\nHmm.. This door won't open without \npower."
		Dialogue.visible = true
		start_typewriter_effect()
		await get_tree().create_timer(3).timeout
		Dialogue.visible = false

func start_typewriter_effect():
	Dialogue.visible_ratio = 0.2
	var tween = create_tween()
	tween.tween_property(Dialogue, "visible_ratio", 1.0, 1.5)
