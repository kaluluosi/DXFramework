class_name CheckBlackboard
extends Condition

enum Check {
	HAS_KEY,
	NOT_NULL
}

export var key:String
export(Check) var check = Check.NOT_NULL

func tick(actor, blackboard:Dictionary) -> int:

	match check:
		Check.NOT_NULL:
			if key in blackboard and blackboard[key]:
				return SUCCESS
			else:
				return FAILED
		Check.HAS_KEY:
			if blackboard.has(key):
				return SUCCESS
			else:
				return FAILED
		_:
			return FAILED
