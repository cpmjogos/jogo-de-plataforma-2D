extends Node2D

var velocity = Vector2(100, 0)  # Velocidade do movimento horizontal
var direction = 1  # Direção do movimento (1 para a direita, -1 para a esquerda)
@onready var animation_player = $AnimatedSprite  # Referência ao nó AnimatedSprite

#@onready var animation := $anime as AnimatedSprite2D

func _ready():
	set_process(true)  # Habilita o processo

func _process(delta):
	# Mova o personagem horizontalmente
	var motion = velocity * direction * delta
	position += motion

	# Alterne entre as animações run e idle com base na direção do movimento
	if motion.x != 0:
		animation_player.play("run")
		animation_player.flip_h = (direction == -1)
	else:
		animation_player.play("idle")
