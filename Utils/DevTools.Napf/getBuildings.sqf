	//Objects (Buildings, etc.)
_cfgobjects = configFile >> "cfgVehicles";
diag_log("Buildings Starts Here!");
	for "_i" from 0 to (count _cfgobjects)-1 do{
		_object = _cfgobjects select _i;
		if (isClass _object) then{
			_obj_type = configName _object;
			if ((getNumber (_object >> "scope") == 2) && (getText (_object >> "picture") != "") && !((_obj_type isKindOf "ParachuteBase") or (_obj_type isKindOf "BIS_Steerable_Parachute")) && (_obj_type isKindOf "Building")) then{
			
				diag_log _object;
			};
		};
	};


//	Weapons

_cfgmagazines = configFile >> 'CfgMagazines';
diag_log("Magazines Starts Here!");
	for "_i" from 0 to (count _cfgmagazines)-1 do{
		_weapon = _cfgmagazines select _i;
		if (isClass _weapon) then{
			_wpn_type = configName _weapon;
			if ((getNumber (_weapon >> "scope") == 0) or (getNumber (_weapon >> "scope") == 2)) then{
			
				diag_log _weapon;
			};
		};
	};
	
_cfgweapons = configFile >> 'cfgWeapons';
diag_log("Weapons Starts Here!");
	for "_i" from 0 to (count _cfgweapons)-1 do{
		_weapon = _cfgweapons select _i;
		if (isClass _weapon) then{
			_wpn_type = configName _weapon;
			if ((getNumber (_weapon >> "scope") == 0) or (getNumber (_weapon >> "scope") == 2)) then{
			
				diag_log _weapon;
			};
		};
	};

	//Vehicles

_cfgvehicles = configFile >> "cfgVehicles";
diag_log("Vehicles Starts Here!");
	for "_i" from 0 to (count _cfgvehicles)-1 do{
		_vehicle = _cfgvehicles select _i;
		if (isClass _vehicle) then{
			_veh_type = configName _vehicle;
			if ((getNumber (_vehicle >> "scope") == 2) && (getText (_vehicle >> "picture") != "") && (((_veh_type isKindOf "LandVehicle") or (_veh_type isKindOf "Air") or (_veh_type isKindOf "Boat"))) && !((_veh_type isKindOf "ParachuteBase") or (_veh_type isKindOf "BIS_Steerable_Parachute"))) then{
			
				diag_log _vehicle;
			};
		};
	};
	