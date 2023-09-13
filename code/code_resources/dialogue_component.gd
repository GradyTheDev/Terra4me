extends Node

const ExtraState = GlobalEnums.DialogueExtraState
const DialogueTitle = GlobalEnums.DialogueTitle
const TRANSLATOR = {
	DialogueTitle.INTRO: "intro",
	DialogueTitle.OUTRO: "outro",
}
@export var level_dialogue: DialogueResource

func _ready():
	if level_dialogue:
		DialogueManager.show_dialogue_balloon(
				level_dialogue,
				TRANSLATOR[DialogueTitle.INTRO],
				[ExtraState.PAUSE_GAME])
