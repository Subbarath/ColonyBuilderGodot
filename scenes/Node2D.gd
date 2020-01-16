extends Node2D

const HEXCELL = preload("prefab/Hexagon/Hexagon.tscn")
const SPRITES_CELL = preload("res://ressources/tiles.png")

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
export(int) var size = 32

# Called when the node enters the scene tree for the first time.
func _ready():	
	for i in range(numberofrows):
		hexgrid.append([])
		for j in range(numberofcols):
			var cell = HEXCELL.instance()
			cell.name = "HexCell"
			cell.init(i*size +((size/2)*(j%2)),j*size - (size/4)*j,size)
			self.add_child(cell)
			cell.set_owner(self)
			if(i >= 7 and j >=7) and (i<=8) :
				cell._set_type( TYPES_CELL.FLOOR)
			hexgrid[i].append(cell)
				
			#get_parent().get_node("World").set_cellv(hexgrid[i][j].milieu,_get_tile(hexgrid[i][j]._get_type()))
			
	#get_parent().get_node("World").update_bitmask_region()
	
func _draw():
#	for i in range(numberofrows):
#		for j in range (numberofcols):
#			draw_texture_rect_region(SPRITES_CELL,Rect2(hexgrid[i][j].milieu - Vector2(16,16),Vector2(32,32)),_get_tile(hexgrid[i][j].type_cell))
			
	for i in range(numberofrows):
		for j in range (numberofcols):
			draw_polyline(hexgrid[i][j].verteces,Color("000000"))
			
			
	## DEBUG permet d'avoir toujours la ligne X et la ligne Y
	draw_line(Vector2(0,-1000),Vector2(0,1000),Color(255,2555,255))
	draw_line(Vector2(-1000,0),Vector2(1000,0),Color(255,2555,255))
	
func _get_tile(type):
	if type == TYPES_CELL.WALL:
		return Rect2(0,0,32,32)
	elif type == TYPES_CELL.FLOOR:
		return Rect2(32,0,32,32)
	return Rect2(0,0,32,32)
	