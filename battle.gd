extends Area2D

@export var bases: PackedScene
var battleTime = 0;
var playerBases = Array();

var drag_start_base = null
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
		if event.pressed:
			# 检查鼠标按下的位置是否在某个 TankBase 上
			var clicked_base = get_tank_base_under_mouse()
			if clicked_base:
				drag_start_base = clicked_base
				print("Start dragging: ", drag_start_base)
		else:
			# 鼠标释放时，如果有拖动中的 TankBase
			if drag_start_base:
				var released_base = get_tank_base_under_mouse()
				if released_base and released_base != drag_start_base:
					print("Released on different base: ", released_base)
					# 在这里可以处理从一个 TankBase 拖动到另一个的逻辑
				else:
					print("Released outside or on the same base")
				drag_start_base = null
	
	elif event is InputEventMouseMotion and drag_start_base:
		# 拖动中更新当前 TankBase 的位置
		#drag_start_base.position = get_global_mouse_position()
		pass

# 检查鼠标下的 TankBase（或其他按钮）
func get_tank_base_under_mouse():
	for child in get_children():
		if child is TankBase:
			if child.get_global_rect(Vector2(65, 65)).has_point(get_global_mouse_position()):
				return child
	return null
