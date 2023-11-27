extends Node2D


@onready var deltoids = $Deltoids
@onready var junctions = $Junctions
@onready var rhombs = $Rhombs
@onready var fringes = $Fringes
@onready var knots = $Knots

var sketch = null
var connections = {}


func set_attributes(input_: Dictionary) -> void:
	sketch  = input_.sketch
	init_rhombs()
	#init_junctions()
	#init_deltoids()


func init_junctions() -> void:
	var input = {}
	input.mosaic = self

	var junction = Global.scene.junction.instantiate()
	junctions.add_child(junction)
	junction.set_attributes(input)


func init_deltoids() -> void:
	for _i in 2:
	#for type in Global.dict.deltoid:
		add_deltoid()


func add_deltoid() -> void:
	var junction = junctions.get_child(0)
	var type = Global.dict.deltoid.keys()[Global.num.index.deltoid % 2]#"convex"
	
	var input = {}
	input.mosaic = self
	input.type = type

	var deltoid = Global.scene.deltoid.instantiate()
	deltoids.add_child(deltoid)
	deltoid.set_attributes(input)
	junction.add_deltoid(deltoid)
	#var deltoid = deltoids.get_child(0)
	#deltoid.position.x += 200


func init_rhombs() -> void:
	for type in Global.color.fringe:
		connections[type] = []
	
	
	var input = {}
	input.type = Global.dict.rhomb.keys()[Global.num.index.rhomb % 2]
	add_rhomb(input)

#fit

func add_rhomb(input_: Dictionary) -> void:
	input_.mosaic = self

	var rhomb = Global.scene.rhomb.instantiate()
	rhombs.add_child(rhomb)
	rhomb.set_attributes(input_)


func add_fringe(input_: Dictionary) -> void:
	input_.mosaic = self

	var fringe = Global.scene.fringe.instantiate()
	fringes.add_child(fringe)
	fringe.set_attributes(input_)


func add_knot(input_: Dictionary) -> void:
	input_.mosaic = self

	var knot = Global.scene.knot.instantiate()
	knots.add_child(knot)
	knot.set_attributes(input_)