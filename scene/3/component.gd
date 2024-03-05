extends MarginContainer


#region vars
@onready var subtype = $HBox/Subtype
@onready var aspects = $HBox/Aspects

var weapon = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	weapon = input_.weapon
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	custom_minimum_size = Vector2(Global.vec.size.component)
	init_subtype(input_)
	init_aspects()


func init_subtype(input_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	input.type = "component"
	input.subtype = input_.subtype
	subtype.set_attributes(input)
	subtype.value.visible = false


func init_aspects() -> void:
	for order in Global.arr.order:
		add_aspect(order)


func add_aspect(order_: String) -> void:
	if Global.dict.component.title[subtype.subtype].aspect.has(order_):
		var input = {}
		input.proprietor = self
		input.type = "aspect"
		input.subtype = Global.dict.component.title[subtype.subtype].aspect[order_]
		input.value = Global.dict.weapon.title[weapon.kind][input.subtype]
		input.value *= Global.dict.component.title[subtype.subtype].share[order_] / 100
		input.value = round(input.value)
		
		var aspect = Global.scene.token.instantiate()
		aspects.add_child(aspect)
		aspect.set_attributes(input)
		weapon.change_aspect_value(input.subtype, input.value)
#endregion
