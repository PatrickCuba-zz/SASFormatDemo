** Use Formats to apply fees by record ** ;
Data Account_fees;
	Keep Accno Activity_ID Asat_Date Fees;
	Length Fee_Total $50.;
	Set Account_Activities;

	Iter=0;
	Fees=0;

	Do Until(Put(Fee_total, $ACTFEE.)='Activity-End');
	*** 1. Loop for each activity                       *** ;
		Iter+1;
		If Iter=1 then Fee_total=Put(Cat("A",Put(Activity_ID, z3.)), $ACTFEE.);
		Else Fee_total=Put(Fee_total, $ACTFEE.);
	*** 2. Apply correct fee per actiovity for the date *** ;
		FeePrt=Cat(Strip(Scan(Fee_total,-1,'-')),"-",Put(Asat_Date, z7.));
		FeeAmt=Put(FeePrt, $Fee.);
		Fees=Sum(Fees, FeeAmt);

		*** For testing and breakdown of fees uncomment the following code *** ;
/*		Fee_Desc=Put(Scan(FeePrt,1,'-')+0, FeeDesc.);*/
/*		Output;*/
		*** And comment out the keep statement *** ;

	End;
Run;
