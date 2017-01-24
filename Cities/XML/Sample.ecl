worldBankSource := RECORD
string name {xpath('wb:name')}
END;

OutRec1 := RECORD
DATASET(worldBankSource) Fred{XPATH('/wb:source')};
END;

raw := HTTPCALL('http://api.worldbank.org:80/sources', 'GET', 'text/xml', OutRec1);

OUTPUT(raw);