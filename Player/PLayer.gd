extends CharacterBody2D

var speed : int
var screen_size : Vector2

enum Direction { 
	UP, DOWN, LEFT, RIGHT
}
var current_direction: Direction

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size / 2.5
	speed = 200
	current_direction = Direction.DOWN # Начнем с направления вниз

func get_input():
	# клавиатура
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed

	# Определение направления для анимации
	if input_dir.x < 0:
		current_direction = Direction.LEFT
	elif input_dir.x > 0:
		current_direction = Direction.RIGHT
	elif input_dir.y < 0:
		current_direction = Direction.UP
	elif input_dir.y > 0:
		current_direction = Direction.DOWN
	
	velocity = input_dir * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()

	# анимации
	if velocity.length() != 0:
		if get_animation_name(current_direction) == "left_animation":
			$AnimatedSprite2D.play("right_animation")
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play(get_animation_name(current_direction))
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1

func get_animation_name(dir: Direction) -> String:
	match dir:
		Direction.UP:
			return "top_animation"
		Direction.DOWN:
			return "bottom_animation"
		Direction.LEFT:
			return "left_animation"
		Direction.RIGHT:
			return "right_animation"
	return "" # Вернуть пустую строку, если направление не распознано
