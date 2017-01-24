ThorCluster := RECORD
  string name {xpath('ClusterName')}
  END;

OutRec1 := RECORD
  DATASET(ThorCluster) Fred{XPATH('ThorClusters/ThorCluster')};
END;

raw := HTTPCALL('http://localhost:8010/WsSMC/Activity?rawxml_', 'GET', 'text/xml', OutRec1);

OUTPUT(raw);