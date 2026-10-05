/// ------------------------------------------------------------------
/// Inicialização do Objeto Pai Universal (obj_lifeForm)
/// Serve como base de herança para obj_player, obj_enemy e NPCs
/// ------------------------------------------------------------------

hsp = 0;
vsp = 0;
moveSpeed = 3.0;
colMask = obj_wall;

hp_max = 100;
hp = hp_max;

faceDir = FACE_DIR.DOWN;