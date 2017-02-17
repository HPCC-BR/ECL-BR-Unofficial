EXPORT OrdersTR := MODULE

	EXPORT Layout := RECORD
		STRING Nome;
		STRING Sobrenome;
		STRING Pedido;
		STRING Linha;
		STRING Cd_Prod;
		STRING Desc_Prod;
		DECIMAL10_2 Unit;
		INTEGER Qtde;
		DECIMAL10_2 Total;	
	END;

	EXPORT File := DATASET('~online::dco::customtr::orders',Layout,CSV(SEPARATOR('|')));

END;
