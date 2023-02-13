<?php

if(isset($i) && $i > 0) {
    // Autologin configuration
    $cfg['Servers'][$i]['auth_type'] = 'config';
    $cfg['Servers'][$i]['host'] = env('DB_HOST');
    $cfg['Servers'][$i]['user'] = env('DB_USERNAME');
    $cfg['Servers'][$i]['password'] = env('DB_PASSWORD');
}
