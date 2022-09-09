extends State


func can_transition_to(state_name:String) -> bool:
	
	match state_name:
		'Move':
			return actor.velocity.x != 0
		"Air":
			return not actor.is_on_floor()
		_:
			return false
