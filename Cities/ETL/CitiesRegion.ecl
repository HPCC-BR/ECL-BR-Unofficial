EXPORT CitiesRegion := MODULE

rsCities := RECORD
  UNSIGNED8 id;
  STRING30  name;
	STRING2  state;
END;

dsCities := DATASET('~online::phmp::cities',rsCities, csv(separator(',')));

rsCitiesRegion := RECORD
	  UNSIGNED8  id := dsCities.id;
    STRING30  name := dsCities.name;
	  STRING2  state := dsCities.state;
	  STRING20 region := '';
END;


dsCitiesRegion := TABLE(dsCities,rsCitiesRegion,
											 id,
											 name,
											 state);
											 
STRING20 setRegion(STRING state) := FUNCTION

ListSouthEast := ['SP','RJ','MG','ES'];
ListSouth := ['RS','SC','PR'];
ListNorth := ['AC','AP','AM','PA','RO','RR','TO'];
ListNorthEast := ['AL','BA','CE','MA','PB','PE','PI','RN','SE'];
ListWestCenter := ['GO','MT','MS','DF'];

STRING20 region := MAP(state IN ListSouthEast => 'SUDESTE',
											 state IN ListSouth => 'SUL',
											 state IN ListNorth => 'NORTE',
											 state IN ListNorthEast => 'NORDESTE',
											 state IN ListWestCenter => 'CENTRO-OESTE',
											 'ERROR');
 

RETURN region;

END;											 
											 

rsCitiesRegion fillRegion(rsCitiesRegion L) := TRANSFORM

SELF.id := L.id;
SELF.name := L.name;
SELF.state := L.state;
SELF.region := setRegion(L.state);

END;


EXPORT File := PROJECT(dsCitiesRegion,fillRegion(LEFT));

EXPORT Layout := RECORDOF(File);




END;

