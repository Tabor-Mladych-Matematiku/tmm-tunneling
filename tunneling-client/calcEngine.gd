extends Node

var numbers = [0, 0, 0, 0]
var operations = ['+', '+', '+']
var result = 0
var correct = false

var rng = RandomNumberGenerator.new()

var playerOps = ["+","+","+"]

static var maxValue = 12

func _ready():
	randomize()
	
func getExprString(nums, ops) -> String:
	var s = str(nums[0]) + ".0"
	for i in len(ops):
		s = s + str(ops[i]) + str(nums[i+1]) + ".0"
	return s

func getResult(nums, ops) -> float:	#TODO catch zero division
	var expression = Expression.new()
	var exprString = getExprString(nums, ops)
	expression.parse(exprString)
	var out = expression.execute()
	print(exprString)
	return out
	
func generateNew() -> void:
	for i in len(numbers):
		numbers[i] = rng.randi_range(0, maxValue)
		while numbers[i] < 1:
			numbers[i] = rng.randi_range(0, maxValue)
		if i > 0:
			operations[i-1] = randomOp()
	result = getResult(numbers, operations)
			
func randomOp() -> String:
	var rand = rng.randi_range(0, 3)
	match rand:
		0:
			return "+"
		1:
			return "-"
		2:
			return "*"
		3:
			return "/"
		_:
			return "+"
			
func setPlayerOps() -> void:
	var opBtn1 = get_tree().get_root().get_node("Math/Panel/CalculationPanel/OptionButton1")
	var opBtn2 = get_tree().get_root().get_node("Math/Panel/CalculationPanel/OptionButton2")
	var opBtn3 = get_tree().get_root().get_node("Math/Panel/CalculationPanel/OptionButton3")
	
	var op1 = opBtn1.get_item_text(opBtn1.selected)
	var op2 = opBtn2.get_item_text(opBtn2.selected)
	var op3 = opBtn3.get_item_text(opBtn3.selected)
	playerOps = [op1, op2, op3]

func checkPlayerCorrect() -> bool:
	if getResult(numbers, playerOps) == result:
		return true
	else:
		if(randi()%4 == 0):
			var aud:AudioStreamPlayer
			aud = get_tree().get_root().get_node("Math/Audio")
			aud.play()
		return false
