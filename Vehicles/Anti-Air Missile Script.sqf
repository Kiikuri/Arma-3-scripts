// Anti-Air Script
// AA fires at target (on the ground or in the air)
// ceaseFire = Global variable to stop the script
// _veh = Variable name of the Anti-Air cannon/vehicle
// _tar = Variable name of the target
// _maxDist = Maximum distance for the main cannon. i.e 20mm AA cannon.
// Fires continuously at the target. 
// If using the main gun, fires until the target is destroyed, out of range or the gun runs out of ammo.
// If the target is out of range, switches to a secondary weapon if possible (i.e AA missiles)
// If using secondary weapons, fires every 20 sec, until either runs out of ammo, or the target is destroyed. 
// Secondary weapons do not have a max range.
// Designed for anti-air vehicles. i.e Bluefor -> Anti-Air -> Bardelas.

0 = [] spawn {
  _veh = 'VariableName of attacking vehicle'; 
  _tar = 'VariableName of target'; 
  _maxDist = 'Maximum distance to target while using the main gun';


  _i = 0; 
  ceaseFire = 0;
  while {_i < 2} do { 
    _weap = (currentWeapon _veh);  
    _weapcount = count (weapons _veh); 
    _distance = (_veh distance _tar); 
    _veh setEffectiveCommander gunner _veh;
    _comma = (effectiveCommander _veh);
    if(alive _tar && _distance > _maxDist && _weapcount == 1) exitWith{hint format["Target Out Of Range"];};
    if (_weap == ((weapons _veh) select 0) && _distance < _maxDist)   
    then 
    {  
      _comma doTarget _tar; 
      waitUntil{_veh aimedAtTarget[_tar] >= 0.9};
      _weap = (currentWeapon _veh);  
      _ammo = _veh ammo _weap; 
      while {alive _tar && _ammo > 0} do   
        {   
          if(_distance > _maxDist && _weapcount > 1) exitWith{hint format["Target Out Of Range, Switching To Secondary"]; _veh selectWeapon ((weapons _veh) select 1);};
          if(_distance > _maxDist && _weapcount == 1) exitWith{hint format["Target Out Of Range"];}; 
          if(ceaseFire != 0) exitWith{hint format["Ceasing Fire"];};
          _veh fireAtTarget [_tar]; 
          _ammo = _veh ammo _weap; 
        }; 
      if(_ammo == 0 && _weapcount > 1 && (_veh ammo ((weapons _veh) select 1) != 0))  
      then 
      { 
        _veh selectWeapon ((weapons _veh) select 1); 
      } 
    }  
    else 
    {  
      _weap = (currentWeapon _veh);
      _veh selectWeapon ((weapons _veh) select 1); 
      if (_weap == ((weapons _veh)select 0)) exitWith{hint format["Target Out Of Range"];};
      _comma doTarget _tar;
      waitUntil{_veh aimedAtTarget[_tar] >= 0.9}; 
      
      _ammo = _veh ammo _weap; 
      while {alive _tar && _ammo > 0} do   
      {   
        if(ceaseFire != 0) exitWith{hint format["Ceasing Fire"];};   
        _veh fireAtTarget [_tar];   
        _ammo = _veh ammo _weap; 
        sleep 20;   
      }; 
      if(_ammo == 0 && (_veh ammo ((weapons _veh) select 0) != 0))  
      then 
      { 
        _veh selectWeapon ((weapons _veh) select 0); 
      } 
    };  
    _comma doWatch objNull; 
    if(!alive _tar) exitWith{hint format["Target Destroyed"];};
    _i = _i +1; 
  }; 
};