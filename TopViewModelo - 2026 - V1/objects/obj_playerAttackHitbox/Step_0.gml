if (instance_exists(creator))
{
    x = creator.x + (creator.image_xscale * 32);
    y = creator.y;
    image_xscale = creator.image_xscale;
}

// Colisão com alvos (garante apenas 1 hit por ataque swing)
with (obj_lifeForm)
{
    if (id != other.creator && place_meeting(x, y, other))
    {
        if (ds_list_find_index(other.hitList, id) == -1)
        {
            ds_list_add(other.hitList, id);
            var _dir = (other.x < x) ? -1 : 1;
            scr_enemyTakeDamage(_dir, 20);
        }
    }
}

attackTime--;

if (attackTime <= 0)
{
    instance_destroy();
}