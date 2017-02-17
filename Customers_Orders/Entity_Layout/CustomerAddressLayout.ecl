EXPORT Addresses := MODULE

	EXPORT Layout := RECORD
		STRING Nome;
		STRING Sobrenome;
		STRING Endereco;	
	END;

	EXPORT File := DATASET('~online::dco::customtr::addresses',Layout,CSV(SEPARATOR('|')));

END;
