extends Node

@onready var points_label: Label = %PointsLabel
@export var hearts : Array[Node]

# Start with 0 points and 3 lives
var points = 0
var lives = 3

# Tracks and displays player points
func add_points():
	# Increases points by 1
	points += 1
	# Updates points label text
	points_label.text = "Points: " + str(points)

# Track player lives
func decrease_health():
	# Reduce lives by 1
	lives -= 1
	print("Lives left: ", lives)
	for h in 3:
		if h < lives:
			hearts[h].show()
		else:
			hearts[h].hide()
	# If 0 lives left, restart level
	if (lives == 0):
		get_tree().reload_current_scene()
