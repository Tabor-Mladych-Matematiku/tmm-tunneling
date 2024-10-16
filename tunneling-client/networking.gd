extends Node

var address = "192.168.0.105:8080"
var http_request
var login_request
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	login_request = HTTPRequest.new()
	add_child(login_request)
	login_request.request_completed.connect(loginPlayer)

func sendLoginRequest(id, password):
	var body = JSON.new().stringify({
 	"user_id": id,
 	"password": password,
	})
	var adr = "http://"+address + "/api/user/login.php"
	print(adr)
	print(body)
	login_request.request(adr, [], HTTPClient.METHOD_POST, body)

func print_err(code:int):
	var ErrLabel = get_tree().get_root().get_node("LoginScreen/Background/LoginContainer/ErrLabel")
	if code == 403:
		ErrLabel.set_text("Špatné ID nebo heslo!")
	elif code == 405:
		ErrLabel.set_text("TBS našla tvůj tunel! Zkus to později.")
		
func loginPlayer(_result, response_code, _headers, _body):
	print(response_code)
	if response_code == 200:
		
		Player.login_success()
		
	else: print_err(response_code)
		
func sendResult(id: int, password: String, success: bool) -> void:
	var body = JSON.new().stringify({
 	"user_id": id,
 	"password": password,
	"success": str(success)
	})
	print(body)
	
	http_request.request("http://"+address + "/api/game/insert.php", [], HTTPClient.METHOD_POST, body)
