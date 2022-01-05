extends Area2D


onready var animation = $AnimationPlayer as AnimationPlayer


func _ready() -> void:
	# Manually connect the signal so we don't get warnings if we comment out the function
	animation.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")


# Play a bounce animation
func _on_Brocolli_body_entered(_body: Node) -> void:
	# The bounce animation must be local to the node otherwise it will bounce near 0,0 of the level (top left)
	# I changed it to bounce the sprite position not the parent node position (Brocolli)
	animation.play("bounce")


# Delete the brocolli
func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	queue_free()

