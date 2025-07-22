extends Node

const WIN_SCORE: int = 6

var score: int = 0

@onready var score_label: Label = $"../UI/Score"
@onready var victory_label: Label = $"../UI/Victory"
@onready var victory_timer: Timer = $"VictoryTimer"
@onready var victory_sound: AudioStreamPlayer2D = $"VictorySound"
@onready var enemies_group: Node = $"../Enemies"

func _ready() -> void:
	Engine.time_scale = 1.0 # Reset time scale
	score_label.text = "Coins: " + str(score) + "/" + str(WIN_SCORE)
	victory_label.hide() # Hide victory label initially

func add_point() -> void:
	score += 1
	score_label.text = "Coins: " + str(score) + "/" + str(WIN_SCORE)

	if score == WIN_SCORE:
		victory()
		victory_timer.start() # Start the timer to show victory for a while
		kill_all_enemies() # Call to kill all enemies when victory is achieved


func victory() -> void:
	victory_label.text = "Victory!!"
	victory_label.show()
	victory_sound.play() # Play victory sound


func _on_victory_timer_timeout() -> void:
	get_tree().reload_current_scene() # Reload the current scene

func kill_all_enemies() -> void:
	for enemy in enemies_group.get_children():
		enemy.go_to_sleep()
