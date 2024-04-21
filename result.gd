extends Control

@onready var money = $Money
@onready var painting = $Painting
@onready var sus = $Sus
@onready var forgery = $Forgery

func setup_result(painting_id):
	var painting_info = GameData.get_value("Paintings", painting_id)
	money.text = "Value: £" + str(painting_info["value"])
	var sus_level
	var peak_snr = painting_info["peak_snr"]
	if(painting_info["is_placed"] == false):
		sus_level = 20
	else:
		if(peak_snr < GameData.threshold):
			sus_level = floor(GameData.threshold - peak_snr)
	sus.text = "Suspicion Increase: " + str(sus_level) + "%"

	var painting_path = "res://assets/art/painting/painting-{0}-edited.png".format({"0": str(painting_id)})
	painting.texture = load(painting_path)
	var forged_art_path = "./painting-{0}-forged.png".format({"0": str(painting_id)})
	var image = Image.load_from_file(forged_art_path)
	forgery.texture = ImageTexture.create_from_image(image)
