extends Node
class_name InputController

const MOVEMENT_KEYS:Array[Key] = [
	KEY_W,
	KEY_A, 
	KEY_S, 
	KEY_D
]

var _key_stack:Array[Key] = []
var _released_key_stack:Array[Key] = []

func _init() -> void:
	for key:Key in MOVEMENT_KEYS:
		_released_key_stack.push_back(key)

func set_on(key:Key) -> void:
	assert(key in MOVEMENT_KEYS)
	var i:int = _index_of(key, _released_key_stack)
	if (i != -1):
		_released_key_stack.remove_at(i)
		_key_stack.push_back(key)

func set_off(key:Key) -> void:
	assert(key in MOVEMENT_KEYS)
	var i:int = _index_of(key, _key_stack)
	if (i != -1):
		_key_stack.remove_at(i)
		_released_key_stack.push_back(key)

func get_first_on() -> Key:
	if (!_key_stack.is_empty()):
		return _key_stack[0]
	return -1
	
func get_last_on() -> Key:
	if (!_key_stack.is_empty()):
		return _key_stack[-1]
	return -1
	
func get_first_off() -> Key:
	if (!_released_key_stack.is_empty()):
		return _released_key_stack[0]
	return -1
	
func get_last_off() -> Key:
	if (!_released_key_stack.is_empty()):
		return _released_key_stack[-1]
	return -1

func _index_of(key:Key, stack:Array[Key]) -> int:
	for i in range(stack.size()):
		if (stack.get(i) == key):
			return i
	return -1
