extends CharacterBody2D

const SPEED = 300.0

var paused = false

func _physics_process(delta: float) -> void:

	if paused :
		velocity = Vector2i( 0,0 )
	else:
		var direction := Input.get_axis("ui_up", "ui_down")
		if direction:
			velocity.y = direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = 0
		move_and_slide()


func reset() -> void :
	global_position = Vector2(Constants.players_offset_x ,Constants.game_middle_y)
	
func pause() -> void : 
	paused = true

func unpause() -> void : 
	paused = false
