extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.edge = [1, 2, 3, 4, 5, 6]


func init_num() -> void:
	num.index = {}
	num.index.junction = 0
	num.index.deltoid = 0
	num.index.rhomb = 0
	num.index.fringe = 0
	num.index.knot = 0
	
	num.junction = {}
	num.junction.r = 16
	
	num.deltoid = {}
	num.deltoid.a = 100
	num.deltoid.c = num.deltoid.a * cos(PI/5)
	num.deltoid.h = num.deltoid.a * sin(PI/5)
	num.deltoid.d = num.deltoid.a - num.deltoid.c
	
	num.knot = {}
	num.knot.r = 8
	
	num.fringe = {}
	num.fringe.a = 100
	
	num.rhomb = {}
	num.rhomb.angle = {}
	num.rhomb.angle.skinny = 144
	num.rhomb.angle.fatty = 108


func init_dict() -> void:
	init_neighbor()
	init_deltoid()
	init_junction()
	init_rhomb()
	init_fringe()
	
	dict.direction = {}
	dict.direction.clockwise = 1
	dict.direction.counterclockwise = -1


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_deltoid() -> void:
	dict.deltoid = {}
	dict.deltoid.convex = {}
	dict.deltoid.convex.angles = [72, 72, 144, 72]
	dict.deltoid.convex.vertexs = [
		Vector2(-num.deltoid.c, 0),
		Vector2(0, -num.deltoid.h),
		Vector2(num.deltoid.d, 0),
		Vector2(0, num.deltoid.h)
	]
	dict.deltoid.concave = {}
	dict.deltoid.concave.angles = [72, 36, 216, 36]
	dict.deltoid.concave.vertexs = [
		Vector2(-num.deltoid.c, 0),
		Vector2(0, -num.deltoid.h),
		Vector2(-num.deltoid.d, 0),
		Vector2(0, num.deltoid.h)
	]


func init_junction() -> void:
	#sun moon crown butterfly fox hood bouquet
	dict.junction = {}
	dict.junction.sun = {}
	dict.junction.sun.deltoid = ["concave","concave","concave","concave","concave"]
	dict.junction.sun.anchor = [2, 2, 2, 2, 2]
	dict.junction.moon = {}
	dict.junction.moon.deltoid = ["convex","convex","convex","convex","convex"]
	dict.junction.moon.anchor = [2, 2, 2, 2, 2]
	dict.junction.crown = {}
	dict.junction.crown.deltoid = ["convex","concave","convex","convex","concave"]
	dict.junction.crown.anchor = [0, 1, 2, 2, 3]
	dict.junction.butterfly = {}
	dict.junction.butterfly.deltoid = ["concave","convex","convex","convex","convex"]
	dict.junction.butterfly.anchor = [2, 1, 3, 1, 3]
	dict.junction.hood = {}
	dict.junction.hood.deltoid = ["concave","concave","convex","convex","concave"]
	dict.junction.hood.anchor = [2, 2, 1, 3, 2]
	dict.junction.fox = {}
	dict.junction.fox.deltoid = ["concave","concave","convex","convex"]
	dict.junction.fox.anchor = [1, 3, 0, 0]
	dict.junction.bouquet = {}
	dict.junction.bouquet.deltoid = ["concave","convex","convex"]
	dict.junction.bouquet.anchor = [0, 1, 3]


func init_rhomb() -> void:
	dict.rhomb = {}
	dict.rhomb.skinny = [0, 1, 2, 3]
	dict.rhomb.fatty = [2, 1, 3, 0]


func init_fringe() -> void:
	dict.fringe = {}
	dict.fringe.pair = {}
	dict.fringe.pair[0] = 3
	dict.fringe.pair[1] = 2
	dict.fringe.pair[2] = 1
	dict.fringe.pair[3] = 0

func init_emptyjson() -> void:
	dict.emptyjson = {}
	dict.emptyjson.title = {}
	
	var path = "res://asset/json/.json"
	var array = load_data(path)
	
	for emptyjson in array:
		var data = {}
		
		for key in emptyjson:
			if key != "title":
				data[key] = emptyjson[key]
		
		dict.emptyjson.title[emptyjson.title] = data


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.junction = load("res://scene/2/junction.tscn")
	scene.deltoid = load("res://scene/2/deltoid.tscn")
	
	scene.rhomb = load("res://scene/3/rhomb.tscn")
	scene.fringe = load("res://scene/3/fringe.tscn")
	scene.knot = load("res://scene/3/knot.tscn")
	
	
	pass


func init_vec():
	vec.size = {}
	vec.size.letter = Vector2(20, 20)
	vec.size.icon = Vector2(48, 48)
	vec.size.number = Vector2(5, 32)
	
	vec.size.aspect = Vector2(32, 32)
	vec.size.box = Vector2(100, 100)
	vec.size.bar = Vector2(120, 12)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.fringe = {}
	color.fringe[0] = Color.from_hsv(60 / h, 0.9, 0.7)
	color.fringe[1] = Color.from_hsv(120 / h, 0.9, 0.7)
	color.fringe[2] = Color.from_hsv(210 / h, 0.9, 0.7)
	color.fringe[3] = Color.from_hsv(0 / h, 0.9, 0.7)
	
	color.rhomb = {}
	color.rhomb[0] = Color.from_hsv(90 / h, 0.9, 0.7)
	color.rhomb[1] = Color.from_hsv(240 / h, 0.9, 0.7)
	color.rhomb[2] = Color.from_hsv(300 / h, 0.9, 0.7)
	color.rhomb[3] = Color.from_hsv(30 / h, 0.9, 0.7)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
