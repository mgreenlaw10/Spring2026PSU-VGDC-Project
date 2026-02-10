extends Node2D
class_name Player

# Raycasts (use to detect tiles before movement)
@onready var rayUP = $Raycasts/RayCastUP 
@onready var rayDOWN = $Raycasts/RayCastDOWN 
@onready var rayLEFT = $Raycasts/RayCastLEFT 
@onready var rayRIGHT = $Raycasts/RayCastRIGHT 

var input_dir # holds the movement direction (for future tile types)
var current_tile_data # holds the current tile's TileData (when moving)
var moveable = true # player can move only when this is true (for future tile types)

func _input(event: InputEvent) -> void:
	if (event is InputEventKey): # If the input is a keyboard key...
		if (moveable and (event.as_text_physical_keycode() in GlobalVars.movement_keys)): # if the input is an arrow key...
			move_func()

func move_func():
	input_dir = Vector2.ZERO # Set movement to 0 (clear)
	
	if (Input.is_action_just_pressed("player_down")):
		if (check_tile(rayDOWN) != 0): # If tile is not an edge tile...
			input_dir = Vector2(0,1)
			self.global_position.y += GlobalVars.node_length # Move down 1 tile
			after_move()
	elif (Input.is_action_just_pressed("player_up")):
		if (check_tile(rayUP) != 0): 
			input_dir = Vector2(0,-1)
			self.global_position.y -= GlobalVars.node_length # Move up 1 tile
			after_move()
	elif (Input.is_action_just_pressed("player_left")):
		if (check_tile(rayLEFT) != 0):
			input_dir = Vector2(-1,0)
			self.global_position.x -= GlobalVars.node_length # Move left 1 tile
			after_move()
	elif (Input.is_action_just_pressed("player_right")):
		if (check_tile(rayRIGHT) != 0):
			input_dir = Vector2(1,0)
			self.global_position.x += GlobalVars.node_length # Move right 1 tile
			after_move()

# Function that applies any effects that trigger as the player enters the tile
func after_move():
	if (current_tile_data.get_custom_data("tile_id") == 2): # If the current tile's id is 2 (goal tile)...
		print("You win!")

# Function that returns the tile_id of the tile moved to by the Player (make a new helper function if needed)
func check_tile(rayCast: RayCast2D):
	if (rayCast.is_colliding()):
		var tile = rayCast.get_collider()
		var debug = tile.get_cell_tile_data(tile.local_to_map(rayCast.get_collision_point())) # gets TileData of tile overlapping with raycast
		current_tile_data = debug
		if (debug):
			var tile_id = debug.get_custom_data("tile_id")
			return (tile_id)
	else:
		return null
