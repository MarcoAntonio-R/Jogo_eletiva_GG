event_inherited();

handSide = -1; // Esquerda
hpMax = 100;
hp = hpMax;
state = BOSS_GIANT_HAND_STATE.IDLE;

attackTimer = 0;
restTimer = 0;
restTimerMax = 300;
hitFlash = 0;
coreOwner = noone;
