extends Polygon2D


var mosaic = null
var angle = {}
var contenders = {}
var deltoids = []
var deltoid = null
var order = null


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	
	init_vertexs()
	angle.directions = {}
	
	for direction in Global.dict.direction:
		angle.directions[direction] = 0
		contenders[direction] = []
		
	angle.options = {}


func init_vertexs() -> void:
	var n = 4
	var vertexs = []
	var angle = PI * 2 / n
	
	for _i in n:
		var vertex = Vector2.from_angle(angle * _i) * Global.num.junction.r
		vertexs.append(vertex)
	
	set_polygon(vertexs)


func add_deltoid(deltoid_: Polygon2D) -> void:
	if deltoid != null:
		if !deltoids.is_empty():
			shift_deltoid(0)
		
		fix_deltoid()
	
	order = 0
	deltoid = deltoid_
	angle.options = {}
	
	for direction in Global.dict.direction:
		deltoid.options[direction] = []
	
	if deltoids.is_empty():
		angle.options["clockwise"] = 0
	else:
		for direction in angle.directions:
			check_direction(direction)


func shift_deltoid(value_: int) -> void:
	if order == null:
		order = 0
	
	var n = 0
	
	for direction in Global.dict.direction:
		n += deltoid.options[direction].size()
	
	order = (order + value_ + n) % n
	
	var _order = order
	var direction = "clockwise"
	
	if order >= deltoid.options.clockwise.size():
		direction = "counterclockwise"
		_order -= deltoid.options.clockwise.size()
	
	var _anchor = deltoid.options[direction][_order]
	var _angle = angle.directions[direction] + Global.dict.deltoid[deltoid.type].angles[deltoid.anchor] / 2 * Global.dict.direction[direction]
	deltoid.set_angle(_angle)
	deltoid.set_anchor(_anchor)


func fix_deltoid() -> void:
	if !angle.options.is_empty():
		var direction = angle.options.keys()[order]
		
		if deltoids.is_empty():
			deltoids.push_front(deltoid)
			
			for _direction in angle.directions:
				angle.directions[_direction] += Global.dict.deltoid[deltoid.type].angles[deltoid.anchor] / 2 * Global.dict.direction[_direction]
		else:
			angle.directions[direction] += Global.dict.deltoid[deltoid.type].angles[deltoid.anchor] / 2 * Global.dict.direction[direction]
			deltoid.set_angle(angle.directions[direction])
			
			match direction:
				"clockwise":
					deltoids.push_back(deltoid)
				"counterclockwise":
					deltoids.push_front(deltoid)
			
			angle.directions[direction] += Global.dict.deltoid[deltoid.type].angles[deltoid.anchor] / 2 * Global.dict.direction[direction]
	
	update_contenders()
	deltoid = null


func update_contenders() -> void:
	for type in Global.dict.junction:
		get_contenders_based_on_junction_type(type)
	
	print(contenders)


func get_contenders_based_on_junction_type(type_: String) -> void:
	for direction in Global.dict.direction:
		contenders[direction] = []
	
	var types = Global.dict.junction[type_].deltoid
	var anchors = Global.dict.junction[type_].anchor
	print([types], [anchors])
	
	for _deltoid in deltoids:
		print([_deltoid.type, _deltoid.anchor])
	
	for _i in types.size():
		var flag = true
		
		for _j in deltoids.size():
			var _deltoid = deltoids[_j]
			var _index = (_i + _j) % types.size()
			var _type = types[_index]
			var _anchor = anchors[_index]
			
			flag = flag and _deltoid.anchor == _anchor and _deltoid.type == _type
			
			if !flag:
				break
		
		if flag:
			for direction in Global.dict.direction:
				var _index = 0
				
				match direction:
					"clockwise":
						_index = (_i + 1) % types.size()
					"counterclockwise":
						_index = (_i + types.size() - 1) % types.size()
				
				var data = {}
				data.type = types[_index]
				data.anchor = anchors[_index]
				contenders[direction].append(data)


func check_direction(direction_: String) -> void:
	var flag = true
	
	if !deltoids.is_empty():
		for data in contenders[direction_]:
			if data.type == deltoid.type:
				deltoid.options[direction_].append(data.anchor)
	
	if !deltoid.options[direction_].is_empty():
		angle.options[direction_] = angle.directions[direction_]
		angle.options[direction_] += Global.dict.deltoid[deltoid.type].angles[deltoid.anchor] * Global.dict.direction[direction_]
