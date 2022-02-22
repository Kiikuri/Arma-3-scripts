_veh = kone;

_tar = laserTarget player;
_ase = ((weapons _veh)select 0);
_veh fireAtTarget [_tar, _ase];
_ase = ((weapons _veh)select 1);
_veh fireAtTarget [_tar, _ase];