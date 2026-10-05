// 1. Armazena a posição atual para o rastro antes de se mover
array_insert(trailX, 0, x);
array_insert(trailY, 0, y);
if (array_length(trailX) > maxTrail)
{
    array_pop(trailX);
    array_pop(trailY);
}

// 2. Movimentação horizontal
x += hsp;

// 3. Colisão com parede
if (place_meeting(x, y, obj_wall))
{
    instance_destroy();
    exit;
}

// 4. Colisão com alvos (inimigos e partes do boss herdadas de obj_lifeForm)
var _target = instance_place(x, y, obj_lifeForm);
if (_target != noone)
{
    var _hitDir = (hsp != 0) ? sign(hsp) : 1;
    with (_target)
    {
        scr_enemyTakeDamage(_hitDir, other.damage);
    }
    instance_destroy();
    exit;
}

// 5. Destruição se sair dos limites da room
if (x < 0 || x > room_width)
{
    instance_destroy();
}
