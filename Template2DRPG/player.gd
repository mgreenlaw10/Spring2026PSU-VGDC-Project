extends CharacterBody2D

const SPEED = 50.0
var last_movement_key:Key;

@onready var glow = get_node("Glow")
@onready var animation = get_node("AnimatedSprite2D")
@onready var collider = get_node("CollisionShape2D")

func _init() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
	
func is_movement_key(keycode:Key):
	return keycode in [KEY_W, KEY_A, KEY_S, KEY_D]

func _unhandled_input(event:InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and is_movement_key(event.keycode):
			last_movement_key = event.keycode
			

func _physics_process(delta: float) -> void:
	var x_dir := Input.get_axis("ui_left", "ui_right")
	var y_dir := Input.get_axis("ui_up", "ui_down")
	
	if   x_dir > 0:
		velocity.x = SPEED
		animation.flip_h = false
		animation.play("walk_right")
	elif x_dir < 0:
		velocity.x = -SPEED
		animation.flip_h = true
		animation.play("walk_right")
	else:
		velocity.x = 0
		
	if 	 y_dir > 0:
		velocity.y = SPEED
		animation.play("walk_down")
	elif y_dir < 0:
		velocity.y = -SPEED
		animation.play("walk_up")
		
	else:
		velocity.y = 0
		
	if velocity.length() == 0:
		match last_movement_key:
			KEY_W:
				animation.play("idle_up")
			KEY_S:
				animation.play("idle_down")
			KEY_A:
				animation.flip_h = true
				animation.play("idle_right")
			KEY_D:
				animation.flip_h = false
				animation.play("idle_right")
		

	move_and_slide()
