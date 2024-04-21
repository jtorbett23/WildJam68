extends ColorRect

func _ready():
	$Sus.text = "Suspicion Level: " + str(GameData.sus) + "%"
	$Money.text = "Money: £" + str(GameData.money)
