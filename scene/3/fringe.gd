extends Line2D


var mosaic = null
var knots = []
var type = null
var index = null


func set_attributes(input_: Dictionary) -> void:
	mosaic = input_.mosaic
	type = input_.type
	index = Global.num.index.fringe
	Global.num.index.fringe += 1
	knots.append_array(input_.knots)
	
	for knot in knots:
		add_point(knot.position)
	
	mosaic.chart.fringes[knots[0]][knots[1]] = self
	mosaic.chart.fringes[knots[1]][knots[0]] = self
	default_color = Global.color.fringe[type]
	mosaic.connections[type].append(self)
