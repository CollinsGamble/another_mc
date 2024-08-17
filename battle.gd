extends Area2D

@export var bases: PackedScene
var battleTime = 0;
var playerBases = Array()

var drag_start_base = null
@onready var line = $line

# 触摸和双击
var last_click_time = 0.0
var double_click_threshold = 0.4  # 设置双击触摸的最大时间间隔（秒）
var click_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    playerBases.append($base1)
    playerBases.append($base2)
    $BattleWatch.start()
    line.width = 4
    line.visible  = false

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
            # 按下
            var current_time = Time.get_ticks_msec() / 1000.0  # 获取当前时间（秒）
            if current_time - last_click_time < double_click_threshold:
                click_count += 1
            else:
                click_count = 1  # 重置点击计数
            last_click_time = current_time
            if click_count>=2:
                # 处理多击事件
                var clicked_base = get_tank_base_under_mouse()
                if clicked_base:
                    clicked_base.selectAll()
                    # 在这里可以实现双击后的逻辑
                    print("Double clicked on: ", clicked_base)
            else:
                # 单击
                var clicked_base = get_tank_base_under_mouse()
            
                if clicked_base:
                    cleanOtherBaseSelect(clicked_base)
                    clicked_base.plusAhalf()
                    drag_start_base = clicked_base
                    print("One Click OR Start dragging: ", drag_start_base)
        else:
            # drag松开
            if drag_start_base:
                # 拖动松开
                line.visible  = false
                var released_base = get_tank_base_under_mouse()
                if released_base:
                    if released_base != drag_start_base:
                        # 一个Base拖到了另一个Base上
                        print("Released on different base: ", released_base)
                        # 在这里可以处理从一个 TankBase 拖动到另一个的逻辑
                    else:
                        # 还是在自己的Base
                        print("Released on Same base: ", released_base)
                else:
                    # 并非在任何Base上release
                    print("Released outside")
                drag_start_base = null
    
    elif event is InputEventMouseMotion and drag_start_base:
        # 拖动中更新当前 TankBase 的位置
        #drag_start_base.position = get_global_mouse_position()
        _update_line(drag_start_base.position,event.position)

# 检查鼠标下的 TankBase（或其他按钮）
func get_tank_base_under_mouse():
    for child in get_children():
        if child is TankBase:
            if child.get_global_rect(Vector2(65, 65)).has_point(get_global_mouse_position()):
                return child
    return null
    
func cleanOtherBaseSelect(clicked_base):
    for child in get_children():
        if child is TankBase:
            if child != clicked_base:
                child.releaseSelect()

func _update_line(start_position,current_position):
    line.visible  = true
    # 设置起点和终点
    line.clear_points()
    line.add_point(start_position)
    line.add_point(current_position)	
    
    # 绘制箭头头部
    _draw_arrow_head(start_position,current_position)

func _draw_arrow_head(start_position,current_position):
    # 清除旧的箭头头部
    line.clear_points()
    
    # 计算方向向量
    var direction = (current_position - start_position).normalized()
    
    # 箭头头部的大小
    var arrow_size = 20
    var arrow_width = 10
    
    # 箭头的两个边角
    var left_point = current_position - direction.rotated(deg_to_rad(30)) * arrow_size
    var right_point = current_position - direction.rotated(deg_to_rad(-30)) * arrow_size
    
    # 绘制箭头主干
    line.add_point(start_position)
    line.add_point(current_position)
    
    # 添加箭头的两个边角点来形成三角形头部
    line.add_point(left_point)
    line.add_point(current_position)
    line.add_point(right_point)
    line.add_point(current_position)
