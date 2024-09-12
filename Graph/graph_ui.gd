extends Control

func _on_expression_text_submitted(new_text: String) -> void:
	owner.update_graph(new_text)
