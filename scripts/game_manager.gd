extends Node

var score: int = 0

@onready var score_label: Label = $"../UI/Score"

func add_point() -> void:
    score += 1
    score_label.text = "Score: " + str(score) + "/6"
