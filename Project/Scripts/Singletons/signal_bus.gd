extends Node

signal start_conversation(conversation : ConversationData)
signal conversation_ended(conversation : ConversationData)

signal show_press_e()
signal hide_press_e()

signal picked_up_book()
signal picked_up_node(node : Node2D)
signal killed_rat(rat_node : Node2D)

signal gained_call_of_the_rats()
signal won_competition()
signal got_bike()
