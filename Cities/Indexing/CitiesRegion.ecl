IMPORT Cities;

EXPORT CitiesRegionIndex := MODULE 


dsIndex := DATASET('~ONLINE::THOR::CitiesRegion',
		               {UNSIGNED8 id,
									  STRING30 name,
									  STRING2 state,
									  STRING20 region,
									  UNSIGNED8 RecPos {virtual(fileposition)}},
									 FLAT);


EXPORT IDX_state_region := INDEX(dsIndex,
				                  {region,state,RecPos},
				                  '~ROXIE::CitiesRegionKey');
													

EXPORT baseFile := DATASET('~ONLINE::THOR::CitiesRegion',
		               {UNSIGNED8 id,
									  STRING30 name,
									  STRING2 state,
									  STRING20 region,
									  UNSIGNED8 RecPos {virtual(fileposition)}},
									 FLAT);																		


END;



