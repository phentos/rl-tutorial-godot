class_name MapData
extends RefCounted

const tile_types = {
	"floor": preload("res://assets/definitions/tiles/tile_definition_floor.tres"),
	"wall": preload("res://assets/definitions/tiles/tile_definition_wall.tres"),
}

var width: int
var height: int
var tiles: Array[Tile]

func _init(map_width: int, map_height: int) -> void:
	width = map_width
	height = map_height
	_setup_tiles()
	
func _setup_tiles() -> void:
	tiles = []
	for y in height:
		for x in width:
			var tile_position := Vector2i(x, y)
			var tile := Tile.new(tile_position, tile_types.wall)
			tiles.append(tile)

func get_tile(grid_position: Vector2i) -> Tile:
	var tile_index: int = grid_to_index(grid_position)
	if tile_index == -1:
		return null
	return tiles[tile_index]

func get_tile_xy(x: int, y: int) -> Tile:
	var grid_position := Vector2i(x, y)
	return get_tile(grid_position)

func grid_to_index(grid_position: Vector2i) -> int:
	if not is_in_bounds(grid_position):
		return -1
	return grid_position.y * width + grid_position.x

func is_in_bounds(coordinate: Vector2i) -> bool:
	var clamp_assert = func(v, b): return (clamp(v, 0, b - 1) == v)
	
	var comparisons = [
		[coordinate.x, width],
		[coordinate.y, height]
	]
	
	return false not in Handy.mapv(clamp_assert, comparisons)
