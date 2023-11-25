extends Polygon2D


var mosaic = null
var type = null
var anchor = 0
var angle = 0
var index = null
var options = {}


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	type = input_.type
	index = Global.num.index.deltoid
	Global.num.index.deltoid += 1
	shift_anchor(0)
	update_color()


func init_vertexs() -> void:
	var vertexs = []
	
	for vertex in Global.dict.deltoid[type].vertexs:
		vertexs.append(Vector2(vertex) - Global.dict.deltoid[type].vertexs[anchor])
	
	set_polygon(vertexs)


func update_color() -> void:
	var h = float(index) / Global.num.index.deltoid
	color = Color.from_hsv(h, 0.9, 0.7)


func shift_anchor(shift_: int) -> void:
	var n = Global.dict.deltoid[type].vertexs.size()
	anchor = (anchor + shift_ + n) % n
	angle = 0
	init_vertexs()


func rotate_around_anchor(angle_: int) -> void:
	angle = (angle + angle_ * Global.dict.deltoid[type].angles[anchor] + 360) % 360
	rotation = angle / 180.0 * PI


func set_angle(angle_: float) -> void:
	rotation = angle_ / 180.0 * PI
