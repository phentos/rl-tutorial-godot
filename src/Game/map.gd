class_name Map
extends Node2D

@onready var dungeon_generator: DungeonGenerator = $DungeonGenerator

var map_data: MapData


func generate(player: Entity) -> void:
	map_data = dungeon_generator.generate_dungeon(player)
	_place_tiles()

func _place_tiles() -> void:
	Handy.map(add_child, map_data.tiles)
