extends Node2D


var items = {"wood_sword":Vector2(0, 0),
"wood_shield":Vector2(0, 1),
"light_armor":Vector2(0, 2),
"healing_potion":Vector2(0, 3),
"fist":Vector2(0, 4),
"wood_sword2":Vector2(0, 5),
"wood_shield2":Vector2(1, 0),
"light_armor2":Vector2(2, 0),
"healing_potion2":Vector2(3, 0),
"fist2":Vector2(4, 0),
"wood_sword3":Vector2(5, 0),
"wood_shield3":Vector2(6, 0),
"light_armor3":Vector2(7, 0)
}



func _ready():
	randomize()
	size_panel()
	set_panel()
	set_items()
	positioning()

# кол-во предметов у игрока от 5 до 15, если 
# предмето меньше 10 то они заполняются пустотами
# если больше, то часть пустоты при не разбивке на сетку
var size
func size_panel():
	if len(items) <= 10:
		size = Vector2(4, 5)
	else:
		var num_panels = len(items) * 2
		sizing(num_panels)


func sizing(n):
	if n == 22 or n == 24:
		size = Vector2(4, 6)
	elif n == 26 or n == 28:
		size = Vector2(4, 7)


func set_panel():
	for x in size.x:
		for y in size.y:
			$panel.set_cell(0,Vector2i(x, y), 0,
			 Vector2(14, 1))


func set_items():
	var icons = 0
	var index = -1
	while icons < len(items) * 2:
		var x = randi_range(0, size.x - 1)
		var y = randi_range(0, size.y - 1)
		if $items.get_cell_source_id(0, Vector2i(x, y)) == -1:
			if icons % 2 == 0:
				index += 1
			$items.set_cell(0, Vector2i(x, y), 0,
			 items[items.keys()[index]])
			icons += 1


func positioning():
	pass
	#if size.y > 4:
		#position.y = (DisplayServer.window_get_size().y / 2) - 30
	#else:
		#position.y = (DisplayServer.window_get_size().y / 2)
	#position.x = (DisplayServer.window_get_size().x / 2)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			open()


var open_block = []
var click = 0
func open():
	var pos = (get_global_mouse_position() - position) / scale.x
	pos = $panel.local_to_map(pos)
	var index = $panel.get_cell_source_id(0, pos)
	if index == 0:
		click += 1
		open_block.append(pos)
		$panel.set_cell(0, pos, -1)
	if click == 2:
		check()


func check():
	if $items.get_cell_atlas_coords(0, open_block[0])\
	 == $items.get_cell_atlas_coords(0, open_block[1]):
		activate_item($items.get_cell_source_id(0, open_block[1]))
	else:
		print(2)
		await get_tree().create_timer(1).timeout
		for i in open_block:
			$panel.set_cell(0, i, 0, Vector2(14, 1))
	open_block.clear()
	click = 0

func activate_item(id):
	pass
