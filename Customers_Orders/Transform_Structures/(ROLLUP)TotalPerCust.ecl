// ROLLUP - EXAMPLE

IMPORT $;

EXPORT TotalPerCust := MODULE

	InRec := RECORD
		$.OrdersTR.File;
		DECIMAL11_2 TotalSum := 0;
	END;
	
	InTb := TABLE($.OrdersTR.File,InRec);
	
	InTb CalcTotCust (InRec L, InRec R) := TRANSFORM
	
		SELF.TotalSum := R.Total + IF (L.TotalSum = 0, L.Total, L.TotalSum);
		SELF := L;
		
	END;
		
	TotSumCust := ROLLUP(InTb,LEFT.Nome = RIGHT.Nome AND LEFT.Sobrenome = RIGHT.Sobrenome,CalcTotCust(LEFT,RIGHT));
	
	EXPORT FinalSet := TABLE(TotSumCust,{STRING Nome := TotSumCust.Nome, 
																			 STRING Sobrenome := TotSumCust.Sobrenome,  
																			 DECIMAL11_2 TotalSum := TotSumCust.TotalSum});
		
END;