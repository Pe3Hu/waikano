extends MarginContainer


@onready var cradle = $Cradle
@onready var mosaic = $Mosaic


func _ready() -> void:
#	var input = {}
#	input.parent = self
#
#	var child = Global.scene.child.instantiate()
#	childs.add_child(child)
#	child.set_attributes(input)
	
	var input = {}
	input.sketch = self
	cradle.set_attributes(input)
	mosaic.set_attributes(input)
