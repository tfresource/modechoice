* Create alternative specific constants 

 if (altnum = 2) Sh2Cnst = 1 .
 if (altnum = 3) Sh3Cnst = 1 .
 if (altnum = 4) TrnCnst = 1 .
 if (altnum = 5) BikCnst = 1 .
 if (altnum = 6) WlkCnst = 1 .


* Income as an alternative specific variable

if (altnum = 2) IncSh2 = HHInc .
if (altnum = 3) IncSh3 = HHInc .
if (altnum = 4) IncTrn = HHInc .
if (altnum = 5) IncBik = HHInc .
if (altnum = 6) IncWlk = HHInc .


* Create Alternative Travel Time Variables
* M = Mot = motorized modes
* NM = non-motorized moded
* Cns = constrained

if (altnum < 5) MOvtbyDs = Ovtt/Dist .
if (altnum > 4) NM_Tvtt = Tvtt .

if (altnum < 5) Mot_Tvtt = Tvtt .
if (altnum < 5) Mot_Ivtt = Ivtt .
if (altnum < 5) Mot_Ovtt = Ovtt .
if (altnum < 5) CnsTvtt1 = Ivtt + 2.5*Ovtt .
if (altnum < 5) CnsTvtt2 = Ivtt + 4.0*Ovtt .


* Create Alternative Specific Automobile Ownership Variables

if (altnum = 2) NmVehSh2 = NumVeh .
if (altnum = 3) NmVehSh3 = NumVeh .
if (altnum = 4) NmVehTrn = NumVeh .
if (altnum = 5) NmVehBik = NumVeh .
if (altnum = 6) NmVehWlk = NumVeh .


if (altnum = 2) VehWkSh2 = VehbyWrk .
if (altnum = 3) VehWkSh3 = VehbyWrk .
if (altnum = 4) VehWkTrn = VehbyWrk .
if (altnum = 5) VehWkBik = VehbyWrk .
if (altnum = 6) VehWkWlk = VehbyWrk .

if (altnum = 2 | altnum = 3) VehWkShr = VehbyWrk .

if (altnum = 2) VehAdSh2 = NumVeh/NumAdlt .
if (altnum = 3) VehAdSh3 = NumVeh/NumAdlt .
if (altnum = 4) VehAdTrn = NumVeh/NumAdlt .
if (altnum = 5) VehAdBik = NumVeh/NumAdlt .
if (altnum = 6) VehAdWlk = NumVeh/NumAdlt .

if (altnum=2 | altnum=3) VehAdShr=NumVeh/NumAdlt .


* Alternative Specific CBD Dummy Variables

if ((WkCCBD = 1 | WkNCCBD = 1) & altnum = 2) CBDDmSh2 = 1 .
if ((WkCCBD = 1 | WkNCCBD = 1) & altnum = 3) CBDDmSh3 = 1 .
if ((WkCCBD = 1 | WkNCCBD = 1) & altnum = 4) CBDDmTrn = 1 .
if ((WkCCBD = 1 | WkNCCBD = 1) & altnum = 5) CBDDmBik = 1 .
if ((WkCCBD = 1 | WkNCCBD = 1) & altnum = 6) CBDDmWlk = 1 .


* Alternative Specific Employment Density Variable

if (altnum = 2) EmDenSh2 = WkEmpDen .
if (altnum = 3) EmDenSh3 = WkEmpDen .
if (altnum = 4) EmDenTrn = WkEmpDen .
if (altnum = 5) EmDenBik = WkEmpDen .
if (altnum = 6) EmDenWlk = WkEmpDen .

* Travel Cost by Income
CstbyInc = Cost/HHInc .

RECODE
  sh2cnst sh3cnst trncnst bikcnst wlkcnst incsh2 incsh3 inctrn incbik incwlk
  movtbyds nm_tvtt mot_tvtt mot_ivtt mot_ovtt cnstvtt1 cnstvtt2 nmvehsh2
  nmvehsh3 nmvehtrn nmvehbik nmvehwlk vehwksh2 vehwksh3 vehwktrn vehwkbik
  vehwkwlk vehwkshr vehadsh2 vehadsh3 vehadtrn vehadbik vehadwlk vehadshr
  cbddmsh2 cbddmsh3 cbddmtrn cbddmbik cbddmwlk emdensh2 emdensh3 emdentrn
  emdenbik emdenwlk  (SYSMIS=0)  .
EXECUTE .
