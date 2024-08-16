class_name TankBase

extends Area2D

@export var troops = 0
var selected_troops = -1

var MAX_TROOP = 30

@export var tank_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func grow(num):
    if ((troops+num)<=MAX_TROOP):
        troops+=num
        updateDisplay()
    
func increment(num):
    troops+=num
    updateDisplay()
    
    


func updateDisplay():
    $TroopsCount.text = str(troops)

    if selected_troops<0:
        # 不显示选择项
        $SelectedCount.text = ''
    else:
        $SelectedCount.text = str(selected_troops)



#选择事件的Handles
# 释放选择
func releaseSelect():
    selected_troops = -1;
    updateDisplay()

# 单击选一半
func plusAhalf():
    selected_troops = selected_troops + (troops-selected_troops)/2;
    updateDisplay()	

# 双击全选
func selectAll():
    selected_troops = troops
    updateDisplay()	

# 出击
func gogogo(inBoundBase):
    # 减去当前的选择数量
    troops -= selected_troops
    selected_troops = -1
    updateDisplay()
    # 创建新实例
    var tank = tank_scene.instantiate()
    tank.position = $Position.position
    

# 被选中动画切换
func selectAnimation():
    pass

# 获取全局包围盒
func get_global_rect(size: Vector2):
    var global_position = get_global_position()  # 获取 TankBase 的全局位置
    return Rect2(global_position - size / 2, size)  # 返回以中心点为基础的包围盒
