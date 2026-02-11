extends Node2D

@onready var animator = get_node("AnimatedSprite2D")
@onready var raycaster = get_node("RayCast2D")

func _ready() -> void:
	animator.play("idle_down")

func _process(delta: float) -> void:
	pass
