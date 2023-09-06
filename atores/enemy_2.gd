extends KinematicBody2D

# Propriedades
var speed = 100  # Velocidade de movimento do inimigo
var direction = Vector2.LEFT  # Direção inicial do movimento
var distance = 200  # Distância total que o inimigo irá percorrer
var jump_interval = 3.0  # Intervalo de tempo entre os saltos (em segundos)
var jump_force = -300  # Força do salto
var is_jumping = false  # Variável para controlar se o inimigo está pulando

# Variáveis internas
var initial_position = Vector2.ZERO
var target_position = Vector2.ZERO
var jump_timer = 0.0
var animation_player : AnimationPlayer = null

func _ready():
	# Armazena a posição inicial do inimigo
	initial_position = position
	# Calcula a posição alvo
	target_position = initial_position + direction * distance
	# Inicia o temporizador de salto
	jump_timer = jump_interval
	# Obtém uma referência para o AnimationPlayer
	animation_player = $AnimationPlayer

func _physics_process(delta):
	# Verifica se o inimigo está no chão (pode pular)
	var on_ground = is_on_floor()

	# Move o inimigo
	move_and_slide(direction * speed)

	# Verifica se o inimigo atingiu a posição alvo
	if position.distance_to(target_position) < 1.0:
		# Inverte a direção
		direction *= -1
		# Define a nova posição alvo
		target_position = position + direction * distance

	# Atualiza o temporizador de salto
	jump_timer -= delta
	if jump_timer <= 0.0 and on_ground:
		# Realiza um salto
		jump()
		# Reinicia o temporizador de salto
		jump_timer = jump_interval

func jump():
	if is_jumping:
		return

	# Reproduz a animação "jump"
	animation_player.play("jump")
	# Aplica uma força vertical para realizar o salto
	var jump_vector = Vector2(0, jump_force)
	move_and_slide(jump_vector, Vector2.UP)
	# Define que o inimigo está pulando
	is_jumping = true

func _on_animation_player_animation_finished(anim_name):
	# Verifica se a animação "jump" foi concluída
	if anim_name == "jump":
		# Reproduz a animação "idle" quando o salto termina
		animation_player.play("idle")
		# Define que o inimigo não está pulando
		is_jumping = false
