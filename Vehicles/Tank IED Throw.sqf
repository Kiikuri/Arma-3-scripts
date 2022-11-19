0=[] spawn 
{ 
_veh = tankki;
_explosive = ied;

 _veh setVelocity[(velocity _veh select 0),(velocity _veh select 1),4];
 _explosive setDamage 1;
}