extends Node

var rat_already_killed : bool = false
var melinda_2 : Speaker
var bob : Speaker
var player : Player
var used_call : bool

func _ready():
	SignalBus.killed_rat.connect(killed_rat)

func killed_rat(rat_node : Node2D):
	rat_already_killed = true
	SignalBus.start_conversation.emit(ConversationInstance.new("rat-killed", rat_node.position, [melinda_2]))
