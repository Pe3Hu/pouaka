extends MarginContainer


#region vars
@onready var components = $VBox/Components
@onready var aspects = $VBox/HBox/Aspects
@onready var indicators = $VBox/HBox/Indicators

var arsenal = null
var kind = null
var salvo = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	arsenal = input_.arsenal
	kind = input_.kind
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Vector2(Global.vec.size.weapon)
	init_aspects()
	init_indicators()
	init_components()
	update_indicators()


func init_aspects() -> void:
	for aspect in Global.arr.aspect:
		add_aspect(aspect)


func add_aspect(aspect_: String) -> void:
	var input = {}
	input.proprietor = self
	input.type = "aspect"
	input.subtype = aspect_
	input.value = 0
	
	var aspect = Global.scene.token.instantiate()
	aspects.add_child(aspect)
	aspect.set_attributes(input)


func init_indicators() -> void:
	for indicator in Global.arr.indicator:
		add_indicator(indicator)


func add_indicator(indicator_: String) -> void:
	var input = {}
	input.proprietor = self
	input.type = "indicator"
	input.subtype = indicator_
	input.value = 0
	
	var indicator = Global.scene.indicator.instantiate()
	indicators.add_child(indicator)
	indicator.set_attributes(input)


func init_components() -> void:
	for component in Global.arr.component:
		add_component(component)
	
	salvo = Global.dict.weapon.title[kind].salvo


func add_component(subtype_: String) -> void:
	var input = {}
	input.weapon = self
	input.subtype = subtype_
	
	var component = Global.scene.component.instantiate()
	components.add_child(component)
	component.set_attributes(input)


func update_indicators() -> void:
	for indicator in indicators.get_children():
		indicator.calculate_value()
#endregion


#region aspect value treatment
func change_aspect_value(subtype_: String, value_: int) -> void:
	var aspect = get_aspect(subtype_)
	aspect.change_value(value_)


func set_aspect_value(subtype_: String, value_: int) -> void:
	var aspect = get_aspect(subtype_)
	aspect.set_value(value_)


func get_aspect_value(subtype_: String) -> int:
	var aspect = get_aspect(subtype_)
	return aspect.get_value()


func get_aspect(subtype_: String) -> Variant:
	var index = Global.arr.aspect.find(subtype_)
	
	if index != -1:
		return aspects.get_child(index)
	
	return null
#endregion
