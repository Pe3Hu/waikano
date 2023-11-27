extends Polygon2D


var mosaic = null
var type = null
var index = null
var connection = null
var center = null


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	type = input_.type
	index = Global.num.index.rhomb
	Global.num.index.rhomb += 1
	
	init_vertexs()
	update_fringes()
	update_color()


func init_vertexs() -> void:
	center = Vector2()
	var vertexs = []
	
	if connection == null:
		var vertex = Vector2()
		vertexs.append(Vector2(vertex))
		
		vertex = Vector2(Global.num.fringe.a, 0)
		vertexs.append(Vector2(vertex))
		
		var bodrder = vertexs[1] - vertexs[0]
		var angle = Global.num.rhomb.angle[type] / 180.0 * PI
		vertex = Vector2(bodrder.rotated(angle))
		vertex += vertexs[1]
		vertexs.append(Vector2(vertex))
		
		bodrder = vertexs[0] - vertexs[1]
		angle = -(180.0 - Global.num.rhomb.angle[type]) / 180.0 * PI
		vertex = Vector2(bodrder.rotated(angle))
		vertex += vertexs[0]
		vertexs.append(Vector2(vertex))
	
	set_polygon(vertexs)
	
	for vertex in polygon:
		center += vertex
	
	center /= polygon.size()
	
	for _i in polygon.size():
		vertexs = [center]
		
		for _j in 2:
			var index = (_i + _j) % polygon.size()
			vertexs.append(polygon[index])
		
		var poly = Polygon2D.new()
		add_child(poly)
		poly.set_polygon(vertexs)
		poly.color = Global.color.fringe[_i]
		#poly.z_index = 1


func update_fringes() -> void:
	var vertexs = polygon
	
	if mosaic.rhombs.get_child_count() == 1:
		for _i in polygon.size():
			var input = {}
			input.position = polygon[_i]
			mosaic.add_knot(input)
		
		for _i in polygon.size():
			var input = {}
			input.knots = []
			input.type = Global.dict.rhomb[type][_i]
			
			for _j in 2:
				var index = (_i + _j) % mosaic.knots.get_child_count()
				var knot = mosaic.knots.get_child(index)
				input.knots.append(knot)
			
			mosaic.add_fringe(input)
	


func update_color() -> void:
	var h = float(index) / Global.num.index.rhomb
	color = Color.from_hsv(h, 0.9, 0.7)

