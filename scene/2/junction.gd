extends Polygon2D


var mosaic = null
var angle = 0
var deltoids = []
var deltoid = null


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	
	init_vertexs()


func init_vertexs() -> void:
	var n = 4
	var vertexs = []
	var angle = PI * 2 / n
	
	for _i in n:
		var vertex = Vector2.from_angle(angle * _i) * Global.num.junction.r
		vertexs.append(vertex)
	
	set_polygon(vertexs)


func add_deltoid(deltoid_: Polygon2D) -> void:
	deltoid = deltoid_
	deltoids.append(deltoid_)
