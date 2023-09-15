extends ProgressBar

@onready var win_timer = $"../WinTimer"

func _process(_delta):
	if win_timer.is_stopped():
		self.value = 0
	else:
		self.value = remap(win_timer.time_left, 0, owner.sec_to_win, 100, 0)
