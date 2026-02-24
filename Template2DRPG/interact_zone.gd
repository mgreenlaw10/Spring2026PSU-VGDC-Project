extends Area2D
class_name InteractZone

func _ready() -> void:
	add_to_group("interact_zones")

func activate():
	print("activated")

func _process(delta: float) -> void:
	pass
