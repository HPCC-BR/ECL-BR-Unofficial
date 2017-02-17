// PROJECT - EXAMPLE

IMPORT $;

EXPORT Project_Pay := MODULE
	
	PmtStatusRec := RECORD
		$.OrdersTR.File;
		STRING PmtStatus := '';
	END;
	
	PayeesList := ['Francisco','Lucas','Fabio'];
	
	PmtStatusTb := TABLE($.OrdersTR.File,PmtStatusRec);
	
	PmtStatusRec UpdPmtStatus (PmtStatusTb L) := TRANSFORM
		SELF.PmtStatus := IF(L.Nome IN PayeesList, 'Pago', 'Pendente');
		SELF := L;
	END;
		
	EXPORT PmtStatus := PROJECT(PmtStatusTb,UpdPmtStatus(LEFT));
		
END;