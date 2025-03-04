class_name DungeonGenerator
extends Node

@export_category("Map Dimensions")
@export var map_width: int = 80
@export var map_height: int = 45

@export_category("Rooms RNG")
@export var max_rooms: int = 30
@export var room_max_size: int = 10
@export var room_min_size: int = 6

var _rng := RandomNumberGenerator.new()


func _ready() -> void:
	_rng.randomize()

func _carve_tile(dungeon: MapData, x: int, y: int) -> void:
		var tile_position = Vector2i(x, y)
		var tile = dungeon.get_tile(tile_position)
		
		if tile:
			tile.set_tile_type(dungeon.tile_types.floor)

func _carve_room(dungeon: MapData, room: Rect2i) -> void:
	var inner: Rect2i = room.grow(-1)
	for y in range(inner.position.y, inner.end.y + 1):
		for x in range(inner.position.x, inner.end.x + 1):
			_carve_tile(dungeon, x, y)

func generate_dungeon(player: Entity) -> MapData:
	var dungeon := MapData.new(map_width, map_height)
	
	var rooms: Array[Rect2i] = []
	
	for _try_room in max_rooms:
		var room_width: int = _rng.randi_range(room_min_size, room_max_size)
		var room_height: int = _rng.randi_range(room_min_size, room_max_size)

		var x: int = _rng.randi_range(0, dungeon.width - room_width - 1)
		var y: int = _rng.randi_range(0, dungeon.height - room_height - 1)

		var new_room := Rect2i(x, y, room_width, room_height)

		var has_intersections := false
		for room in rooms:
			if room.intersects(new_room.grow(-1)):
				has_intersections = true
				break
		if has_intersections:
			continue

		_carve_room(dungeon, new_room)
		
		if rooms.is_empty():
			player.grid_position = new_room.get_center()
		else:
			_tunnel_between(dungeon, rooms.back().get_center(), new_room.get_center())
		
		rooms.append(new_room)
	
	return dungeon

func _tunnel(dungeon: MapData, fixed_val: int, arr_start: int, arr_end: int) -> void:
	for i in Handy.walk(arr_start, arr_end, true):
		_carve_tile(dungeon, i, fixed_val)

func _tunnel_between(dungeon: MapData, start: Vector2i, end: Vector2i) -> void:
	var fix_order = [start.y, end.x] if _rng.randf() < 0.5 else [start.x, end.y]	
	
	_tunnel(dungeon, fix_order[0], start.y, end.y)
	_tunnel(dungeon, fix_order[1], start.x, end.x)
