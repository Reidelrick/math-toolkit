extends Panel
class_name Operation

@onready var GraphUI = get_parent().get_parent()

@export var number : float:
	set(value):
		number = value
		update()
@export_enum("x", "+", "^") var operator : String:
	set(value):
		operator = value
		update()
@export var x_mode : bool:
	set(value):
		x_mode = value
		update()


var label = Label.new()

func _ready():
	
	add_child(label)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	update()

func update():
	if x_mode:
		label.text = operator + " x"
	else:
		if number < 0 and operator == "+":
			label.text = str("- ", abs(number))
		elif (number < 1 and number > -1 and not number == 0) and operator == "x":
			label.text = str("/ ", 1/number)
		else:
			label.text = str(operator, " ", number)
		
	if GraphUI:
		if x_mode:
			GraphUI.ops[operator] = "x"
		else:
			GraphUI.ops[operator] = str(number)
