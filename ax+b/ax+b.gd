extends Control

var expression : String

func calc(A: Vector2, B: Vector2):
	var a: float = (
		(B.y - A.y) /
		(B.x - A.x)
	)
	
	var b: float = -(
		a*A.x-A.y
	)
	
	return [a, b]


func _on_button_pressed():
	var ab = calc(
	Vector2(
		%Input/A/Ax.value, 
		%Input/A/Ay.value
	), 
	Vector2(
		%Input/B/Bx.value, 
		%Input/B/By.value
	)
	)
	expression = str(ab[0])+"x + "+str(ab[1])
	%Result.text = expression
