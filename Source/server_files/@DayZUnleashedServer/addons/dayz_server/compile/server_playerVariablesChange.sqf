private ["_characterID","_temp","_class","_currentWpn","_magazines","_force","_isNewPos","_humanity","_isNewGear","_currentModel","_modelChk","_playerPos","_playerGear","_playerBackp","_backpack","_killsB","_killsH","_medical","_isNewMed","_character","_timeSince","_charPos","_isInVehicle","_distanceFoot","_lastPos","_kills","_headShots","_timeGross","_timeLeft","_onLadder","_isTerminal","_currentAnim","_muzzles","_array","_key","_lastTime","_config","_currentState","_pos"];
diag_log("MULTI VARIABLE SAVE ATEMPT!");
_target_character = _this select 0;
_array  = _this select 1;
_variables=(_array select 0);
_values=(_array select 1);
_checksum=(_array select 2);
_target_characterID =  _target_character getVariable ["characterID","0"];

if (isnil "_target_characterID") exitWith {
    diag_log ("ERROR: Cannot Save Character " + (name _target_character) + " has nil characterID");    
};

if (_target_characterID == "0") exitWith {
    diag_log ("ERROR: Cannot Sync Character " + (name _target_character) + " as no characterID");
};

if(count _array != 3)  exitWith {
        diag_log format["Character: %1 attempted to save bad data.",_target_character];
        diag_log format["Data: %1",_array];
};

if((count _variables != _checksum)||(count _values != _checksum))  exitWith {
        diag_log format["Character: %1 attempted to save bad data.",_target_character];
        diag_log format["Data: %1",_array];
};

diag_log("Character : " + str(_target_character));
diag_log("Variables : " + str(_variables));
diag_log("Values    : " + str(_target_value));
if ((_target_characterID != "0")&&(!isNull _target_character)&&(alive _target_character)) then {
    for "_i" from 0 to ((count _variables) - 1) do {
        _target_variable=(_variables select _i);
        _target_value   =(_values select _i);
        _key = format["CHILD:152:%1:%2:%3:",_target_characterID,_target_variable,_target_value];
        //diag_log ("HIVE: WRITE: "+ str(_key) + " / " + str(_target_character));
        _key call server_hiveWrite;
        sleep 0.01;
    };
    diag_log ("Done.");
};
