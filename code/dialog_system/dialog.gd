class_name Dialog
extends Resource

@export var portrait: PortraitsEnum
@export_multiline var message: String


enum PortraitsEnum {
	blank,
	boss,
	captain,
	interruptions,
	news,
	mockup
}

static var PortraitsTexture: Array[Texture2D] = [
	load("res://assets/artwork/crew/blank.png"),
	load("res://assets/artwork/crew/boss.png"),
	load("res://assets/artwork/crew/captain.png"),
	load("res://assets/artwork/crew/interrupted_radio_singal.png"),
	load("res://assets/artwork/crew/news_anchor.png"),
	load("res://assets/artwork/mockups/mockup_character_sprite.png")
]

const Crew := [
	"",
	"Boss",
	"Captain",
	"???",
	"News",
	"Mockup"
]

func get_portrait_image() -> Texture2D:
	return PortraitsTexture[self.portrait]

func get_crew_name() -> String:
	return Crew[portrait]

static func static_get_portrait_image(index: PortraitsEnum) -> Texture2D:
	return PortraitsTexture[index]