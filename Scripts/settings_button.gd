extends Button

@onready var PlayButton: Button = $"../PlayButton"
@onready var SettingsButton: Button = $"../SettingsButton"
@onready var ShadowSettings: OptionButton = $"../ShadowSettings"
@onready var BackButton: Button = $"../BackButton"
@onready var ShadowLabel: Label = $"../ShadowLabel"
@onready var FullscreenSettings: OptionButton = $"../FullscreenSettings"
@onready var FullscreenLabel: Label = $"../FullscreenLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up() -> void:
	PlayButton.visible = false
	SettingsButton.visible = false
	BackButton.visible = true
	ShadowLabel.visible = true
	ShadowSettings.visible = true
	FullscreenLabel.visible = true
	FullscreenSettings.visible = true
