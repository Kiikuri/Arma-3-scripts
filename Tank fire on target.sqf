///_veh = tank
///_tar = target
///_laserTar = true if assigning targets with laser, false if not.
///_maxDist = maximum firing distance 
///_tarPr = minimum accuracy to target. 1 = 100%, 0.9 = 90%
/// The tank fires either 120mm APFSDS or HE rounds.
/// When the target is on foot, the tank shoots at the target with HE shells.
/// When the target is in a vehicle within the maximum firing range, the tank will fire APFSDS shells.
/// The tank will stop engaging when it either runs out of ammunition or the target is destroyed.
/// If the universal variable "ceaseFire" is set to greater than 0, the tank will stop firing.

0=[] spawn
{
    _veh = tankki; 

    _tar = objNull; 
    _laserTar = true;

    _maxDist = 30000;
    _tarPr = 0.95;



    if(_lasertar) then{
        if(UAVControl getConnectedUAV player select 1 == "GUNNER") 
        then{_tar = laserTarget getConnectedUAV player;}
        else{_tar = laserTarget player;};
    };
    ABTar = _tar;
    ABMaxDist = _maxDist;
    ceaseFire = 0;
    _distance = (_veh distance _tar); 
    _weap = (currentWeapon _veh);  
    _weapcount = count (weapons _veh); 
    _veh setEffectiveCommander gunner _veh;
    _comma = (effectiveCommander _veh);
    _ammo = _veh ammo _weap; 
    if(alive _tar && _distance > _maxDist) exitWith{_veh sideChat format['Target out of range!'];};
    doStop _veh;

    switch (true) do 
    {
        case (count magazinesAllTurrets _tar == 0 or _tar == laserTarget player): 
        {
            _veh selectWeapon ((weapons _veh)select 0); 
            _veh loadMagazine[[0],((weapons _veh)select 0), ((magazines _veh)select 1)];
        };
        case (count magazinesAllTurrets _tar > 0): 
        {
            _veh selectWeapon ((weapons _veh)select 0);
            _veh loadMagazine[[0],((weapons _veh)select 0), ((magazines _veh)select 0)];
        };
    };

    switch (true) do 
    {
        case (_laserTar):
        {
            _comma commandTarget _tar;
            _veh commandWatch getPosATL _tar;
            sleep 5;
            if(_veh aimedAtTarget[_tar] < _tarPr) then
            {
                _veh doMove getPosASL _tar;
                _veh moveTo getPosASL _tar;
            };
            while {_veh aimedAtTarget[_tar] < _tarPr && alive _tar}
            do
            {
                _veh commandWatch getPosATL _tar;
                sleep 1;
            };
            doStop _veh; 
            _veh fireAtTarget [_tar];
            sleep 1;
            _veh sideChat format['Target destroyed!'];
        };

        case (count magazinesAllTurrets _tar > 0 && count crew _tar > 0):
        {
            _ntar = vehicle _tar;
            while {alive _ntar or damage _ntar < 1 && _distance < _maxDist} 
            do 
            {
                if(!alive _tar or damage _tar == 1 && _distance < _maxDist) exitWith{_veh sideChat format['Target destroyed!'];};
                if(ceaseFire != 0) exitWith{_veh sideChat format['Ceasing fire!'];};   
                _ammo = _veh ammo _weap;  
                switch (true) do
                {
                    case (_ammo == 0 && currentMagazine _veh == ((magazines _veh)select 2)): 
                    {
                        _veh sideChat format['Out of ammo!']; 
                        ceaseFire = 1;
                    };

                    case (_ammo == 0): 
                    {
                        _veh loadMagazine[[0],((weapons _veh)select 0), ((magazines _veh)select 2)];
                        _ammo = _veh ammo _weap;  
                    };
                };
                _comma doTarget _ntar;
                _veh commandWatch getPosATL _tar;
                sleep 5;
                if(_veh aimedAtTarget[_ntar] < _tarPr) then
                {
                    _veh doMove getPosASL _ntar;
                    _veh moveTo getPosASL _ntar;
                };
                while {_veh aimedAtTarget[_ntar] < _tarPr}
                do
                {
                    _comma doTarget _ntar;
                    _veh commandWatch getPosATL _tar;
                    sleep 0.2;
                };
                doStop _veh; 
                _veh fireAtTarget [_ntar]; 
            };
            doStop _veh; 
            _veh doWatch objNull;;
        };

        case ((count magazinesAllTurrets _tar >= 0 && count crew _tar == 0) or (count magazinesAllTurrets _tar == 0)):
        {
            while {alive _tar or damage _tar < 1 && _distance < _maxDist && _ammo != 0} 
            do 
            {
            if(!alive _tar or damage _tar == 1 && _distance < _maxDist) exitWith{_veh sideChat format['Target destroyed!'];};
            if(ceaseFire != 0) exitWith{_veh sideChat format['Ceasing fire!'];};   
            _ammo = _veh ammo _weap;  
            switch (true) do
            {
                case (_ammo == 0 && currentMagazine _veh == ((magazines _veh)select 2)): 
                {
                    _veh sideChat format['Out of ammo!'];
                    ceaseFire = 1;
                };

                case (_ammo == 0): 
                {
                    _veh loadMagazine[[0],((weapons _veh)select 0), ((magazines _veh)select 2)];
                    _ammo = _veh ammo _weap;  
                };
            };
            _comma doTarget _tar;
            _veh commandWatch getPosATL _tar;
            sleep 5;
            if(_veh aimedAtTarget[_tar] < _tarPr) then
            {
                _veh doMove getPosASL _tar;
                _veh moveTo getPosASL _tar;
            };
            while {_veh aimedAtTarget[_tar] < _tarPr}
            do
            {
                _comma doTarget _tar;
                _veh commandWatch getPosATL _tar;
                sleep 0.2;
            };
            doStop _veh; 
            _veh fireAtTarget [_tar]; 
            };
            doStop _veh; 
            _veh doWatch objNull;;
        };
        default{_veh sideChat format['No target!'];};
    };
    doStop _veh; 
};