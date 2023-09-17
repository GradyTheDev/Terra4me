extends Node

@onready var dialog_1: RichTextLabel = $"../Planet/DialogBox/Dialog"
@onready var dialog_2: RichTextLabel = $"../Planet2/DialogBox/Dialog"

@onready var portrait_1: TextureRect = $"../Planet/Portrait"
@onready var portrait_2: TextureRect = $"../Planet2/Portrait"

@onready var char_1: RichTextLabel = $"../Planet/Portrait/CharacterLabel"
@onready var char_2: RichTextLabel = $"../Planet2/Portrait/CharacterLabel"

func _ready():
	dialog_1.finished.connect(_dialog_1_on_finished)


func _dialog_1_on_finished():
	dialog_2.text = dialog_1.text
	portrait_2.texture = portrait_1.texture
	char_2.text = char_1.text
