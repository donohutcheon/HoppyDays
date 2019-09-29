extends Node2D

var lives = 3
var coins = 0
var life_up_count = 10
var level = 0
var levels = []
var invincible = false;
var invincibleTimer = Timer.new()

func _ready():
	levels.push_back("res://Levels/Level1.tscn")
	levels.push_back("res://Levels/Level2.tscn")
	levels.push_back("res://Levels/Victory.tscn")
	add_to_group("gamestate");
	invincibleTimer.connect("timeout", self, "on_invincible_ended")
	add_child(invincibleTimer);
	update_GUI()

func on_invincible_ended():
	invincible = false;
	invincibleTimer.stop()

func hurt():
	if invincible == true:
		return
	invincible = true;
	invincibleTimer.start(2);
	lives -= 1
	$Player.hurt()
	update_GUI()
	if lives < 0:
		end_game()

func update_GUI():
	get_tree().call_group("GUI", "update_GUI", lives, coins)

func coin_up():
	coins += 1
	update_GUI()
	if coins % life_up_count == 0:
		life_up()

func life_up():
	lives += 1
	update_GUI()

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")
	
func win_game():
	level += 1;
	get_tree().change_scene(levels[level])