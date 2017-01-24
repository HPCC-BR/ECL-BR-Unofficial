IMPORT Cities;


EXPORT CitiesSearchService() := FUNCTION

STRING15 state := '' : STORED('State');
STRING25 region := '' : STORED('Region');


Fetched := IF(state <> '',
Cities.Fetching.CitiesStateFetching(state,''),
Cities.Fetching.CitiesStateFetching('',region));



RETURN OUTPUT(Fetched);

END;