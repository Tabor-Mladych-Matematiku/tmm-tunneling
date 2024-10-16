extends Label

@onready var nameLabel = get_node("../IDLabel")
@onready var timeLabel = get_node("../TimeLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player._setTimerReady()
	
	nameLabel.set_text(Player.id)
	
	var timeDict = Time.get_datetime_dict_from_system()
	var minute = ""
	if timeDict["minute"] < 10:
		minute = "0" + str(timeDict["minute"])
	else: minute = str(timeDict["minute"])
	var timeStr = str(timeDict["day"]) + "/" + str(timeDict["month"]) + "   " +str(timeDict["hour"]) + ":" + minute
	timeLabel.set_text(timeStr)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
