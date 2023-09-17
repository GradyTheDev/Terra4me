extends Camera2D

enum Direction {LEFT = -1, RIGHT = 1}
@export var distance_between_planets = 480
@export var sec_to_travel_whole_distance = 1
var tween: Tween


func _unhandled_input(event):
	if event.is_action("ui_left") and self.position.x > 0:
		move_camera_to(Direction.LEFT)
	if event.is_action("ui_right") and self.position.x < distance_between_planets:
		move_camera_to(Direction.RIGHT)

func move_camera_to(direction: Direction):
	if tween:
		return
#		tween.kill()
	var target_position = self.position.x + distance_between_planets * direction
	position.x = target_position
