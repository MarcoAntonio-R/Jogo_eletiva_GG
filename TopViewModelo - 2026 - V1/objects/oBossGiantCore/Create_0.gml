// Herança de obj_lifeForm
event_inherited();

hpMax = 400;
hp = hpMax;
phase = 1;
state = BOSS_GIANT_CORE_STATE.INTRO;

introTimer = 120;
attackTimer = 0;
attackCooldown = 180;
isVulnerable = false;
hitFlash = 0;

leftHandInst = noone;
rightHandInst = noone;
eyeInst = noone;
