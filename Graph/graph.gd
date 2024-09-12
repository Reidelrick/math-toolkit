extends Node2D

@export var graph_scale : float = 100
var center : Vector2

func update_graph(ops : Dictionary):
	var graph_curve = Line2D.new()
	graph_curve.width = 2
	for p in range(center.x*graph_scale*2):
		var x = p/graph_scale-center.x
		var y = 0
		
		var op_i := 0
		for op in ops:
			if ops.values()[op_i] == 'x':
				if op == "x":
					y *= x
				elif op == "+":
					y += x
				elif op == "^":
					y **= x
				elif op == "sin":
					y += sin(int(ops.values()[op_i]))
				elif op == "cos":
					y += sin(int(ops.values()[op_i]))
				elif op == "tan":
					y += sin(int(ops.values()[op_i]))
			else:
				if op == "x":
					y *= int(ops.values()[op_i])
				elif op == "+":
					y += int(ops.values()[op_i])
				elif op == "^":
					y **= int(ops.values()[op_i])
				elif op == "sin":
					y += sin(int(ops.values()[op_i]))
				elif op == "cos":
					y += sin(int(ops.values()[op_i]))
				elif op == "tan":
					y += sin(int(ops.values()[op_i]))
			op_i += 1
		
		graph_curve.add_point(Vector2(
			x*graph_scale,
			-y*graph_scale
		))
		
	graph_curve.position = center
	graph_curve.name = "Graph"
	add_child(graph_curve)
	
func _ready():
	center = Vector2(
		ProjectSettings.get("display/window/size/viewport_width")/2,
		ProjectSettings.get("display/window/size/viewport_height")/2
		)
	
	var vertical_line = Line2D.new()
	vertical_line.add_point(Vector2(center.x, -center.y*2))
	for i in range(-center.y*2, center.y*4, graph_scale):
		var mark = Sprite2D.new()
		mark.texture = load("res://icon.svg")
		mark.scale /= 10
		mark.position=Vector2(center.x, i)
		vertical_line.add_point(Vector2(center.x, i))
		vertical_line.add_child(mark)
	vertical_line.add_point(Vector2(center.x, center.y*4))
	add_child(vertical_line)
	vertical_line.width = 1
	var horizontal_line = Line2D.new()
	horizontal_line.width = 1
	horizontal_line.add_point(Vector2(-center.x*2, center.y))
	for i in range(-center.x*2, center.x*4, graph_scale):
		var mark = Sprite2D.new()
		mark.texture = load("res://icon.svg")
		mark.scale /= 10
		mark.position=Vector2(i, center.y)
		vertical_line.add_point(Vector2(i, center.y))
		vertical_line.add_child(mark)
	horizontal_line.add_point(Vector2(center.x*4, center.y))
	add_child(horizontal_line)

func _process(delta):
	var cam_motion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_pressed("ui_accept"):
		$CamMover.move_and_collide(cam_motion*10)
	else:
		$CamMover.move_and_collide(cam_motion*2.5)
		
