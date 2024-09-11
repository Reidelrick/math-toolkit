extends Control

var ops : Dictionary = {}

func _on_validate_pressed():
	owner.update_graph(ops)
	visible = false


func _on_add_ops_pressed():
	randomize()
	$NewOp.popup()

func _on_operation_add_pressed():
	var op = Operation.new()
	op.operator = $NewOp/VBoxContainer/Operation.get_item_text(
		$NewOp/VBoxContainer/Operation.get_selected_items()[0]
	) 
	if $NewOp/VBoxContainer/HBoxContainer/x.button_pressed == true:
		op.x_mode = true
	else:
		op.number = $NewOp/VBoxContainer/HBoxContainer/Number.value
	$NewOp.hide()
	$HBoxContainer.add_child(op)
