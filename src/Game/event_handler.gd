class_name EventHandler
extends Node

var events = {
	"ui_up"	   : MovementAction.new( 0,-1),
	"ui_down"  : MovementAction.new( 0, 1),
	"ui_left"  : MovementAction.new(-1, 0),
	"ui_right" : MovementAction.new( 1, 0),
	"ui_cancel":   EscapeAction.new()
}

func get_action() -> Action:
	for e in events.keys():
		if Input.is_action_just_pressed(e):
			return events[e]
	
	return null
