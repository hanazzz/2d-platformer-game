extends Area2D

@export var target_level = PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# When player touches finish item, advances to next scene
func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
#		Target scene identified on Finish node for current level
		get_tree().change_scene_to_packed(target_level)
