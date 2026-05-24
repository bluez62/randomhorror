extends Area3D

@onready var KeyCollect: AudioStreamPlayer = $"../KeyCollect"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact() -> void:
	if(!GlobalNode.HasRedKey):
		KeyCollect.play()
		GlobalNode.HasRedKey = true
		queue_free()
