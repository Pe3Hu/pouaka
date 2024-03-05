extends MarginContainer


#region vars
@onready var arsenal = $HBox/Arsenal

var pantheon = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	pantheon = input_.pantheon
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.god = self
	arsenal.set_attributes(input)
#endregion
