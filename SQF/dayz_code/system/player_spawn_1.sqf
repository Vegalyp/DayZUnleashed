private["_handle","_body","_cursor","_delMe"];
while {true} do {
	_handle = [] spawn player_animalCheck;
	waitUntil{scriptDone _handle};

	//check monitored buildings
	_cursor = 0;
	_delMe = false;
	{
		private["_bPos","_isNoone"];
		_bPos = getPosATL _x;
		_isNoone = {isPlayer _x} count (_bPos nearEntities ["Man",200]) == 0;
		if (_isNoone) then {
			//_x setVariable ["zombied",objNull,true];
			dayz_buildingMonitor set [_cursor,"DEL"];
			_delMe = true;
		};
		_cursor = _cursor + 1;
	} forEach dayz_buildingMonitor;
	if (_delMe) then {
		dayz_buildingMonitor = dayz_buildingMonitor - ["DEL"];
	};
	
	//Check if new day
	_day = round(360 * (dateToNumber date));
	if(dayz_currentDay != _day) then {
		dayz_sunRise = call world_sunRise;
		dayz_currentDay = _day;
	};

	//wait
	sleep 5;
};