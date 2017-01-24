IMPORT Cities;


sourceRecord := RECORD
    STRING30  name{xpath('/serviceResponse/Results/Result/Dataset/Row/name')};
	  STRING20  state{xpath('/serviceResponse/Results/Result/Dataset/Row/state')};
	  STRING20 region{xpath('serviceResponse/Results/Result/Dataset/Row/region')};
END;







raw := HTTPCALL('http://192.168.56.101:8002/WsEcl/submit/query/roxie/citiessearchservice.1/xml?region=SUL&state=', 'GET', 'text/xml', sourceRecord);

OUTPUT(raw);


//OUTPUT(dsOut);
