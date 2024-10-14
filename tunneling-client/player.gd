extends Node

var firstName = ""
var lastName = ""
var id = -1
var password = ""
var loggedIn = false

var timeLimit = 60
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

func login(ID: int, passWord: String):
	id = ID
	password = passWord
	Networking.sendLoginRequest(ID, passWord)
	CalcEngine.generateNew()

func login_success():
		get_tree().change_scene_to_file("res://math.tscn")
		time = timeLimit
		loggedIn = true
	
func logout() -> void:
	loggedIn = false
	timerReady = false
	sendResult()
	get_tree().change_scene_to_file("res://main.tscn")
	
func sendResult() -> void:
	var success = CalcEngine.checkPlayerCorrect()
	Networking.sendResult(id, password, success)
		
func _setTimerReady() -> void:
	timerReady = true
	timerLabel = get_tree().get_root().get_node("Math/Panel/TimerLabel")
