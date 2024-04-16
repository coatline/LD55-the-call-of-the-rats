class_name Player

extends CharacterBody2D

@export var mover : Mover
@export var shoot_behavior : ShootBehavior
@export var player_animation : PlayerAnimation
@export var bike_sprite : Sprite2D
@export var has_bike : bool

var shotty_equipped : bool = false
var has_shotty : bool = false
var can_move : bool = false
var speed = 1

func _ready():
	SignalBus.picked_up_node.connect(picked_up_node)
	SignalBus.conversation_ended.connect(conversation_ended)
	SignalBus.start_conversation.connect(conversation_started)
	
	GameData.player = self
	
	player_animation.play_anim_for("get_up", 5.5)
	await get_tree().create_timer(5.6).timeout
	can_move = true

func conversation_ended(_conv : ConversationData):
	can_move = true

func conversation_started(_conv : ConversationData):
	can_move = false

func _process(_delta):
	if shoot_behavior.shooting:
		mover.move(Vector2.ZERO)
		return
	
	if can_move == true:
		var x_input : float = Input.get_axis("left","right")
		var y_input : float = Input.get_axis("up", "down")
		
		mover.max_speed = speed * 35
		mover.move(Vector2(x_input, y_input).normalized() * speed)
	else:
		mover.move(Vector2.ZERO)
		return
	
	if Input.is_action_pressed("aim") and has_shotty:
		shotty_equipped = true
		
		if Input.is_action_just_pressed("shoot"):
			shoot_behavior.fire()
	else:
		shotty_equipped = false
	
	if Input.is_action_pressed("skip_conversation"):
		speed = 2

func picked_up_node(node):
	if node.name == "Shotty":
		has_shotty = true
		shotty_equipped = true
	elif node.name == "Rat_pickup":
		if GameData.has_call_of_the_rats == false:
			SignalBus.start_conversation.emit(GameData.get_conversation("eat-rat"))
	elif node.name == "Book":
		SignalBus.picked_up_book.emit()

func give_bike():
	speed = 2
	has_bike = true
	bike_sprite.visible = true
