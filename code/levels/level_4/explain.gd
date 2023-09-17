extends Node

@export var dialog_explain: Dialog

var dialog_system: DialogSystem

func _ready():
	dialog_system = $"../Planet/DialogSystem"
	dialog_system.message_over.connect(run, CONNECT_ONE_SHOT)

	$"../Planet2/DialogSystem".process_mode = Node.PROCESS_MODE_DISABLED

func run(_a):
	dialog_system.play_dialog(dialog_explain)
	queue_free()
