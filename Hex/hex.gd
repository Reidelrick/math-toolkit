extends Control

const hex2bin = {
	"0":"0",
	"1":"1",
	"2":"10",
	"3":"11",
	"4":"100",
	"5":"101",
	"6":"110",
	"7":"111",
	"8":"1000",
	"9":"1001",
	"a":"1010",
	"b":"1011",
	"c":"1100",
	"d":"1101",
	"e":"1110",
	"f":"1111"
}

const bin2hex = {
	"0000":"0",
	"0001":"1",
	"0010":"2",
	"0011":"3",
	"0100":"4",
	"0101":"5",
	"0110":"6",
	"0111":"7",
	"1000":"8",
	"1001":"9",
	"1010":"a",
	"1011":"b",
	"1100":"c",
	"1101":"d",
	"1110":"e",
	"1111":"f"
}

func hex_to_bin(hex:String):
	var split = hex.split()
	var bin = ""
	for s in split:
		if hex2bin.has(s):
			bin += hex2bin[s]
		else:
			return
	return bin

func bin_to_hex(bin:String):
	while round(bin.length()/4.0) != (bin.length()/4.0):
		bin = bin.insert(0, "0")
	var hex = ""
	var split = bin.split()
	var i = 0
	var q = ""
	var quartet_split : Array[String]
	for s in split:
		q+=s
		if i < 3:
			i+=1
		else:
			i = 0
			quartet_split.append(q)
			q=""
	for s in quartet_split:
		if bin2hex.has(s):
			hex += bin2hex[s]
		else:
			return
	return hex

func _on_bin_calculate_pressed() -> void:
	%Bin/Result.text = hex_to_bin(%Bin/Input.text)


func _on_hex_calculate_pressed() -> void:
	%Hex/Result.text = bin_to_hex(%Hex/Input.text)
