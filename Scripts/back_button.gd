extends Button

@onready var PlayButton: Button = $"../PlayButton"
@onready var SettingsButton: Button = $"../SettingsButton"
@onready var ShadowSettings: OptionButton = $"../ShadowSettings"
@onready var BackButton: Button = $"../BackButton"
@onready var ShadowLabel: Label = $"../ShadowLabel"
@onready var FullscreenSettings: OptionButton = $"../FullscreenSettings"
@onready var FullscreenLabel: Label = $"../FullscreenLabel"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

#Change menu
func _on_button_up() -> void:
	PlayButton.visible = true
	SettingsButton.visible = true
	ShadowLabel.visible = false
	ShadowSettings.visible = false
	BackButton.visible = false
	FullscreenLabel.visible = false
	FullscreenSettings.visible = false
