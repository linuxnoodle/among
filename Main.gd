extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if get_node("Player1").score == 3 or get_node("Player2").score == 3:
		get_node("Sprite2").visible = true;
	get_node("RichTextLabel").text = "Green score: " + str(get_node("Player1").score) + "\nRed score: " + str(get_node("Player2").score);
