** Create Ref Tables ** ;

/* 1. Create a Fees Table*/
Data Fees;
	Attrib Fee_ID    Length=$10 Format=$10.
	       Asat_Date Length=8   Format=YYMMDD10.
		   Desc      Length=$20 Format=$20.
		   Fee_Amt   Length=8   Format=Dollar.2
	;
	Input Fee_ID    : $10.
	      Asat_Date : YYMMDD10.
		  Desc      : $20.
		  Fee_Amt   : Dollar.2
		  ;
	Infile Cards Firstobs=2 truncover dsd dlm=',';
	Cards;
Fee_ID,Fee_asatdate,Fee Description,Fee_Amount
1,2014/01/01,Admin Fee,$3.50
1,2014/03/01,Admin Fee,$4.00
1,2014/05/01,Admin Fee,$5.25
2,2014/01/01,Disbursements,$1.00
2,2014/04/01,Disbursements,$1.25
3,2014/01/01,Legal Fee,$0.50
3,2014/04/06,Legal Fee,$1.00
3,2014/06/01,Legal Fee,$0.75
4,2014/01/01,Account Open Flat Fee,$5.00
5,2014/01/01,Account Closure Flat Fee,$3.00
6,2014/01/01,Stamps,$1.50
6,2014/04/05,Stamps,$1.75
6,2014/05/01,Stamps,$2.00
7,2014/01/01,Postage,$2.00
7,2014/05/18,Postage,$2.15
8,2014/01/01,Handover Fee,$0.40
8,2014/05/01,Handover Fee,$0.45
8,2014/06/01,Handover Fee,$1.00
8,2014/07/01,Handover Fee,$1.15
8,2014/09/01,Handover Fee,$1.20
8,2014/10/01,Handover Fee,$1.25
9,2014/01/01,Call Fee,$4.00
9,2014/04/11,Call Fee,$5.00
9,2014/05/06,Call Fee,$6.00
;
Run;

/* 2. Create Activity-Fee Map table */
Data Activity_Fee_Map;
	Attrib Activity_ID Length=$10 Format=$10.
		   Desc        Length=$20 Format=$20.
		   Fee_ID      Length=8   Format=8.
	;
	Input Activity_ID : $10.
		  Desc        : $20.
		  Fee_ID      : 8.
		  ;
	Infile Cards Firstobs=2 truncover dsd dlm=',';
	Cards;
Activity_ID,Activity Description,Fee_ID
1,Letter,1
1,Letter,2
1,Letter,3
1,Letter,6
1,Letter,7
2,Phone - Call,1
2,Phone - Call,2
2,Phone - Call,3
2,Phone - Call,9
3,Phone - Receive,1
3,Phone - Receive,2
3,Phone - Receive,3
4,Account Open,4
5,Account Close,5
;
Run;







