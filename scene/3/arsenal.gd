extends MarginContainer


#region vars
@onready var weapons = $Weapons

var god = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	add_weapon()


func add_weapon() -> void:
	var input = {}
	input.arsenal = self
	input.kind = "pistol"#Global.arr.weapon.pick_random()
	
	var weapon = Global.scene.weapon.instantiate()
	weapons.add_child(weapon)
	weapon.set_attributes(input)
#endregion
