extends Area2D

@export var bases: PackedScene
var battleTime = 0;
var playerBases = Array();
# Called when the node enters the scene tree for the first time.
func _ready():
	playerBases.append($base1)
	playerBases.append($base2)
	$BattleWatch.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_battle_watch_timeout():
	battleTime+=1;
	for pb in playerBases:
		pb.grow(1)




func _input(event):
	if event is InputEventMouseButton:
		handle_mouse_button(event)
	elif event is InputEventScreenTouch:
		handle_screen_touch(event)
	#elif event is InputEventMouseMotion:
		##handle_mouse_motion(event)
	elif event is InputEventScreenDrag:
		handle_screen_drag(event)

func handle_mouse_button(event):
	if event.pressed:
		print("Mouse button pressed at ", event.position)
	else:
		print("Mouse button released at ", event.position)

func handle_screen_touch(event):
	if event.pressed:
		print("Screen touched at ", event.position)
	else:
		print("Screen touch released at ", event.position)

func handle_mouse_motion(event):
	print("Mouse moved to ", event.position)

func handle_screen_drag(event):
	print("Screen dragged to ", event.position)
