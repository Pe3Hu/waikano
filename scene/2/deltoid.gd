extends Polygon2D


var mosaic = null
var type = null
var anchor = 0
var angle = 0


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	type = input_.type
	
	shift_anchor(0)


func init_vertexs() -> void:
	var vertexs = []
	
	for vertex in Global.dict.deltoid[type].vertexs:
		vertexs.append(Vector2(vertex) - Global.dict.deltoid[type].vertexs[anchor])
	
	set_polygon(vertexs)


func shift_anchor(shift_: int) -> void:
	var n = Global.dict.deltoid[type].vertexs.size()
	anchor = (anchor + shift_ + n) % n
	angle = 0
	init_vertexs()


func rotate_around_anchor(angle_: int) -> void:
	angle = (angle + angle_ * Global.dict.deltoid[type].angles[anchor] + 360) % 360
	rotation = angle / 180.0 * PI
