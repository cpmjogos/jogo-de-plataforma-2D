extends Node2D

#Constante que controla a duração
const WAIT_DURATION := 1.0

@onready var platform := $plataforma as AnimatableBody2D

# velocidade de movimento
@export var move_speed := 3.0

#distância = 12 x 16px = 192
@export var distance := 192
@export var move_horizontal := true

#evita trepidação
var follow := Vector2.ZERO

#calcula o centro 16 para cada lado
var platfomr_center := 16

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready():
	move_platform()


# Chamado cada quadro. 'delta' é o tempo decorrido desde o quadro anterior.
func _physics_process(delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)

# Função que faz a movimentação
func move_platform():
	# Se move_horizontal for true o bloco move para direita, do contrário move para cima
	var move_direction = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(move_speed * platfomr_center)
	
	# finaliza e cria a animação
	# set_loops, deixa animação em loop
	# set_trans -> é o tipo de transição
	# set_ease -> é o tipo de suavização
	var platform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	# leva plataforma até final
	
	# set_delay -> é o tempo de atraso
	platform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	# bate no final e volta
	platform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(duration + WAIT_DURATION * 2)
	
