extends Panel
class_name CurveParam

var curve : Line2D
var text : String
var color : Color

func _ready():
	$Label.text = text
	$ColorPickerButton.color = color
	
func _delete_pressed() -> void:
	curve.queue_free()
	queue_free()

func _color_changed(color):
	curve.default_color = color
