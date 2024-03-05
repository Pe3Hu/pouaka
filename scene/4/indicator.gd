extends "res://scene/4/token.gd"




func calculate_value() -> void:
	match subtype:
		"damage per minute":
			var indicators = {}
			indicators["bullet per second"] = proprietor.get_aspect_value("fire rate") / 60.0
			indicators["magazine emptying"] = proprietor.get_aspect_value("magazine size") / indicators["bullet per second"]
			indicators["magazine per minute"] = 60.0 / (indicators["magazine emptying"] + proprietor.get_aspect_value("reload speed"))
			indicators["damage per magazine"] = proprietor.get_aspect_value("damage") * proprietor.get_aspect_value("magazine size") * proprietor.get_aspect_value("accuracy") / 100.0
			indicators["damage per minute"] = indicators["magazine per minute"] * indicators["damage per magazine"] * proprietor.salvo
			
			set_value(round(indicators["damage per minute"]))
