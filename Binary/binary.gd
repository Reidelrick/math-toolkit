extends Control

func abqr(a:float, b:float):
	var q = floor(a/b)
	var r:float = (
		(a/b)-
		floor(a/b)
		)*b
	print(q, ", ", r)
	get_tree().quit()
	#return [q, r]

func bin_to_int(num: String):
	var bin_array = num.split("")
	var result: int = 0
	for n in bin_array.size():
		if int(bin_array[n]) == 0:
			result += 0
		elif int(bin_array[n]) == 1:
			result += 2**(n)
	return result
	
func int_to_bin(num: int):
	abqr(num, 16)
	var i = num
	var bin = []
	while i != 0:
		
		bin.append(abqr(i, 2)[1])
		i=abqr(i,2)[0]
	
	
	var r : String = ""
	for b in bin:
		r=r.insert(0,str(b))
		print(str(b))
	return r
	
func _on_bin_calculate_pressed():
	$All/Bin/Result.text = str(bin_to_int($All/Bin/Input.text))

func _on_int_calculate_pressed():
	$All/Int/Result.text = str(int_to_bin($All/Int/Input.value))
