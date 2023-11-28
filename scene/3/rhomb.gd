extends Polygon2D


var mosaic = null
var type = null
var index = null
var fringes = []
var connection = null
var center = null
var reverse = false


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	type = input_.type
	index = Global.num.index.rhomb
	Global.num.index.rhomb += 1
	
	init_vertexs()
	update_color()


func init_vertexs() -> void:
	while get_child_count() > 0:
		var child = get_child(0)
		remove_child(child)
		child.queue_free()
	
	center = Vector2()
	var _vertexs = []
	var vertex = Vector2()
	
	if connection == null:
		_vertexs.append(Vector2(vertex))
		
		vertex = Vector2(Global.num.fringe.a, 0)
		_vertexs.append(Vector2(vertex))
		
		var bodrder = _vertexs[1] - _vertexs[0]
		var angle = Global.num.rhomb.angle[type] / 180.0 * PI
		
		vertex = Vector2(bodrder.rotated(angle))
		vertex += _vertexs[1]
		vertex.x = round(vertex.x)
		vertex.y = round(vertex.y)
		_vertexs.append(Vector2(vertex))
		
		bodrder = _vertexs[0] - _vertexs[1]
		angle = -(180.0 - Global.num.rhomb.angle[type]) / 180.0 * PI
		
		vertex = Vector2(bodrder.rotated(angle))
		vertex += _vertexs[0]
		vertex.x = round(vertex.x)
		vertex.y = round(vertex.y)
		_vertexs.append(Vector2(vertex))
	else:
		vertex = connection.knots[0].position
		_vertexs.append(Vector2(vertex))
		
		vertex = connection.knots[1].position
		_vertexs.append(Vector2(vertex))
		
		var bodrder = _vertexs[1] - _vertexs[0]
		var angle = Global.num.rhomb.angle[type] / 180.0 * PI
		var pair = Global.dict.fringe.pair[connection.type]
		
		match pair:
			0:
				angle = -(180.0 - Global.num.rhomb.angle[type]) / 180.0 * PI
			1:
				angle *= -1
			2:
				angle = (180  + Global.num.rhomb.angle[type]) / 180.0 * PI
			3:
				angle *= -1
		
		if reverse:
			angle *= -1
		
		vertex = Vector2(bodrder.rotated(angle))
		vertex += _vertexs[1]
		vertex.x = round(vertex.x)
		vertex.y = round(vertex.y)
		_vertexs.append(Vector2(vertex))
		
		bodrder = _vertexs[0] - _vertexs[1]
		angle = -(180.0 - Global.num.rhomb.angle[type]) / 180.0 * PI
		
		match pair:
			0:
				angle = Global.num.rhomb.angle[type] / 180.0 * PI
			1:
				angle *= -1
			2:
				angle = Global.num.rhomb.angle[type] / 180.0 * PI
			3:
				angle *= -1
		
		if reverse:
			angle *= -1
		
		vertex = Vector2(bodrder.rotated(angle))
		vertex += _vertexs[0]
		vertex.x = round(vertex.x)
		vertex.y = round(vertex.y)
		_vertexs.append(Vector2(vertex))
		
		for _i in 4-pair:
			vertex = _vertexs.pop_front()
			_vertexs.append(vertex)
	
	if !reverse and cross_check():
		set_polygon(_vertexs)
		
		for _vertex in polygon:
			center += _vertex
		
		center /= polygon.size()
		
		for _i in polygon.size():
			_vertexs = [center]
			
			for _j in 2:
				var _index = (_i + _j) % polygon.size()
				_vertexs.append(polygon[_index])
			
			var poly = Polygon2D.new()
			add_child(poly)
			poly.set_polygon(_vertexs)
			poly.color = Global.color.rhomb[_i]
	else:
		reverse = true
		init_vertexs()


func lock() -> void:
	update_fringes()
	
	if connection != null:
		mosaic.connections[connection.type].erase(self)
		connection.visible = false
		connection = null
	
	mosaic.rhomb = null


func update_fringes() -> void:
	var _vertexs = polygon
	
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
				var _index = (_i + _j) % mosaic.knots.get_child_count()
				var knot = mosaic.knots.get_child(_index)
				input.knots.append(knot)
			
			mosaic.add_fringe(input)
			var fringe = mosaic.fringes.get_child(mosaic.fringes.get_child_count()-1)
			fringes.append(fringe)
	else:
		var knots = []
		
		for _i in polygon.size():
			var input = {}
			input.position = polygon[_i]
			var knot = null
			
			if mosaic.chart.knots.has(input.position):
				knot = mosaic.chart.knots[input.position]
			else:
				mosaic.add_knot(input)
				knot = mosaic.knots.get_child(mosaic.knots.get_child_count()-1)
			
			knots.append(knot)
		
		for _i in knots.size():
			var input = {}
			input.knots = []
			input.type = Global.dict.rhomb[type][_i]
			var fringe = null
			
			for _j in 2:
				var _index = (_i + _j) % knots.size()
				var knot = knots[_index]
				input.knots.append(knot)
			
			if mosaic.chart.fringes[input.knots[0]].has(input.knots[1]):
				fringe = mosaic.chart.fringes[input.knots[0]][input.knots[1]]
			else:
				mosaic.add_fringe(input)
				fringe = mosaic.fringes.get_child(mosaic.fringes.get_child_count()-1)
			
			fringes.append(fringe)


func update_color() -> void:
	var h = float(index) / Global.num.index.rhomb
	color = Color.from_hsv(h, 0.9, 0.7)


func set_connection(connection_: Line2D) -> void:
	connection = connection_
	init_vertexs()


func cross_check() -> bool:
	if connection == null:
		return true
	
	var _vertexs = []
	_vertexs.append_array(polygon)
	var flag = true
	
	for knot in connection.knots:
		var _index = _vertexs.find(knot.position)
		var a = _vertexs[_index]
		_index = 3 - _index
		var b = _vertexs[_index]
		
		for child in mosaic.chart.fringes[knot]:
			var fringe = mosaic.chart.fringes[knot][child]
			
			var c = fringe.knots[0].position
			var d = fringe.knots[1].position
			var dot = Geometry2D.line_intersects_line(a, b, c, d)
			
			flag = dot == null or dot == a
			
			if !flag:
				return flag
	
	return true
