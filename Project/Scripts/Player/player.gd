class_name Player

extends CharacterBody2D

@export var mover : Node2D
@export var speaker : Speaker
@export var shoot_behavior : ShootBehavior
@export var rat_spawners_parent : Node2D

var knows_call_of_the_rats : bool = false
var shotty_equipped : bool = false
var has_shotty : bool = false
var can_move : bool = false
var just_picked_up_rat : bool = false
var eating_rat : bool = false

func _ready():
	SignalBus.connect("picked_up_node", picked_up_node)
	SignalBus.connect("conversation_over", conversation_over)
	SignalBus.connect("start_conversation", conversation_started)
	GameData.player = self
	#await get_tree().create_timer(4.5).timeout
	can_move = true

func conversation_over():
	if just_picked_up_rat:
		eating_rat = true
		await get_tree().create_timer(3.5).timeout
		SignalBus.start_conversation.emit(ConversationInstance.new("after-eating-rat", Vector2.ZERO, []))
		just_picked_up_rat = false
		eating_rat = false
		return
	elif GameData.used_call:
		GameData.used_call = false
		# summon rats
		for rat_spawner in rat_spawners_parent.get_children():
			rat_spawner.spawn()
	
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

func picked_up_node(node):
	if node.name == "Shotty":
		has_shotty = true
		shotty_equipped = true
	elif node.name == "Rat_pickup":
		if knows_call_of_the_rats == false:
			knows_call_of_the_rats = true
			just_picked_up_rat = true
			SignalBus.start_conversation.emit(ConversationInstance.new("eat-rat", Vector2.ZERO, []))
			SignalBus.gained_call_of_the_rats.emit()
	elif node.name == "Book":
		SignalBus.picked_up_book.emit()
