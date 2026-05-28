extends Area3D

@onready var PaperLabel: Label = $"../CanvasLayer/PaperLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact() -> void:
	if(!GlobalNode.paperopen):
		GlobalNode.canMove = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		var PaperTween = create_tween()
		PaperTween.tween_property(PaperLabel, "modulate:a", 1.0, 1)
		await PaperTween.finished
		GlobalNode.paperopen = true
		
		
