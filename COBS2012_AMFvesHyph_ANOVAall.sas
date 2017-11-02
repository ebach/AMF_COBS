options pageno=1 linesize=80;
goptions reset=all;
title 'AMF vesicle vs. hyphae for COBS 2012';
data COBS_2012;
	input sample $ month $ crop $ block $ AMF Ves Hyph;
	AMFtran=AMF;
	VesTran=Ves;
	HyphTran=Hyph;
	datalines;
CC12	May	Corn	1	33.33333333	2.777777778	33.33333333
CC21	May	Corn	2	34.14634146	4.87804878	31.70731707
CC35	May	Corn	3	48.71794872	10.25641026	41.02564103
CC43	May	Corn	4	61.11111111	5.555555556	61.11111111
CC12	July	Corn	1	82	9	81
CC21	July	Corn	2	74	18	72
CC35	July	Corn	3	56	14	54
CC43	July	Corn	4	77	14	74
CC12	August	Corn	1	88.20588235	11.05882353	87.02941176
CC21	August	Corn	2	86.5	10	86.5
CC35	August	Corn	3	82.5	13.5	81
CC43	August	Corn	4	89.5	13.5	89
CC12	September	Corn	1	78.5	11.5	76.5
CC21	September	Corn	2	79	14.5	76
CC35	September	Corn	3	91	23	87
CC43	September	Corn	4	87.5	20.5	84
CC12	October	Corn	1	78.26086957	10.86956522	71.73913043
CC21	October	Corn	2	77.08333333	21.83333333	76.08333333
CC35	October	Corn	3	82.41758242	16.48351648	65.93406593
CC43	October	Corn	4	87.5	14.375	78.75
P13	May	Prairie	1	5.034446211	3.68309486	1.351351351
P24	May	Prairie	2	9.803921569	7.843137255	1.960784314
P31	May	Prairie	3	5.252659574	3.690159574	1.5625
P46	May	Prairie	4	28.61267606	25.9084507	4.908450704
P13	July	Prairie	1	83	77	11
P24	July	Prairie	2	89	86	12
P31	July	Prairie	3	42	41	5
P46	July	Prairie	4	42	41.5	2.5
P13	August	Prairie	1	65.5	59	17.5
P24	August	Prairie	2	64	56.5	20.5
P31	August	Prairie	3	68.5	56	27
P46	August	Prairie	4	67	63.5	14.5
P13	September	Prairie	1	52.5	50	17
P24	September	Prairie	2	47	46	12.5
P31	September	Prairie	3	51.5	48	18.5
P46	September	Prairie	4	52	51	13
P13	October	Prairie	1	45.5	36.5	9
P24	October	Prairie	2	33.5	27	9.5
P31	October	Prairie	3	37.5	35.5	6
P46	October	Prairie	4	43	37.5	5.5
PF15	May	PrairieFert	1	10.04545455	3.818181818	7.727272727
PF23	May	PrairieFert	2	31.91489362	23.40425532	10.63829787
PF32	May	PrairieFert	3	55.10835913	33.81062951	35.73271414
PF41	May	PrairieFert	4	22.10377358	16.27358491	11.66037736
PF15	July	PrairieFert	1	81	64	39
PF23	July	PrairieFert	2	43.5	39.5	8.5
PF32	July	PrairieFert	3	48	45	11
PF41	July	PrairieFert	4	48.5	40.5	13.5
PF15	August	PrairieFert	1	50.5	37.5	25
PF23	August	PrairieFert	2	63	44	32.5
PF32	August	PrairieFert	3	64.5	54	22
PF41	August	PrairieFert	4	63	49	28
PF15	September	PrairieFert	1	53	48	15.5
PF23	September	PrairieFert	2	55.5	52.5	16
PF32	September	PrairieFert	3	58.5	50	23
PF41	September	PrairieFert	4	56.5	54	19
PF15	October	PrairieFert	1	68	50	18
PF23	October	PrairieFert	2	55	46	9
PF32	October	PrairieFert	3	36	35	4
PF41	October	PrairieFert	4	60	45	18
run;
* Print data set;
proc print data=COBS_2012;
run;
* Plot means, standard errors, and observations;
proc gplot data=COBS_2012;
	plot AMFtran*crop=block;
	symbol1 i=std1mjt v=star;
run;
* Two-way mixed model anova w/o replication;
proc mixed data=COBS_2012;
	class block crop month;
	model AMFtran = crop|month / ddfm=kr outp=resids;
	random block block*crop;
	lsmeans crop|month / pdiff=all adjust=tukey;
run;
goptions reset=all;
title "Diagnostic plots to check anova assumptions";
* Plot residuals vs. predicted values;
proc gplot data=resids;
	plot resid*pred;
run;
* Normal quantile plot of residuals;
proc univariate noprint data=resids;
	qqplot resid / normal;
run;
proc mixed data=COBS_2012;
	class block crop month;
	model VesTran = crop|month / ddfm=kr outp=resids;
	random block block*crop;
	lsmeans crop|month / pdiff=all adjust=tukey;
run;
goptions reset=all;
title "Diagnostic plots to check anova assumptions";
* Plot residuals vs. predicted values;
proc gplot data=resids;
	plot resid*pred;
run;
* Normal quantile plot of residuals;
proc univariate noprint data=resids;
	qqplot resid / normal;
run;
proc mixed data=COBS_2012;
	class block crop month;
	model HyphTran = crop|month / ddfm=kr outp=resids;
	random block block*crop;
	lsmeans crop|month / pdiff=all adjust=tukey;
run;
goptions reset=all;
title "Diagnostic plots to check anova assumptions";
* Plot residuals vs. predicted values;
proc gplot data=resids;
	plot resid*pred;
run;
* Normal quantile plot of residuals;
proc univariate noprint data=resids;
	qqplot resid / normal;
run;
quit;