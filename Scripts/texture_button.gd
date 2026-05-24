extends TextureButton

@onready var FadeBox: ColorRect = $"../Fade"
@onready var Chapter1Label: Label = $"../PanelContainer/Chapter1Label"
@onready var TitleScreenMusic: AudioStreamPlayer = $"../../TitleScreenMusic"
@onready var VersionLabel: Label = $"../VersionLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var FadeTween: Tween

func _on_button_up() -> void:
	GlobalNode.Chapter = 1
	visible = false
	Chapter1Label.visible = false
	VersionLabel.visible = true
	Chapter1Label.process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(2.0).timeout
	TitleScreenMusic.play()
	FadeTween = create_tween()
	FadeTween.tween_property(FadeBox, "modulate:a", 0.0, 5)

func stop_tween():
	FadeTween.kill()
