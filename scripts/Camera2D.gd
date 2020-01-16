extends Camera2D

var dragging = false
onready var prev_pos = position

func _ready():
	set_process_input(true)


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed():
			prev_pos = event.position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position += (prev_pos - event.position)* (scale/2)
		prev_pos = event.position