extends Node

var address = "192.168.0.118:5432"

func sendLoginRequest(id, password):
	var body = JSON.new().stringify({
 	"user_id": id,
 	"password": password,
	})
	var http_request = HTTPRequest.new()
	
	http_request.request_completed.connect(loginPlayer)
	http_request.request(address + "/api/game/insert.php", [], HTTPClient.METHOD_POST, body)

func print_err(code:int):
	var ErrLabel = get_tree().get_root().get_node("LoginScreen/Background/LoginContainer/ErrLabel")
	if code == 403:
		ErrLabel.set_text("Špatné ID nebo heslo!")
	elif code == 405:
		ErrLabel.set_text("TBS našla tvůj tunel! Zkus to později.")
		
func loginPlayer(result, response_code, headers, body):
	if response_code == 200:
		
		var surname = "Jmeno"
		var firstname = "Prijmeni"

		Player.firstName = firstname
		Player.lastName = surname
		
		Player.login_success()
		
	else: print_err(response_code)
		
func sendResult(id: int, password: String, success: bool) -> void:
	var body = JSON.new().stringify({
 	"user_id": id,
 	"password": password,
	"success": success
	})
	var http_request = HTTPRequest.new()
	
	http_request.request_completed.connect(loginPlayer)
	http_request.request(address + "/api/user/login.php", [], HTTPClient.METHOD_POST, body)
