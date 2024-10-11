extends Label

@onready var nameLabel = get_node("../FirstNameLabel")
@onready var surnameLabel = get_node("../SecondNameLabel")
@onready var timeLabel = get_node("../TimeLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player._setTimerReady()
	
	nameLabel.set_text(Player.firstName)
	surnameLabel.set_text(Player.lastName)
	
	var timeDict = Time.get_datetime_dict_from_system()
	var timeStr = str(timeDict["day"]) + "/" + str(timeDict["month"]) + "   " +str(timeDict["hour"]) + ":" + str(timeDict["minute"])
	timeLabel.set_text(timeStr)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
