extends Node2D

const player_definition: EntityDefinition = preload("res://assets/definitions/entities/actors/entity_definition_player.tres")

@onready var player: Entity
@onready var event_handler: EventHandler = $EventHandler
@onready var entities: Node2D = $Entities


# Called when the node enters the scene tree for the first time.
func _ready():
	var player_start_pos: Vector2i = Grid.world_to_grid(get_viewport_rect().size.floor() / 2)
	player = Entity.new(player_start_pos, player_definition)
	
	var npc := Entity.new(player_start_pos + Vector2i.RIGHT, player_definition)
	npc.modulate = Color.ORANGE_RED
	
	for e in [player, npc]:
		entities.add_child(e)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# TODO refactor for entdef
	#var action: Action = event_handler.get_action()
	#
	#if action is MovementAction:
		#player_grid_pos += action.offset
		#player.position = Grid.grid_to_world(player_grid_pos)
	#elif action is EscapeAction:
			#get_tree().quit()
	pass
