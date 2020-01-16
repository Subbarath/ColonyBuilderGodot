extends Node2D

enum TYPES_CELL{
	WALL,
	FLOOR
	}

const ANGLE = 60
const SPRITES_CELL = preload("res://ressources/tiles.png")

var milieu = Vector2(0,0)
var verteces = []
var type_cell = TYPES_CELL.WALL setget _set_type, _get_type
export(int) var size = 32

export(Color) var mouse_enter_color
export(Color) var mouse_out_color

func init(_x_milieu, _y_milieu, _size):
	milieu = Vector2(_x_milieu,_y_milieu)
	position = milieu
	size = _size
	_calcul_verteces()
	_draw_tile()
	
func _calcul_verteces():
	verteces.append(Vector2(milieu.x, milieu.y-(size/2))) # N
	verteces.append(Vector2(milieu.x+(size/2), milieu.y-(size/4))) # NE
	verteces.append(Vector2(milieu.x+(size/2), milieu.y+(size/4))) # SE
	verteces.append(Vector2(milieu.x, milieu.y+(size/2))) # S
	verteces.append(Vector2(milieu.x-(size/2), milieu.y+(size/4))) # SW
	verteces.append(Vector2(milieu.x-(size/2), milieu.y-(size/4))) # NW
	verteces.append(Vector2(milieu.x, milieu.y-(size/2)))
	
func _set_type(_type_cell):
	type_cell = _type_cell
	_draw_tile()

func _get_type():
	return type_cell
	
func _draw_tile():
	get_node("Sprite").region_rect = _get_tile(type_cell)
	#draw_texture_rect_region(SPRITES_CELL,Rect2(-Vector2(16,16),Vector2(32,32)),_get_tile(type_cell))
	
func _get_tile(type):
	if type == TYPES_CELL.WALL:
		return Rect2(0,0,32,32)
	elif type == TYPES_CELL.FLOOR:
		return Rect2(32,0,32,32)
	return Rect2(0,0,32,32)


func _on_Area2D_mouse_entered():
	set_modulate(mouse_enter_color)


func _on_Area2D_mouse_exited():
	set_modulate(mouse_out_color)
