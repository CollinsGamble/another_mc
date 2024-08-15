extends Area2D

@export var troops = 0
var selected_troops = 0

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
	$SelectedCount.text = str(selected_troops)



#选择事件的Handles
# 释放选择
func releaseSelect():
	selected_troops = 0;
	updateDisplay()
	# 不显示选择项
	$SelectedCount.text = ''
	# TODO 清除选中动画

# 单击选一半
func selectAhalf():
	selected_troops = troops/2;
	updateDisplay()	

# 双击全选
func selectAll():
	selected_troops = troops
	updateDisplay()	

# 出击
func gogogo(inBoundBase):
	# 减去当前的选择数量
	troops -= selected_troops
	releaseSelect()
	# 创建新实例
	var tank = tank_scene.instantiate()
	tank.position = $Position.position
	

	


# LevelManager
func levelUp(num):
# level up will change the MAX_TROOPS and Animation2D
	pass

func bufferUp():
	pass
