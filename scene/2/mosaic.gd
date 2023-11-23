extends Node2D


@onready var deltoids = $Deltoids
@onready var junctions = $Junctions

var sketch = null


func set_attributes(input_: Dictionary) -> void:
	sketch  = input_.sketch
	
	init_junctions()
	init_deltoids()


func init_junctions() -> void:
	var input = {}
	input.mosaic = self

	var junction = Global.scene.junction.instantiate()
	junctions.add_child(junction)
	junction.set_attributes(input)


func init_deltoids() -> void:
	for type in Global.dict.deltoid:
		var input = {}
		input.mosaic = self
		input.type = type

		var deltoid = Global.scene.deltoid.instantiate()
		deltoids.add_child(deltoid)
		deltoid.set_attributes(input)
	
	var deltoid = deltoids.get_child(0)
	deltoid.position.x += 200
