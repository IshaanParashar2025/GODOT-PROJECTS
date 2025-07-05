extends Node3D

@export var moving := false
@export var flying := false
@export var explosive := false
@export var target_distance : float = 2
@export var move_speed := 5
@export var change_horizontal_dir := 1

signal destroyed
