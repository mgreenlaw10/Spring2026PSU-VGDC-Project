extends Node
class_name InputController

const MOVEMENT_KEYS:Array[Key] = [
	KEY_W,
	KEY_A, 
	KEY_S, 
	KEY_D
]

var _movement_key_stack:Array[Key] = []
var _animator:AnimatedSprite2D

func _init(animator:AnimatedSprite2D) -> void:
	_animator = animator

func _input (event:InputEvent) -> void:
	if (event.keycode in MOVEMENT_KEYS):
		if (event.is_pressed()):
			_movement_key_stack.append(event.keycode)
		if (event.is_released()):
			_movement_key_stack.remove_at(index_of(event.keycode))


func index_of(movement_key:Key) -> int:
	for i in range(_movement_key_stack.size()):
		if (_movement_key_stack.get(i) == movement_key):
			return i
	return -1

func get_movement_key_stack():
	return _movement_key_stack

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
