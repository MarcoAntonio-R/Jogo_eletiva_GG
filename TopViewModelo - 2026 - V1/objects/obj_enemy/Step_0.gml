/// ------------------------------------------------------------------
/// obj_enemy - Step (Top-View Wander & Encounter)
/// ------------------------------------------------------------------

// Se estiver em batalha, fica parado no overworld
if (variable_global_exists("gameState") && global.gameState != GAME_STATE.OVERWORLD)
{
    hsp = 0;
    vsp = 0;
    exit;
}

// Lógica simples de vagar (Wander) em Top-View
wanderTimer--;
if (wanderTimer <= 0)
{
    wanderTimer = irandom_range(60, 180);
    if (random(100) < 50)
    {
        wanderDir = random(360);
        hsp = lengthdir_x(moveSpeed, wanderDir);
        vsp = lengthdir_y(moveSpeed, wanderDir);
    }
    else
    {
        hsp = 0;
        vsp = 0;
    }
}

event_inherited();

// Colisão com o jogador inicia a batalha Pokémon selvagem
if (place_meeting(x, y, obj_player))
{
    if (instance_exists(obj_battleManager))
    {
        obj_battleManager.startWildBattle();
    }
}