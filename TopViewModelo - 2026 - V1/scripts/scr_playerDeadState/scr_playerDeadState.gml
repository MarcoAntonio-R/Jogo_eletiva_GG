function scr_playerDeadState()
{
    // Tira resíduos de movimento e dano
    invTime = 0;
    hurtTime = 0;
    hsp = 0;
    vsp = 0;
    
    // Visual de morte (vai escurecendo e sumindo aos poucos)
    image_blend = c_black;
    image_alpha = lerp(image_alpha, 0, 0.05);
    
    deadTime--;

    if (deadTime <= 0)
    {
        if (currentLives > 0)
        {
            currentLives -= 1; // Perde uma vida
            
            // Caso o checkpoint não esteja definido, usa a posição inicial do objeto ou da arena
            if (checkpointX == 0 && checkpointY == 0)
            {
                if (room == rm_bossGiant)
                {
                    checkpointX = 200;
                    checkpointY = 640;
                }
                else
                {
                    checkpointX = xstart;
                    checkpointY = ystart;
                }
            }
            
            // Teletransporta para a coordenada salva
            x = checkpointX;
            y = checkpointY;
        
            // SEGURANÇA: Se o checkpoint estiver no cenário, ajusta a posição para cima
            var safety_counter = 0;
            var tempY = y;
            var collision_resolved = false;
            while (safety_counter < 32) 
            {
                if (!place_meeting(x, tempY, colMask))
                {
                    collision_resolved = true;
                    break;
                }
                tempY -= 1; 
                safety_counter++;
            }
            if (collision_resolved)
            {
                y = tempY;
            }
            
            // Reseta gerador de inundação de ácido caso exista na sala
            var flood = instance_find(obj_flood, 0);
            if (flood != noone)
            {
                with (flood)
                {
                    floodY = room_height + 64;
                    if (acidInstance != noone && instance_exists(acidInstance))
                    {
                        instance_destroy(acidInstance);
                    }
                    acidInstance = noone;
                }
            }
    
            // Reseta vida total e parâmetros do jogador
            hp = hp_max;
            checkpointLock = checkpointLockMax;
    
            // Reseta física e pulos
            hsp = 0;
            vsp = 0;
            grounded = false;
            jumpCount = maxJumps;
            canAirDash = true;
            dashCooldown = 0;
            dashTime = 0;
            stamina = stamina_max;
    
            // Volta para o estado de ar com visibilidade restaurada
            state = PLAYER_STATE.AIR;
            image_alpha = 1;
            image_blend = c_white;
            
            // Se estiver na sala do boss, reinicia a arena para resetar o boss
            if (room == rm_bossGiant)
            {
                room_restart();
            }
        }
        else 
        {
            currentLives = 3; // Reseta vidas padrão
            room_restart();
            exit;
        }
    }
}