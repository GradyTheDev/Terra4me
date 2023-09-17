extends AudioStreamPlayer

func _ready():
	self.finished.connect(_on_finished)


func _on_finished():
	play()
