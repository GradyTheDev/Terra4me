class_name DialogSystem
extends Node

signal message_over(message: Dialog)

@export_group("Settings")
@export var char_delay: float
@export var pause_delay: float
@export var new_line_delay: float
@export var msg_end_wait_to_clear: float
@export var max_chars: int

@export_group("Nodes")
@export var portrait_node: TextureRect
@export var dialog_node: RichTextLabel
@export var character_label_node: RichTextLabel
@export var sound_msg_start_node: AudioStreamPlayer
@export var sound_msg_end_node: AudioStreamPlayer
@export var sound_type_node: AudioStreamPlayer
@export var sound_static: AudioStreamPlayer

var _current_msg: Dialog
var _index: int = -1
var _timer: float
var _clear_next: bool

var _pause_chars := ".,!?".split()

func _process(delta: float):
	if process_mode == PROCESS_MODE_DISABLED:
		return

	if _current_msg == null:
		sound_static.stop()
		return
	else:
		if not sound_static.playing:
			sound_static.play()
	
	_timer -= delta

	if _timer > 0:
		return
	
	_index += 1

	if _index > len(_current_msg.message):
		var old = _current_msg
		_current_msg = null
		dialog_node.text = ""
		character_label_node.text = ""
		portrait_node.texture = Dialog.static_get_portrait_image(Dialog.PortraitsEnum.blank)
		message_over.emit(old)
		if not sound_msg_end_node.playing:
			sound_msg_end_node.play()
		return
	
	if _index == len(_current_msg.message):
		_timer = msg_end_wait_to_clear
		return

	if _clear_next:
		_clear_next = false
		dialog_node.text = ""
	
	var c = _current_msg.message[_index]
	if c == "\n":
		_clear_next = true
		_timer = new_line_delay
	elif c in _pause_chars:
		dialog_node.text += c
		_timer = pause_delay
	else:
		dialog_node.text += c
		_timer = char_delay
	if not sound_type_node.playing:
		sound_type_node.play()
	
	if len(dialog_node.text) > max_chars and max_chars > 0:
		dialog_node.text = dialog_node.text.erase(0, 1)


func play_dialog(msg: Dialog):
	if process_mode == Node.PROCESS_MODE_DISABLED:
		return
	
	if msg == null:
		var old = _current_msg
		_current_msg = null
		character_label_node.text = ""
		dialog_node.text = ""
		portrait_node.texture = Dialog.static_get_portrait_image(Dialog.PortraitsEnum.blank)
		
		if old != null:
			message_over.emit(_current_msg)
		return
	
	_current_msg = msg
	_index = -1
	_clear_next = false
	_timer = char_delay
	character_label_node.text = msg.get_crew_name()
	portrait_node.texture = msg.get_portrait_image()
	if not sound_msg_start_node.playing:
		sound_msg_start_node.play()


func _input(event):
	if event is InputEventKey:
		if not event.is_pressed():
			if event.keycode == KEY_ENTER or event.keycode == KEY_SPACE:
				play_dialog(null)