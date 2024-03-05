extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.edge = [1, 2, 3, 4, 5, 6]
	arr.aspect = ["damage", "fire rate", "accuracy", "reload speed", "magazine size"]
	#arr.component = ["stock", "body", "barrel", "magaize", "accessory"]
	arr.component = ["barrel", "body", "stock", "accessory", "magaize"]
	arr.weapon = ["pistol", "automatic rifle", "shotgun", "machine gun", "sniper rifle"]
	arr.order = ["primary", "secondary"]
	arr.indicator = ["damage per minute"]


func init_num() -> void:
	num.index = {}
	
	num.area = {}
	num.area.n = 9
	num.area.col = num.area.n
	num.area.row = num.area.n


func init_dict() -> void:
	init_neighbor()
	init_weapon()
	init_component()


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_weapon() -> void:
	dict.weapon = {}
	dict.weapon.title = {}
	var exceptions = ["title"]
	
	var path = "res://asset/json/pouaka_weapon.json"
	var array = load_data(path)
	
	for weapon in array:
		var data = {}
		
		for key in weapon:
			if !exceptions.has(key):
				data[key] = weapon[key]
			
		#if !dict.weapon.title.has(weapon.title):
		#	dict.weapon.title[weapon.title] = {}
	
		dict.weapon.title[weapon.title] = data


func init_component() -> void:
	dict.component = {}
	dict.component.title = {}
	var exceptions = ["title"]
	
	var path = "res://asset/json/pouaka_component.json"
	var array = load_data(path)
	
	for component in array:
		var data = {}
		data.aspect = {}
		data.share = {}
		
		for key in component:
			if !exceptions.has(key):
				var words = key.split(" ")
				data[words[1]][words[0]] = component[key]
	
		dict.component.title[component.title] = data


func init_affix() -> void:
	dict.affix = {}


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.pantheon = load("res://scene/1/pantheon.tscn")
	scene.god = load("res://scene/1/god.tscn")
	
	scene.planet = load("res://scene/2/planet.tscn")
	scene.area = load("res://scene/2/area.tscn")
	
	scene.weapon = load("res://scene/3/weapon.tscn")
	scene.component = load("res://scene/3/component.tscn")
	
	scene.token = load("res://scene/4/token.tscn")
	scene.indicator = load("res://scene/4/indicator.tscn")
	


func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.number = Vector2(vec.size.sixteen)
	vec.size.area = Vector2(60, 60)
	vec.size.token = Vector2(24, 24)
	vec.size.component = Vector2(vec.size.token) * 2
	vec.size.weapon = Vector2(vec.size.component.x * 3, vec.size.component.x * 2)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.defender = {}
	color.defender.active = Color.from_hsv(120 / h, 0.6, 0.7)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
