extends Node

@onready var points_label: Label = %PointsLabel

var points = 0

# Tracks and displays player points
func add_points():
	# Increases points by 1
	points += 1
	# Updates points label text
	points_label.text = "Points: " + str(points)
