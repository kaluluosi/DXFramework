extends Node2D

export var value:float = 0

func _ready():
	$Label.text = str(value)

