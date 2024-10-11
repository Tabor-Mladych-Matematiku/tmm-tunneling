extends Node

var address = "192.168.0.118:5432"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func sendloginRequest(id, password):
	var body = JSON.new().stringify({
 	"user_id": id,
 	"password": password,
	})
	var http_request = HTTPRequest.new()
	
	http_request.request_completed.connect(loginPlayer)
	http_request.request(address, [], HTTPClient.METHOD_POST, body)

func loginPlayer(result, response_code, headers, body) -> int:
	print(response_code)
	
	var surname = "Jmeno"
	var firstname = "Prijmeni"
	
	# TODO send request
	
	Player.firstName = firstname
	Player.lastName = surname
	return 200
	
func sendResult(id: int, password: String, success: bool) -> void:
	
	# TODO send request 
	
	pass
