extends StaticBody2D

@onready var collider = get_node("CollisionShape2D")
@onready var occluder = get_node("LightOccluder2D")

var COLOR:Color = Color.BLACK

func _ready() -> void:
	# set light occluder bounds
	var size:Vector2 = collider.get_shape().size
	var x = size.x / -2
	var y = size.y / -2
	var points = PackedVector2Array([
		Vector2(x, y),
		Vector2(x + size.x, y),
		Vector2(x + size.x, y + size.y),
		Vector2(x, y + size.y)
	])
	occluder.get_occluder_polygon().polygon = points

func _draw() -> void:
	# draw rect around collider bounds
	var size:Vector2 = collider.get_shape().size
	var draw_x:float = size.x / -2
	var draw_y:float = size.y / -2
	var draw_w:float = size.x
	var draw_h:float = size.y 
	draw_rect(Rect2(draw_x, draw_y, draw_w, draw_h), COLOR, true, 2)

func _process(delta: float) -> void:
	pass
