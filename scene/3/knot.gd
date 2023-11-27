extends Polygon2D


var mosaic = null
var index = null


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	index = Global.num.index.knot
	Global.num.index.knot += 1
	
	init_vertexs()
	position = input_.position


func init_vertexs() -> void:
	var n = 4
	var vertexs = []
	var angle = PI * 2 / n
	
	for _i in n:
		var vertex = Vector2.from_angle(angle * _i) * Global.num.knot.r
		vertexs.append(vertex)
	
	set_polygon(vertexs)

