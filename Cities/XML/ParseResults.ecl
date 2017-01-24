IMPORT Cities;


sourceRecord := RECORD
    STRING30  nome{xpath('nome')};
	  STRING20  valor{xpath('valor')};
	  STRING20 fonte{xpath('valor')};
END;

outRecord := RECORD
    DATASET(sourceRecord) out{XPATH('/root/valores/USD')};
END;





raw := HTTPCALL('http://api.promasters.net.br/cotacao/v1/valores?moedas=USD&alt=xml', 'GET', 'text/xml', outRecord);

OUTPUT(raw);


//OUTPUT(dsOut);