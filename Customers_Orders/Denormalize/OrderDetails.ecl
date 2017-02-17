IMPORT TrainingDiegoOliveira._CustomTR as C;
IMPORT $;

EXPORT OrderDetails := MODULE
	
	OrderRC := RECORD
		C.OrdersTR.File.Nome;
		C.OrdersTR.File.Sobrenome;
		C.OrdersTR.File.Pedido;
	END;
	
	OrderTB := DEDUP(TABLE(C.OrdersTR.File,{Nome, Sobrenome, Pedido}),LEFT.Pedido = RIGHT.Pedido);
	
	ItemsRC := RECORD
		C.OrdersTR.File.Pedido;
		C.OrdersTR.File.Linha;
		C.OrdersTR.File.Cd_Prod;
		C.OrdersTR.File.Desc_Prod;
		C.OrdersTR.File.Unit;
		C.OrdersTR.File.Qtde;
		C.OrdersTR.File.Total;
	END;
	
	ItemsTB := TABLE(C.OrdersTR.File,ItemsRC);
	
	Order_DetailsRC := RECORD
		OrderRC;
		// DATASET(ItemsRC) Itens_Pedido;
		DATASET(RECORDOF(ItemsRC) AND NOT [Pedido]) Itens_Pedido;
	END;
	
	// Initialize Denormalized Record
	Order_DetailsRC InitPhase1 (OrderRC L) := TRANSFORM
		SELF.Itens_Pedido := [];
		SELF := L;
	END;
	
	Order_DetailsIN := PROJECT(OrderTB, InitPhase1(LEFT));
	
	Order_DetailsRC Insert_Order_Details (Order_DetailsRC L, ItemsRC R) := TRANSFORM
		// SELF.Itens_Pedido := L.Itens_Pedido + R;
		SELF.Itens_Pedido := L.Itens_Pedido + ROW(R,RECORDOF(ItemsRC) AND NOT [Pedido]);
		SELF := L;
	END;
	
	EXPORT File := DENORMALIZE(Order_DetailsIN,ItemsTB,
															LEFT.Pedido = RIGHT.Pedido,
															Insert_Order_Details(LEFT,RIGHT))
															:
															PERSIST('~ONLINE::DCO::CUSTOMTR::Order_Details');
															
  EXPORT Main() := File;															
	
END;