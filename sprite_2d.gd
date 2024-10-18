extends Sprite2D

signal health_depleted
signal health_changed(old_value,new_value)

var speed = 400
var angular_speed = PI
var health = 10

func _init():
    print("Hello Wold")

func _process(delta: float):   
    
    rotation += angular_speed * delta
    var velocity = Vector2.UP.rotated(rotation) * speed
    
    position += velocity * delta

func _on_button_pressed():
    set_process(not is_processing())

func _ready():
    var timer = get_node("Timer")
    timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
    visible = not visible

func take_damage(amount):
    var old_health = health
    health -= amount
    if health <= 0:
        health_depleted.emit()
    health_changed.emit(old_health, health)