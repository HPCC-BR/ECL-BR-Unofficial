IMPORT TrainingDiegoOliveira._CustomTR as C;
IMPORT $;

EXPORT CustomerOrder := MODULE
	
	CustomerRC := RECORD
		C.Addresses.File;
	END;
	
	OrderPhase2 := RECORD
		$.OrderDetails.File;
	END;
	
	Customer_OrderRC := RECORD
		RECORDOF(CustomerRC);
		// DATASET(OrderPhase2) Detalhes;
		DATASET(RECORDOF(OrderPhase2) AND NOT [Nome,Sobrenome]) Detalhes;
	END;
	
	OrderPhase2TB := TABLE($.OrderDetails.File,OrderPhase2);
	AddressTB := TABLE(C.Addresses.File,CustomerRC);
	
	DistinctOrdersTB := TABLE(DEDUP(C.OrdersTR.File,LEFT.Pedido = RIGHT.Pedido),{Nome,Sobrenome,Pedido});
	CustomerTB := JOIN(AddressTB,DistinctOrdersTB,
											LEFT.Nome = RIGHT.Nome AND LEFT.Sobrenome = RIGHT.Sobrenome, RIGHT OUTER
											);
	
	Customer_OrderRC InitPhase2 (CustomerRC L) := TRANSFORM
		SELF.Detalhes := [];
		SELF := L;
	END;
	
	Customer_OrderIN := PROJECT(AddressTB,InitPhase2(LEFT));
	
	Customer_OrderRC Insert_Orders (Customer_OrderRC L, OrderPhase2 R) := TRANSFORM
		// SELF.Detalhes := L.Detalhes + R;		
		SELF.Detalhes := L.Detalhes + ROW(R,RECORDOF(OrderPhase2) AND NOT[Nome,Sobrenome]);
		SELF := L;
	END;
	
	EXPORT File := DENORMALIZE(Customer_OrderIN,OrderPhase2TB,
															LEFT.Nome = RIGHT.Nome AND LEFT.Sobrenome = RIGHT.Sobrenome,
															Insert_Orders(LEFT,RIGHT))	
															:
															PERSIST('~ONLINE::DCO::CUSTOMTR::CustomerOrder')
															;
															
  EXPORT Main() := File;
	
END;