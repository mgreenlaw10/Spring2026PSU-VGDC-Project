extends CharacterBody2D

const SPEED = 50.0
var last_movement_key:Key;
var lock_animation:bool
var input_controller:InputController

@onready var _glow = get_node("Glow")
@onready var _animation = get_node("AnimatedSprite2D")
@onready var _collider = get_node("CollisionShape2D")

func _init() -> void:
	lock_animation = false
	input_controller = InputController.new()
	
	
func is_movement_key(keycode:Key):
	return keycode in [KEY_W, KEY_A, KEY_S, KEY_D]

func _unhandled_input(event:InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and is_movement_key(event.keycode):
			input_controller.set_on(event.keycode)
			last_movement_key = event.keycode
		elif event.is_released() and is_movement_key(event.keycode):
			input_controller.set_off(event.keycode)
			
		# interact
		if event.pressed and event.keycode == KEY_E:
			var interact_zones = get_tree().get_nodes_in_group("interact_zones")
			for zone:InteractZone in interact_zones:
				if zone.overlaps_body(self as CharacterBody2D):
					zone.activate()
			

func _physics_process(delta: float) -> void:
	var x_dir:float = Input.get_axis("ui_left", "ui_right")
	var y_dir:float = Input.get_axis("ui_up", "ui_down")
	self.velocity = Vector2(x_dir * SPEED, y_dir * SPEED)
	
	_set_animation(self.velocity)
	move_and_slide()
	
func _set_animation(velocity:Vector2) -> void:
	if (velocity.length() > 0):
		match (input_controller.get_first_on()):
			KEY_W:
				_animation.flip_h = false
				_animation.play("walk_up")
			KEY_S:
				_animation.flip_h = false
				_animation.play("walk_down")
			KEY_A:
				_animation.flip_h = true
				_animation.play("walk_right")
			KEY_D:
				_animation.flip_h = false
				_animation.play("walk_right")
	else:
		match input_controller.get_last_off():
			KEY_W:
				_animation.flip_h = false
				_animation.play("idle_up")
			KEY_S:
				_animation.flip_h = false
				_animation.play("idle_down")
			KEY_A:
				_animation.flip_h = true
				_animation.play("idle_right")
			KEY_D:
				_animation.flip_h = false
				_animation.play("idle_right")
