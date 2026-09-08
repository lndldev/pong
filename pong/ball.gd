extends CharacterBody2D

@onready var goal_left: StaticBody2D = $"../goal_left"

signal goal_scored(which)

const SPEED = 300.0

var paused = false

const start_velocity = Vector2i(-300,0)


func _physics_process(delta: float) -> void:
	
	if paused :
		velocity = Vector2i( 0,0 )
	else:
		var collision_info = move_and_collide(velocity * delta)
		if collision_info: # We only want to bounce if the ball actually collided.
			var collider : CollisionObject2D = collision_info.get_collider()
			if collider.is_in_group("players"):
				var y_delta =  position.y -collider.position.y
				velocity = Vector2i( -velocity.x * 1.05, y_delta * -0.01 * velocity.x )
			if collider.is_in_group("walls"):
				velocity = velocity.bounce(collision_info.get_normal()) 
				
			if collider.is_in_group("goals"):
				if collider == goal_left:
					goal_scored.emit("left")
	pass

func reset() -> void :
	global_position = Vector2(Constants.game_middle_x,Constants.game_middle_y)
	velocity = start_velocity

func pause() -> void : 
	paused = true
	
func unpause() -> void : 
	paused = false
	velocity = start_velocity
	
