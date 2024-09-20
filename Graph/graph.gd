extends Node2D

@export var graph_scale : float = 10
@export_range(0, 10) var graduation_length : float = 1
@export var minor_lines : int = 1
@export var primary_lines : int = 10
var center : Vector2

func create_curve(expression:String, color:Color):
	var graph_curve = Line2D.new()
	graph_curve.width = 2
	graph_curve.default_color = color
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
		
	graph_curve.name = "Graph"
	var curve_param = load("res://Graph/CurveParam.tscn").instantiate()
	curve_param.curve=graph_curve
	curve_param.text = expression
	%Curves.add_child(curve_param)
	add_child(graph_curve)
	
func _ready():
	center = Vector2(
		ProjectSettings.get("display/window/size/viewport_width")/2,
		ProjectSettings.get("display/window/size/viewport_height")/2
		)
	
	var vertical_line_up = Line2D.new()
	vertical_line_up.default_color=Color("000000")
	vertical_line_up.width = 1
	var p_line_vu=0
	for p in range(0, center.y*graph_scale, graph_scale/minor_lines):
		vertical_line_up.add_point(Vector2(0, -p))
		var graduation = Line2D.new()
		graduation.default_color=Color("000000")
		if p_line_vu < primary_lines:
			graduation.points = [
				Vector2(-graduation_length, 0),
				Vector2(graduation_length, 0)
			]
			p_line_vu += 1
		else:
			graduation.points = [
				Vector2(-graduation_length*2, 0),
				Vector2(graduation_length*2, 0)
			]
			p_line_vu = 0
		graduation.width = 1
		graduation.position = Vector2(0, -p)
		vertical_line_up.add_child(graduation)
	add_child(vertical_line_up)

	var vertical_line_down = Line2D.new()
	vertical_line_down.default_color=Color("000000")
	vertical_line_down.width = 1
	var p_line_vd=0
	for p in range(0, center.y*graph_scale, graph_scale/minor_lines):
		vertical_line_down.add_point(Vector2(0, p))
		var graduation = Line2D.new()
		graduation.default_color=Color("000000")
		if p_line_vd < primary_lines:
			graduation.points = [
				Vector2(-graduation_length, 0),
				Vector2(graduation_length, 0)
			]
			p_line_vd += 1
		else:
			graduation.points = [
				Vector2(-graduation_length*2, 0),
				Vector2(graduation_length*2, 0)
			]
			p_line_vd = 0
		graduation.width = 1
		graduation.position = Vector2(0, p)
		vertical_line_down.add_child(graduation)
	add_child(vertical_line_down)

	var horizontal_line_left = Line2D.new()
	horizontal_line_left.default_color=Color("000000")
	horizontal_line_left.width = 1
	var p_line_hl=0
	for p in range(0, center.x*graph_scale, graph_scale/minor_lines):
		horizontal_line_left.add_point(Vector2(-p, 0))
		var graduation = Line2D.new()
		graduation.default_color=Color("000000")
		if p_line_hl < primary_lines:
			graduation.points = [
				Vector2(0, graduation_length),
				Vector2(0, -graduation_length)
			]
			p_line_hl += 1
		else:
			graduation.points = [
				Vector2(0, graduation_length*2),
				Vector2(0, -graduation_length*2)
			]
			p_line_hl = 0
		graduation.width = 1
		graduation.position = Vector2(-p, 0)
		horizontal_line_left.add_child(graduation)
	add_child(horizontal_line_left)

	var horizontal_line_right = Line2D.new()
	horizontal_line_right.default_color=Color("000000")
	horizontal_line_right.width = 1
	var p_line_hr=0
	for p in range(0, center.x*graph_scale, graph_scale/minor_lines):
		horizontal_line_right.add_point(Vector2(p, 0))
		var graduation = Line2D.new()
		graduation.default_color=Color("000000")
		if p_line_hr < primary_lines:
			graduation.points = [
				Vector2(0,-graduation_length),
				Vector2(0, graduation_length)
			]
			p_line_hr += 1
		else:
			graduation.points = [
				Vector2(0,-graduation_length*2),
				Vector2(0, graduation_length*2)
			]
			p_line_hr = 0
		graduation.width = 1
		graduation.position = Vector2(p, 0)
		horizontal_line_right.add_child(graduation)
	add_child(horizontal_line_right)

func _process(_delta):
	var cam_motion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_pressed("ui_accept"):
		$CamMover.move_and_collide(cam_motion*10)
	else:
		$CamMover.move_and_collide(cam_motion*2.5)
	if Input.is_action_pressed("ui_zoom"):
		$CamMover/Camera2D.zoom += Vector2(0.01,0.01)
	elif Input.is_action_pressed("ui_unzoom"):
		$CamMover/Camera2D.zoom -= Vector2(0.01,0.01)

	if Input.is_action_pressed("graph_show_coords"):
		%Coords.visible = true
		%Coords.text = str(
			round(get_global_mouse_position())/graph_scale
			)
		$CoordsLines.visible = true
		$CoordsLines.points = [
			Vector2(get_global_mouse_position().x,0),
			get_global_mouse_position(),
			Vector2(0,get_global_mouse_position().y)
		]
		
	else:
		$CoordsLines.visible = false
		%Coords.visible = false
	
	if Input.is_action_just_pressed("graph_hide_curves_menu"):%Curves.visible = !%Curves.visible
	if Input.is_action_just_pressed("graph_hide_expression"):%Expression.visible = !%Expression.visible


func _on_expression_text_submitted(new_text: String) -> void:
	create_curve(new_text, %Color.color)
