extends RigidBody2D

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
var waiting = true;

func _reset():
	positionStart = Vector2.ZERO;
	positionEnd = Vector2.ZERO;
	arrow = Vector2.ZERO;
	update()

func _input(event):
	if not currentlySelected:
		return
	
	if event.is_action_released("click"):
		currentlySelected = false;
		while (waiting):
			pass
		apply_central_impulse(positionEnd);
	
	if event is InputEventMouseMotion:
		positionEnd = event.position - Vector2(420, 700)
		arrow = -(positionEnd - positionStart).limit_length(100);
		update()

func _on_Ship1_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		currentlySelected = true;
		positionStart = event.position - Vector2(420, 700)

func _draw():
	draw_line(positionStart - global_position,
			  positionEnd - global_position,
			  Color.blue,
			  3);

func _on_Player1_send_ships():
	waiting = false;
