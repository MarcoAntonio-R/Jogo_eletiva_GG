enum GAME_STATE 
{
    OVERWORLD,
    BATTLE_TRANSITION,
    BATTLE
}

enum BATTLE_STATE 
{
    START,
    PLAYER_OPTION,
    SELECT_MOVE,
    SELECT_TARGET,
    BUILD_ACTION_QUEUE,
    EXECUTE_QUEUE_ACTION,
    CHECK_ROUND_END,
    EXECUTE_PLAYER_TURN,
    EXECUTE_ENEMY_TURN,
    EXECUTE_FIRST_TURN,
    EXECUTE_SECOND_TURN,
    CHECK_FAINT,
    VICTORY,
    DEFEAT,
    RUN
}

enum ELEMENT 
{
    NORMAL,
    FIRE,
    WATER,
    GRASS,
    ELECTRIC
}

enum STAT_BUFF 
{
    NONE,
    ATK_UP,     // Aumenta Ataque (+50%)
    ATK_DOWN,   // Reduz Ataque (-30%)
    DEF_UP,     // Aumenta Defesa (+50%)
    DEF_DOWN,   // Reduz Defesa (-30%)
    SPD_UP,     // Aumenta Velocidade (+50%)
    SPD_DOWN    // Reduz Velocidade (-30%)
}
