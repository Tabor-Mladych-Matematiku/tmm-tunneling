extends Button

@onready var correctLabel = get_node("../../CorrectLabel")
@onready var resultLabel = get_node("../Result")
var numLabels = [Label, Label, Label, Label]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in 4:
		numLabels[i] = get_node("../Num"+str(i+1)+"Label")
		
	CalcEngine.generateNew()
	resultLabel.set_text(str(CalcEngine.result).pad_decimals(2))
	
	for i in len(numLabels):
		numLabels[i].set_text(str(CalcEngine.numbers[i]))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _pressed() -> void:
	CalcEngine.setPlayerOps()
	if CalcEngine.checkPlayerCorrect():
		correctLabel.set_text("Správně!")
		correctLabel.set("theme_override_colors/font_color",Color(0.0, 1.0, 0.0 ))
	else:
		correctLabel.set_text("Chyba :(")
		correctLabel.set("theme_override_colors/font_color",Color(1.0, 0.0, 0.0 ))
	get_parent().visible = false
