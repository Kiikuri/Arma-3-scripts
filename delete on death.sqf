0= [] spawn {  
	_driver = driver this;
	while{true}do{ 
		if(damage this >= 0.99 || damage _driver >= 0.99) 
		then{ 
			this setDamage 1; 
			sleep 2;
			deleteVehicle this; 
	}; 
	}; 
};