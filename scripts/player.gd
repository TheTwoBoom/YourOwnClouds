extends CharacterBody2D
const speed = 160;
@onready var animated_sprite = get_node("AnimatedSprite2D")
var screen_size;
var orientation = "Up";
var blocked = false;
var key_area;

func _ready():
	screen_size = get_viewport_rect().size
	if !JsonLoader.tutorial:
		%UiManager.start_tutorial()

func _physics_process(delta: float) -> void:
	%UiManager.refresh_coins()
	velocity = Vector2.ZERO
	if Input.is_action_just_pressed("interact"):
		match key_area:
			"MainDeskArea2D":
				print("Pressed E near Desktop!")
				%UiManager.toggle_computer()
				return
			"BuildDeskArea2D":
				print("Pressed E near Build Area!")
				%UiManager.open_build_scene()
				return
		if !JsonLoader.viewed_server_rack.is_empty():
			%UiManager.toggle_computer()
			%UiManager.open_sub_menu("Rack")
			
	if blocked:
		return
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		orientation = "Up"
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
		orientation = "Down"
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		orientation = "Left"
	elif Input.is_action_pressed("move_right"):
		velocity.x += 1
		orientation = "Right"
	if (velocity.length() > 0):
		velocity = velocity.normalized() * speed;
		animated_sprite.animation = "walking" + orientation
	else:
		animated_sprite.animation = "idle" + orientation
	move_and_slide()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
