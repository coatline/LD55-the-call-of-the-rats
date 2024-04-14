extends Node

func interact():
	GameData.player.picked_up_node(self)
	queue_free()
