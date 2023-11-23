extends Node


@onready var sketch = $Sketch


func _ready() -> void:
	#datas.sort_custom(func(a, b): return a.value < b.value)
	#012 description
	pass


func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_Q:
				if event.is_pressed(): #&& !event.is_echo():
					sketch.mosaic.deltoids.get_child(1).rotate_around_anchor(-1)
			KEY_E:
				if event.is_pressed():
					sketch.mosaic.deltoids.get_child(1).rotate_around_anchor(1)
			KEY_A:
				if event.is_pressed(): 
					sketch.mosaic.deltoids.get_child(1).shift_anchor(-1)
			KEY_D:
				if event.is_pressed():
					sketch.mosaic.deltoids.get_child(1).shift_anchor(1)


func _process(delta_) -> void:
	$FPS.text = str(Engine.get_frames_per_second())
