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
var alive = true;
var used = false;

func _process(_delta):
	if not used and Vector2.ZERO.distance_squared_to(global_position) > 100000:
		get_node("Sprite").visible = false;
		get_node("CollisionShape2D").disabled = true;
		used = true;
		get_parent().get_parent().score += 1;
		print(get_parent().get_parent().score)

func _reset():
	positionStart = Vector2.ZERO;
	positionEnd = Vector2.ZERO;
	arrow = Vector2.ZERO;
	update()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		apply_central_impulse(positionEnd - positionStart);
		_reset();
	
	if not currentlySelected:
		return
	
	if event.is_action_released("click"):
		currentlySelected = false;
	
	if event is InputEventMouseMotion:
		positionEnd = event.position - Vector2(950, 530)
		arrow = -(positionEnd - positionStart).limit_length(100);
		update()

func _on_Ship1_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		currentlySelected = true;
		positionStart = event.position - Vector2(950, 530)

func _draw():
	draw_line(positionStart - global_position,
			  positionEnd - global_position,
			  Color.blue,
			  3);

func _on_Player1_send_ships():
	waiting = false;
