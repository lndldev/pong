extends Node2D

@onready var ball: CharacterBody2D = $ball
@onready var player: CharacterBody2D = $player
@onready var enemy: CharacterBody2D = $enemy

@onready var header_ui: HBoxContainer = $header_ui
@onready var player_score_label: Label = $header_ui/player_score
@onready var info: Label = $header_ui/info
@onready var enemy_score_label: Label = $header_ui/enemy_score

@onready var goal_timer: Timer = $goal_timer

@export var middle_ground_y = 300

var player_score : int
var enemy_score : int


@export var paused : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_score = 0
	enemy_score = 0
	reset_set()

func _process(delta: float) -> void:
	pass

func start_set() -> void:
	paused = false


func reset_set() -> void:
	ball.reset()
	player.reset()
	enemy.reset()

func _on_ball_goal_scored(which: Variant) -> void:
	if which == "left" : 
		player_score += 1
	if which == "right" : 
		enemy_score += 1
	show_goal(which)
	update_score()
	reset_set()
	pause_game()
	goal_timer.start()
	
func pause_game() ->void: 
	ball.pause()
	player.pause()
	enemy.pause()

func unpause_game() ->void: 
	ball.unpause()
	player.unpause()
	enemy.unpause()

func update_score() -> void : 
	player_score_label.text =  str(player_score)
	enemy_score_label.text =  str(enemy_score)

func show_goal(which : String) -> void :
	info.text = which + " scored !"


func _on_goal_timer_timeout() -> void:
	paused = false
	info.text = ""
	unpause_game()
	
