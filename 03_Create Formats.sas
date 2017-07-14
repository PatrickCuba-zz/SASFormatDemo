** Create Formats ** ;
** Fees ** ;
Data Fmt;
	Keep Start Label End HLO FMTName;

	Length Start End $20. Start_Date RFee_Amt End_Date Label 8.;
	Set Fees End=EOF;
	By Fee_ID;
	Retain Start_Date RFee_Amt;

	Fmtname='$Fee';

	** Build Fee Start String ;
	If First.Fee_ID Then Do;
		Start_Date=Asat_Date;
		RFee_Amt=Fee_Amt;
	End;
	Else Do;
		End_Date=Asat_Date-1;
		Link BuildFmt;
		Output;
		Start_Date=Asat_Date;
		RFee_Amt=Fee_Amt;
	End;
	If Last.Fee_ID Then Do;
		End_Date='31Dec9999'd;
		Link BuildFmt;
		Output;
	End;

	If EOF Then Do;
		HLO='O';
		Start='';
		Label=0;
		Output;
	End;

	Return;

BuildFmt:
	Start=Cat(Put(Fee_ID*1, Z3.), "-", 
              Put(Start_Date,Z7.));
	End=Cat(Put(Fee_ID*1, Z3.), "-", 
              Put(End_Date,Z7.));

	Label=RFee_Amt;

	Return;

    Format End_date Start_Date yymmdd10.;
Run;

Proc Format Cntlin=Fmt;
Run;
** Fee Description ** ;
Data Fmt;
	Keep Start Label FMTName;
	Set Fees ;
	By Fee_ID;
	If First.Fee_ID;

	Retain Fmtname 'FeeDesc';
	Start=input(Fee_id, 8.);
	Label=Desc;
Run;
Proc Format Cntlin=Fmt;
Run;

** Activity-Fees Mapping** ;
options cmplib=work.funcs;

Proc FCMP outlib=work.funcs.Act_Map;
   function Act_Map(Activity_ID, Fee_ID) $ 20;
   length x $20;
   x=Cat("A",Put(Activity_ID,Z3.),"-",Put(Fee_ID,z3.));
   return (x);
   endsub;
Run;

Data Fmt;
	Keep Start Label FMTName;

	Length Start Label $20.;
	Set Activity_Fee_Map ;
	By Activity_ID;
	Retain Start ;

	FmtName='$ACTFEE';

	** Build Activity Tree ;
	If First.Activity_ID Then Do;
		Start=Cat("A",Put(Input(Activity_ID, 8.),Z3.));
		Label=Act_Map(Activity_ID, Fee_ID);
		Output;
		Start=Act_Map(Activity_ID, Fee_ID);
	End;
	Else Do;
		Label=Act_Map(Activity_ID, Fee_ID);
		Output;
		Start=Act_Map(Activity_ID, Fee_ID);
	End;
	If Last.Activity_ID Then Do;
		Label="Activity-End";
		Output;
	End;
Run;

Proc Format Cntlin=Fmt;
Run;

** Check our format ;
Proc Format Cntlout=Fee_Fmt(Keep=Start Label Fmtname Type HLO);
Run;
