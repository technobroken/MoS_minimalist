extends Node

static func free_children(node:Node)->void:
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()
