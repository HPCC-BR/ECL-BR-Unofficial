IMPORT Cities;

EXPORT CitiesRegionFetching := MODULE

DataFile := '~online::thor::citiesregion';
KeyFile  := 'roxie::citiesregionkey';


EXPORT BaseFile := DATASET(DataFile,
		               {UNSIGNED8 id,
									  STRING30 name,
									  STRING2 state,
									  STRING20 region,
									  UNSIGNED8 RecPos {virtual(fileposition)}},
									 FLAT);


EXPORT SoutheastCities := FETCH(BaseFile, 
										 Cities.Indexing.CitiesRegionIndex.IDX_state_region(KEYED(region='SUDESTE')),
										 RIGHT.RecPos);
										 
										 
EXPORT SouthCities := FETCH(BaseFile, 
										 Cities.Indexing.CitiesRegionIndex.IDX_state_region(KEYED(region='SUL')),
										 RIGHT.RecPos);
 
										 
EXPORT NorthCities := FETCH(BaseFile, 
										 Cities.Indexing.CitiesRegionIndex.IDX_state_region(KEYED(region='NORTE')),
										 RIGHT.RecPos);
										 

EXPORT WestCenterCities := FETCH(BaseFile, 
										 Cities.Indexing.CitiesRegionIndex.IDX_state_region(KEYED(region='CENTRO-OESTE')),
										 RIGHT.RecPos);
										
										
EXPORT NortheastCities := FETCH(BaseFile, 
										 Cities.Indexing.CitiesRegionIndex.IDX_state_region(KEYED(region='NORDESTE')),
										 RIGHT.RecPos);
										 

EXPORT Cities := FETCH(BaseFile, 
										 Cities.Indexing.CitiesRegionIndex.IDX_state_region,
										 RIGHT.RecPos);
										 
										 
										 
END;
