// ITERATE - EXAMPLE

IMPORT $;

EXPORT RunningSum := MODULE
	
	RunSumRec := RECORD
		$.OrdersTR.File;
		DECIMAL10_2 RunTotal := 0;
	END;
	
	RunSumTb := TABLE($.OrdersTR.File,RunSumRec);
	
	RunSumRec CalcRunSum (RunSumTb L, RunSumTb R) := TRANSFORM
		SELF.RunTotal := IF(L.Nome = R.Nome AND L.Sobrenome = R.Sobrenome, L.RunTotal + R.Total, R.Total);
		SELF := R;
	END;
		
	EXPORT RunSum := ITERATE(RunSumTb,CalcRunSum(LEFT,RIGHT));
		
END;