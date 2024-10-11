extends Node

var firstName = ""
var lastName = ""
var id = -1
var loggedIn = false

var timeLimit = 10
var time = timeLimit
var timerLabel
var timerReady

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if loggedIn and timerReady:
		time = time - delta
		timerLabel.set_text(str(int(time)))
		if time<0:
			logout()

func login(id: int, password: String) -> int:
	var loginCode = checkLogin(id, password)
	CalcEngine.generateNew()
	if loginCode == 200:
		get_tree().change_scene_to_file("res://math.tscn")
		time = timeLimit
		loggedIn = true
	return loginCode
	
func logout() -> void:
	loggedIn = false
	timerReady = false
	get_tree().change_scene_to_file("res://main.tscn")
	
func sendResult() -> void:
	pass
	
func checkLogin(id, password) -> int:
	# Return 0 if OK, 1 if wrong password, 2 if banned
	return Networking.loginRequest(id, password)
	
func _setTimerReady() -> void:
	timerReady = true
	timerLabel = get_tree().get_root().get_node("Math/Panel/TimerLabel")
