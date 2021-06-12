# author: Marvin Schmitt
# coauthor list: Daniel Knoll

extends Node

export (PackedScene) var Coin
var score = 0

onready var coin = $Coin

func _ready():
	randomize()
	$Score.text = str(score)

func _on_Coin_hit():
	score += 1
	$Score.text = str(score)
	
	$CoinPath/CoinSpawnLocation.offset = randi()
	coin.position = $CoinPath/CoinSpawnLocation.position
