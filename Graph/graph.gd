extends Node2D

@export var graph_scale : float = 25
var center : Vector2

func update_graph(expression:String):
	var graph_curve = Line2D.new()
	graph_curve.width = 2
	for p in range(center.x*graph_scale*2):
		var x = float(p/graph_scale-center.x)
		var y : float
		
		var y_exp_txt := expression
		var y_exp = Expression.new()
		
		var y_exp_txt_split = y_exp_txt.split()
		y_exp_txt = ""
		for c in y_exp_txt_split:
			if c == "x":c = str(x)
			y_exp_txt+=c
		
		print(y_exp_txt)
		var error = y_exp.parse(y_exp_txt)
		if error != OK:
			print(y_exp.get_error_text())
			return
		var result = y_exp.execute()
		if not y_exp.has_execute_failed():
			y = result
		
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
		
