extends Resource

class_name Inventory

signal updated()

@export var Items: Array[Item]

func insert(item: Item) -> bool:
	for i in range(Items.size()):
		if !Items[i].name:
			Items[i] = item
			updated.emit()
			return true
	return false

func delete(index:int)->void:
	Items[index] = Item.new()
	updated.emit()

func insert_pemulung(item: Item) -> void:
	Items.append(item)
