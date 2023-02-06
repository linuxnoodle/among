extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func ready():
	set_process(true);
	set_process_input(true);

var currentlySelected = false;
var positionStart = Vector2.ZERO;
var positionEnd = Vector2.ZERO;
var arrow = Vector2.ZERO;

func _reset():
	positionStart = Vector2.ZERO;
	positionEnd = Vector2.ZERO;
	arrow = Vector2.ZERO;

func _input(event):
	if not currentlySelected:
		return
	
	if event.is_action_released("click"):
		currentlySelected = false;
		_reset()
	
	if event is InputEventMouseMotion:
		positionEnd = event.position
		arrow = -(positionEnd - positionStart).clamped(100);
		update()

func _on_Ship1_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		currentlySelected = true;
		positionStart = event.position

func _draw():
	draw_line(positionStart - position,
			  positionEnd - position,
			  Color.blue,
			  3);
