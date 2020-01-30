extends Node2D

const HEXGRID = preload("res://scripts/HexGrid/HexGrid.gd")
const SPRITES_CELL = preload("res://ressources/tiles_new.png")

var HexGrid = HEXGRID.new()
var hex_scale = 50

onready var highlight = get_node("Highlight")
onready var area_coords = get_node("Highlight/AreaCoords")
onready var hex_coords = get_node("Highlight/HexCoords")
onready var tilemap = get_node("../TileMap")

enum TYPES_CELL{
	WALL,
	FLOOR
}

const TILES={
	"WALL":0,
	"FLOOR":1
}
export var hexgrid = []
export(int) var numberofrows
export(int) var numberofcols
export(int) var size = 50
export(int) var chunk_size = 4

func _process(delta):
	pass
#	var mouse_pos = get_local_mouse_position()
#	if OS.is_debug_build() :
#		print("%s  %s" % [mouse_pos.x / 32, mouse_pos.y /32])

# Called when the node enters the scene tree for the first time.
func _ready():	
	HexGrid.hex_scale = Vector2(hex_scale,hex_scale)
	var pos_relative = self.transform.affine_inverse()
	tilemap.position = Vector2(round(hex_scale  * 3/4), round(-(hex_scale * sqrt(3)/2) / 2))
	
	for x in range(0,numberofrows,chunk_size):
		for y in range (0,numberofcols,chunk_size):
			generateChunk(x,y,chunk_size)
			
#func _draw():
##	for i in range(numberofrows):
##		for j in range (numberofcols):
##			draw_texture_rect_region(SPRITES_CELL,Rect2(hexgrid[i][j].milieu - Vector2(16,16),Vector2(32,32)),_get_tile(hexgrid[i][j].type_cell))
##
#	var hexcell_pos
#	var pos_relative = self.transform.affine_inverse()
##	for i in range(numberofrows):
##		for j in range (numberofcols):
##			pos_relative = self.transform.affine_inverse() * Vector2(i,j)
##			hexcell_pos = HexGrid.get_hex_center(pos_relative)
##			print(HexGrid.get_hex_center(pos_relative))
##			draw_texture_rect_region(SPRITES_CELL,Rect2(hexcell_pos - Vector2(size/2,size/2),Vector2(size,size)),Rect2(0,0,size,size))
##			draw_rect(Rect2(hexcell_pos.x - 25,- hexcell_pos.y+ 21.615,20,20),Color(0,0,0))
#
#
#	## DEBUG permet d'avoir toujours la ligne X et la ligne Y
#	draw_line(Vector2(0,-1000),Vector2(0,1000),Color(255,2555,255))
#	draw_line(Vector2(-1000,0),Vector2(1000,0),Color(255,2555,255))

func _get_tile(type):
	if type == TYPES_CELL.WALL:
		return Rect2(0,0,32,32)
	elif type == TYPES_CELL.FLOOR:
		return Rect2(32,0,32,32)
	return Rect2(0,0,32,32)

func _unhandled_input(event):
	if 'position' in event:
		var relative_pos = self.transform.affine_inverse() * get_global_mouse_position()
#		print(str(relative_pos))
#		print(str(HexGrid.get_hex_at(relative_pos).axial_coords))
		# Display the coords used
		if area_coords != null:
			area_coords.text = str(relative_pos)
		if hex_coords != null:
			hex_coords.text = str(HexGrid.get_hex_at(relative_pos).axial_coords)

		# Snap the highlight to the nearest grid cell
		if highlight != null:
			highlight.position = HexGrid.get_hex_center(HexGrid.get_hex_at(relative_pos))
			
func generateChunk(x,y,t):
	for i in range(x,x+t):
		for j in range(y,y+t):
			tilemap.set_cellv(Vector2(i,j),1)
