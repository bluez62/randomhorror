extends Button

var began = false

@onready var BluezLabel: Label = $"../BluezLabel"
@onready var Logo: Label = $"../Logo"
@onready var PlayButton: Button = $"../PlayButton"
@onready var SettingsButton: Button = $"../SettingsButton"
@onready var FadeBox: ColorRect = $"../Fade"
@onready var DialogueLabel: Label = $"../DialogueLabel"
@onready var SprintLabel: Label = $"../SprintLabel"
@onready var TitleScreenMusic: AudioStreamPlayer = $"../../TitleScreenMusic"
@onready var Chapter1Button: TextureButton = $"../TextureButton"
@onready var Chapter1Label: Label = $"../Chapter1Label"
@onready var Context: Label = $"../Context"
@onready var ShadowSettings: OptionButton = $"../ShadowSettings"
@onready var BackButton: Button = $"../BackButton"
@onready var ShadowLabel: Label = $"../ShadowLabel"
@onready var FullscreenSettings: OptionButton = $"../FullscreenSettings"
@onready var FullscreenLabel: Label = $"../FullscreenLabel"
@onready var VersionLabel: Label = $"../VersionLabel"
@onready var ProdLabel: Label = $"../ProdLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Context.visible_ratio = 0.0
	DialogueLabel.visible = false
	SprintLabel.visible = false
	ShadowLabel.visible = false
	ShadowSettings.visible = false
	BackButton.visible = false
	FullscreenLabel.visible = false
	FullscreenSettings.visible = false
	VersionLabel.visible = false
	Chapter1Button.visible = false
	Chapter1Label.visible = false
	ProdLabel.modulate.a = 0.0
	await get_tree().create_timer(2).timeout
	var ProdTween = create_tween()
	ProdTween.tween_property(ProdLabel, "modulate:a", 1.0, 3.0)
	await ProdTween.finished
	await get_tree().create_timer(1).timeout
	var ProdTween2 = create_tween()
	ProdTween2.tween_property(ProdLabel, "modulate:a", 0.0, 3.0)
	await ProdTween2.finished
	await get_tree().create_timer(1).timeout
	ProdLabel.visible = false
	Chapter1Label.visible = true
	Chapter1Button.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up() -> void:
	Chapter1Button.FadeTween.kill()
	var fadetween = create_tween()
	fadetween.tween_property(FadeBox, "modulate:a", 1.0, 0.0)
	FadeBox.modulate.a = 1.0
	TitleScreenMusic.stop()
	BluezLabel.process_mode = Node.PROCESS_MODE_DISABLED
	BluezLabel.visible = false
	Logo.process_mode = Node.PROCESS_MODE_DISABLED
	Logo.visible = false
	PlayButton.process_mode = Node.PROCESS_MODE_DISABLED
	PlayButton.visible = false
	SettingsButton.process_mode = Node.PROCESS_MODE_DISABLED
	SettingsButton.visible = false
	VersionLabel.visible = false 
	await get_tree().create_timer(2.0).timeout
	Context.visible_characters += 2
	loop()

func loop():
	if(!began):
		Context.visible_characters += 1
		await get_tree().create_timer(0.05).timeout
		if(Context.visible_characters == 118):
			await get_tree().create_timer(0.5).timeout
			loop()
		elif(Context.visible_characters == 170):
			await get_tree().create_timer(0.3).timeout
			loop()
		elif(Context.visible_characters == 179):
			await get_tree().create_timer(0.3).timeout
			loop()
		elif(Context.visible_characters == 213):
			await get_tree().create_timer(0.5).timeout
			loop()
		elif(Context.visible_characters == 258):
			await get_tree().create_timer(2).timeout
			loop()
		elif(Context.visible_characters == 302):
			await get_tree().create_timer(1).timeout
			loop()
			await get_tree().create_timer(5).timeout
			began = true;
			Context.visible = false
			FadeBox.modulate.a = 0.0
			GlobalNode.canMove = 1
			GlobalNode.follow = 1
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			loop()
