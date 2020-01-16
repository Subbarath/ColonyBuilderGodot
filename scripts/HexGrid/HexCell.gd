extends Node

enum TYPE_TILE{FLOOR,WALL}

# Directions
const DIR_N = Vector3(0,1,-1)
const DIR_NE = Vector3(1,0,-1)
const DIR_NW = Vector3(1,-1,0)
const DIR_S = Vector3(0,-1,1)
const DIR_SE = Vector3(-1,1,0)
const DIR_SW = Vector3(-1,0,1)

enum DIR_ALL{DIR_N,DIR_NE,DIR_SE,DIR_S,DIR_SW,DIR_NW}


var cube_coord = Vector3(0,0,0) setget _set_cube_coord, _get_cube_coord

func _axial_to_cube_coord(x,y):
	return Vector3(x,y,-x-y)	

func _set_cube_coord(value):
	if abs(value.x + value.y + value.y)>0.0001 :
		print("impossible : x + y + z != 0")
		return
	
	cube_coord = Vector3()
	
func _get_cube_coord():
	return cube_coord
	
func _coord_from_object(object):
	# Cette fonction va permettre de récupérer
	# les coordonnées (x,y,z) à partir d'un objet.
	# Cette récupération peut se faire seulement de 3 manières :
	#	 - cet objet est un Vector3
	#	 - Cet objet est un Vector2
	#	 - Cet objet est une HexCell
	
	if typeof(object) == TYPE_VECTOR3:
		return object
	elif typeof(object) == TYPE_VECTOR2:
		return _axial_to_cube_coord(object.x, object.y)
	elif typeof(object) == TYPE_OBJECT and object.hasmethod("_get_cube_coord"):
		return object._get_cube_coord()
	pass

func _distanceToHex(hexcell):
	# récupère la distance entre deux cellules de la grille
	hexcell = _coord_from_object(hexcell)
	return int( (	abs(hexcell.x - cube_coord.x) + 
					abs(hexcell.y - cube_coord.y) + 
					abs(hexcell.z - cube_coord.z)
				) / 2
			)