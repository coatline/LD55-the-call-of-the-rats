class_name Player

extends CharacterBody2D

@export var mover : Node2D
@export var speaker : Speaker
@export var shoot_behavior : ShootBehavior

var knows_call_of_the_rats : bool = false
var shotty_equipped : bool = false
var has_shotty : bool = false
var can_move : bool = false

func _ready():
	SignalBus.connect("picked_up_node", picked_up_node)
	SignalBus.connect("conversation_over", conversation_over)
	SignalBus.connect("start_conversation", conversation_started)
	GameData.player = self
	#await get_tree().create_timer(4.5).timeout
	can_move = true

func conversation_over():
	can_move = true

func conversation_started(_info):
	can_move = false

func _process(_delta):
	if shoot_behavior.shooting:
		mover.move(Vector2.ZERO)
		return
	
	if can_move == true:
		var x_input : float = Input.get_axis("left","right")
		var y_input : float = Input.get_axis("up", "down")
		mover.move(Vector2(x_input, y_input).normalized())
	else:
		mover.move(Vector2.ZERO)
		return
	
	if Input.is_action_pressed("aim") and has_shotty:
		shotty_equipped = true
		
		if Input.is_action_just_pressed("shoot"):
			shoot_behavior.fire()
	else:
		shotty_equipped = false
	
	if Input.is_action_pressed("call_rats"):
		if knows_call_of_the_rats:
			
			pass

func picked_up_node(node):
	if node.name == "Shotty":
		has_shotty = true
		shotty_equipped = true
