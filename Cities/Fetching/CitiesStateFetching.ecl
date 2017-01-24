IMPORT Cities;


EXPORT CitiesStateFetching(STRING _state, STRING _region) := FUNCTION

Filter := IF(_state ='',
								Cities.Indexing.CitiesRegionIndex.IDX_state_region(region = _region),
									Cities.Indexing.CitiesRegionIndex.IDX_state_region(state = _state ));
									
		
Fetched_Cities := FETCH(Cities.Indexing.CitiesRegionIndex.basefile, Filter, RIGHT.recpos);


RETURN Fetched_Cities;


END;