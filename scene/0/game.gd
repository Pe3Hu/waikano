extends Node


@onready var sketch = $Sketch


func _ready() -> void:
	#datas.sort_custom(func(a, b): return a.value < b.value)
	#012 description
	pass


func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_SPACE:
				if event.is_pressed():
					sketch.mosaic.add_deltoid()
			KEY_Q:
				if event.is_pressed(): #&& !event.is_echo():
					sketch.mosaic.junctions.get_child(0).shift_deltoid(-1)
			KEY_E:
				if event.is_pressed():
					sketch.mosaic.junctions.get_child(0).shift_deltoid(1)
			KEY_A:
				if event.is_pressed(): 
					sketch.mosaic.junctions.get_child(0).deltoid.shift_anchor(-1)
			KEY_D:
				if event.is_pressed():
					sketch.mosaic.junctions.get_child(0).deltoid.shift_anchor(1)


func _process(delta_) -> void:
	$FPS.text = str(Engine.get_frames_per_second())
