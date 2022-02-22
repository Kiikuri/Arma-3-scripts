// Artillery barrage
// Checks if the target is in range, then:
// fires at a specified number of targets
// with a specified number of the specified munition
// with a specified interval between shots
// with a specified number of artillery units

// <Variables> 
// _name = variable name of the artillery unit + an underscore as string (variable names are to begin with <arty>_1, etc...).
// _tar = variable name of the target (only if _MultipleTargets = false, otherwise the variable name of the target + an underscore as string (<target>_1, etc...)).
// _MultipleTargets = Multiple targets? yes/no (true = number of targets needs to be equal to the number of arty units).
// _lkm = Number of artillery units. (and targets if _MultipleTargets = true)
// _Shots = Number of shots. preferrably only 1-3, Some munitions only have 2 shots. i.e cluster rounds.
// _Interval = how many seconds between shots.
// _MagazineSlot = used munition, index from the unit's magazines table (number 0, 1, 2, 3, etc...).
// _Increment = accuracy of min/max distances. preferrably under 100.
// _Vehicle = vehicle for determining min/max ranges. Must have, otherwise the script crashes. preferrably the first/only unit.
// </Variables> 

0= [] spawn { 
    _name = "arty_";  
    _tar = "tar_";
    _MultipleTargets = true;
    _lkm = 10;
    _Shots = 1;
    _Interval = 0.3;
    _MagazineSlot = 0;
    _Increment = 50;
    _Vehicle = arty_1;



    _numero = 0;  
    _MaxRange = -1;
    _MinRange = -1;
    _Position = getPosASL _Vehicle;
    _objt = _tar;
    while{_MaxRange < 0}
    do{
        _Test = _Position inRangeOfArtillery[[_Vehicle], ((magazines _Vehicle) select _MagazineSlot)];
        if(_Test && _MinRange < 0) 
        then {
            _MinRange = _Position distance _Vehicle;
        };

        if(!_Test && _MinRange >= 0) 
        then {_MaxRange = _Position distance _Vehicle;
        };
        _Position = [
            (_Position select 0) + _Increment,
            (_Position select 1),
            (_Position select 2)
        ];
    };
    _MaxRange = _MaxRange - (_MaxRange%_Increment) - _Increment;
    _MinRange = _MinRange - (_MinRange%_Increment) + _Increment;
    systemChat format["Maximum range = %1, Minimum range = %2", _MaxRange, _MinRange];

    while{_numero < _lkm} 
    do 
    { 
        sleep _Interval;
        _numero = _numero +1; 
        _numb = str _numero; 
        _nimi = _name + _numb;  
        _obj = call compile _nimi; 

        if(_MultipleTargets) 
        then{
            _targetti = _tar + _numb;
            _objt = call compile _targetti;
        }; 

        if(_obj distance _objt <= _MinRange) 
        then{
            systemChat format["Target too close, target %1 is %2 meters away from %3. The minimum range is %4", _objt, (_obj distance _objt), _obj, _MinRange];
        };

        if(_obj distance _objt >= _MaxRange) 
        then{
            systemChat format["Target too far away, target %1 is %2 meters away from %3. The maximum range is %4", _objt, (_obj distance _objt), _obj, _MaxRange];
        };
        _obj doArtilleryFire[getPosASL _objt, ((magazines _obj) select _MagazineSlot), _Shots];
    };
}