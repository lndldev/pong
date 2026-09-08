extends CharacterBody2D

@onready var ball: CharacterBody2D = $"../ball"

var paused = false

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	if paused :
		velocity = Vector2i( 0,0 )
	else:
		var direction := ball.global_position.y - global_position.y
		if direction:
			velocity.y = sign(direction) * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		move_and_slide()


func reset() -> void :
	global_position = Vector2( 800- Constants.players_offset_x , Constants.game_middle_y)

func pause() -> void : 
	paused = true

func unpause() -> void : 
	paused = false
