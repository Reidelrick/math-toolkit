extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_axb_pressed():
	get_tree().change_scene_to_file("res://ax+b/ax+b.tscn")


func _on_binary_pressed():
	get_tree().change_scene_to_file("res://Binary/binary.tscn")


func _on_graph_pressed():
	get_tree().change_scene_to_file("res://Graph/graph.tscn")
