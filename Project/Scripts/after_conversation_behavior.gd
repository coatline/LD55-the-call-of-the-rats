extends Node2D

@export var player : Player

@export var rat_spawner_parent_node : Node2D

func _ready():
	SignalBus.conversation_ended.connect(conversation_ended)

func conversation_ended(conversation : ConversationData):
	var key = conversation.conversation_key

	if key == "eat-rat":
		player.can_move = false

		# show player eating rat animation
		player.player_animation.play_anim_for("eat_rat", 3)
		await get_tree().create_timer(3.5).timeout

		# then start the reflection dialogue
		SignalBus.start_conversation.emit(GameData.get_conversation("after-eating-rat"))

	elif key == "after-eating-rat":
		GameData.has_call_of_the_rats = true
		SignalBus.gained_call_of_the_rats.emit()

	elif key == "use-call-of-the-rats":
		# summon rats
		for rat_spawner in rat_spawner_parent_node.get_children():
			rat_spawner.spawn()

		SignalBus.won_competition.emit()

	elif key == "melinda-again":
		DialogueTriggerManager.get_triggerer("melinda2").queue_free()
	
	elif key == "beat-timothy":
		SignalBus.got_bike.emit()
		player.give_bike()

