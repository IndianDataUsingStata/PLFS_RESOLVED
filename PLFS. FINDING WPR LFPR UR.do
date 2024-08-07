 infile using "E:\PLFS All Rounds\2017-18\Infile Command Dictionary Files\PLFS HH V1.dct"
 {
 egen HHID=concat(var13 var14 var15 var16) 
 sort HHID 
 order HHID
 isid HHID
 save "E:\PLFS All Rounds\2017-18\PLFS HHV1 2017.dta"
 clear
 }
 infile using "E:\PLFS All Rounds\2017-18\Infile Command Dictionary Files\PLFS Person V1.dct"
  {
  egen HHID=concat(perv13 perv14 perv15 perv16) 
  sort HHID 
  order HHID 
  egen PID=concat(HHID perv17)
  sort HHID PID
  order HHID PID
  isid PID
  save "E:\PLFS All Rounds\2017-18\PLFS PERV1 2017.dta" 
  }
 {
   merge m:1 HHID using "E:\PLFS All Rounds\2017-18\PLFS HHV1 2017.dta"
   keep if _merge==3
   drop _merge  
   destring UPS USS Whether_Sub, replace
   gen upss=UPS
   replace upss=USS if UPS>51 & Whether_Sub==1 & USS>=11 & USS<=51 
   ta upss 
   destring NSS NSC MULT NoQtr, replace 
   gen weight=MULT/NoQtr
   gen wei= weight/100
   replace wei=weight/200 if NSS!=NSC
   gen wt=round(wei,1) 
   destring perv5, gen (Sector)
   bysort Sector: ta upss [weight=wt]
}   
