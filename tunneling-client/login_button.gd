extends Button
var password
var id
var err = false
var time = 0


@onready var passBox = get_node("../LoginInputContainer/PassBox")
@onready var idBox = get_node("../LoginInputContainer/IDBox")
@onready var errLabel = get_node("../ErrLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if err:
		time = time + delta
	if time > 2:
		errLabel.set_text("")
		time = 0
		err = false
		
func _pressed() -> void:
	password = passBox.get_text()
	id = int(idBox.get_text())
	var loginCode = Player.login(id, password)
	if loginCode == 403:
		errLabel.set_text("Špatné ID nebo heslo!")
		err= true
	elif loginCode == 405:
		errLabel.set_text("TBS našla tvůj tunel! Zkus to později.")
		err = true
