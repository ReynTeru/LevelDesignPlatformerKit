extends StaticBody3D

@export var required_coins: int = 3
@export var jump_force: float = 20.0

#@export var shouldCombineWithJump: bool = false
@export var shouldAllowDoubleJump: bool = false
@export var shouldActivateOnce: bool = false
@export var shouldDeactivateOnDeath: bool = false

var isActive: bool = false

func interact(coins, shouldAddJumpForce) -> void:
	if isActive == false:
		if coins[0] < required_coins:
			pass
		else:
			coins[0] -= required_coins
			get_node("/root/Main/Player").coin_collected.emit(coins[0])
			isActive = true
	if isActive == true:
		get_node("/root/Main/Player").jump_double = shouldAllowDoubleJump
		if shouldAddJumpForce:
			get_node("/root/Main/Player").gravity = -jump_force 
			- get_node("/root/Main/Player").jump_strength
		else:
			get_node("/root/Main/Player").gravity = -jump_force
		print(get_node("/root/Main/Player").gravity)
		if shouldActivateOnce == true:
			isActive = false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/Main/Player").velocity.y = jump_force


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func deactivate() -> void:
	print("animal deactivating")
	if shouldDeactivateOnDeath:
		isActive = false
