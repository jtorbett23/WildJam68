extends ColorRect

func _ready():
	update_text()

func update_text():
	$Sus.text = "Suspicion Level: " + str(GameData.sus) + "%"
	$Money.text = "Money: £" + str(GameData.money) + "/" + str(GameData.money_target)

