extends MarginContainer


#@onready var childs = $childs

var sketch = null


func set_attributes(input_: Dictionary) -> void:
	sketch  = input_.sketch
	
	init_childs()


func init_childs() -> void:
	for _i in 1:
		var input = {}
		input.cradle = self
	
		#var child = Global.scene.child.instantiate()
		#childs.add_child(child)
		#child.set_attributes(input)
