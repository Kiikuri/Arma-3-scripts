_Vehicle = 'variable name of the artillery unit';  
_MagazineSlot = 'magazine slot number for the ammunition (you can find it by counting down from the units magazines, i.e hint str magazines <your unit> and count from 0 to what you want)';
_Increment = 'increments at which the script will check if the range is at min or max (basically the accuracy of the values you get for the ranges with how much it can throw off)';

_MaxRange = -1;
_MinRange = -1;
_Position = getPosASL _Vehicle;
while{_MaxRange < 0}
do{
    _Test = _Position inRangeOfArtillery[[_Vehicle], ((magazines _Vehicle) select _MagazineSlot)];
    if(_Test && _MinRange < 0) then {_MinRange = _Position distance _Vehicle;};
    if(!_Test && _MinRange >= 0) then {_MaxRange = _Position distance _Vehicle;};
    _Position = [
        (_Position select 0) + _Increment,
        (_Position select 1),
        (_Position select 2)
    ];
};
_MaxRange = _MaxRange - (_MaxRange%_Increment) - _Increment;
_MinRange = _MinRange - (_MinRange%_Increment) + _Increment;
systemChat format["max range = %1", _MaxRange];
systemChat format["min range = %1", _MinRange];