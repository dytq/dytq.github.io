extends Control

var example_page = load("res://scenes/Page.tscn")

func _ready():
	pass


func _on_Button_pressed():
	var my_page = example_page.instance()
	add_child(my_page)
