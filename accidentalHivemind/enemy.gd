extends CharacterBody2D

@export var active_sight = 90 #how far can it see when it can see player?
@export var idle_sight = 40 #how far can it see when it can't see player?

@onready var icon: Sprite2D = $Icon
@onready var sight_area: Area2D = $sight_area
@onready var sight_hitbox: CollisionShape2D = $sight_area/sight_hitbox

const SPEED = 50

var player_seen = false
var player = 0 #isn't this a promise? not sure how to do this either

func _ready() -> void:
	sight_hitbox.shape.radius = idle_sight

func _physics_process(delta: float) -> void:
	
	if player_seen:
		
		velocity = player.position - position.move_toward(position - player.position,SPEED * delta)
		
		#flips on x axis based on velocity
		if velocity.x < 0:
			icon.flip_h = true
		else:
			icon.flip_h = false
	
	move_and_slide()
	


func _on_sight_area_body_entered(body: Node2D) -> void:
	player_seen = true
	sight_hitbox.shape.radius = active_sight
	player = body
	


func _on_sight_area_body_exited(body: Node2D) -> void:
	player_seen = false
	sight_hitbox.shape.radius = idle_sight
	player = 0
