extends Node

signal start_conversation(conversation_instance : ConversationInstance)
signal conversation_over()

signal show_press_e(position : Vector2)
signal hide_press_e()

signal picked_up_node(node : Node2D)
signal killed_rat(rat_node : Node2D)
