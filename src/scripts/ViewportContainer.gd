extends ViewportContainer

var target_position : Vector2 = self.rect_position 

var is_display = false

func _process(delta):
	if(target_position != self.rect_position):
		self.rect_position = lerp(target_position,self.rect_position,0.95)
	if(self.is_visible_in_tree()):
		if(is_display == false and target_position.x > rect_position.x-1 and target_position.x < rect_position.x+1):
			self.hide()
			get_parent().remove_viewport_scene()

func set_display(target_position_entry, rect_position_entry):
	self.show()
	self.rect_position = rect_position_entry
	self.target_position = target_position_entry
	is_display = true
	print("show")

func set_undisplay(target_position_entry):
	self.target_position = target_position_entry
	is_display = false
	print("begin hide")
