set TIMESLOTS; #time
set TIMESLOTS1;
set ORIGIN;
set DESTINATION;
param Flights;
param AIRTIME {i in ORIGIN, j in DESTINATION};
param TICKETCOST {i in ORIGIN, j in DESTINATION};
param TIME;
param S1 {i in ORIGIN};
param S2 {i in ORIGIN};
param S3 {i in ORIGIN};
param S4 {i in ORIGIN};
param S5 {i in ORIGIN};
param S6 {i in ORIGIN};
param S7 {i in ORIGIN};
param E1 {i in DESTINATION};
param E2 {i in DESTINATION};
param E3 {i in DESTINATION};
param E4 {i in DESTINATION};
param E5 {i in DESTINATION};
param E6 {i in DESTINATION};
param E7 {i in DESTINATION};

var x {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #flight for each timeslot

var m1 {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #person's destination at each timeslot
var m2 {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #person's destination at each timeslot
var m3 {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #person's destination at each timeslot
var m4 {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #person's destination at each timeslot
var m5 {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #person's destination at each timeslot
var m6 {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #person's destination at each timeslot
var m7 {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} binary; #person's destination at each timeslot

maximize profit: #number of filled seats*flytime*if flight occured
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} (
	TICKETCOST[i,j]*m1[i,j,t]*E1[j]*x[i,j,t]+TICKETCOST[i,j]*m2[i,j,t]*x[i,j,t]*E2[j]+TICKETCOST[i,j]*m3[i,j,t]*x[i,j,t]*E3[j]
	+TICKETCOST[i,j]*m4[i,j,t]*x[i,j,t]*E4[j]+TICKETCOST[i,j]*m5[i,j,t]*E5[j]*x[i,j,t]+TICKETCOST[i,j]*m7[i,j,t]*x[i,j,t]*E7[j]+
	TICKETCOST[i,j]*m7[i,j,t]*E7[j]*x[i,j,t]-x[i,j,t]);

s.t. origin {j in DESTINATION, t in TIMESLOTS1}: #next flight must leave from previous destinations
	sum {i in ORIGIN} x[i,j,t]*sum{s in ORIGIN,k in DESTINATION} x[s,k,t+1] - sum {k in DESTINATION} x[j,k,t+1] = 0;

s.t. oneflight {t in TIMESLOTS}:
	sum {i in ORIGIN, j in DESTINATION} x[i,j,t] <= 1;

s.t. correctstart1:
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} S1[i]*m1[i,j,t] = sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} m1[i,j,t];
s.t. correctstart2:
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} S2[i]*m2[i,j,t] = sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} m2[i,j,t];
s.t. correctstart3:
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} S3[i]*m3[i,j,t] = sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} m3[i,j,t];
s.t. correctstart4:
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} S4[i]*m4[i,j,t] = sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} m3[i,j,t];
s.t. correctstart5:
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} S5[i]*m5[i,j,t] = sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} m4[i,j,t];
s.t. correctstart6:
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} S6[i]*m6[i,j,t] = sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} m3[i,j,t];
s.t. correctstart7:
	sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} S7[i]*m7[i,j,t] = sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS} m4[i,j,t];
		
s.t. stop1:
	if (sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m1[i,j,t]*E1[j] = 1) then sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m1[i,j,t+1] = 0;
s.t. stop2:
	if (sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m2[i,j,t]*E2[j] = 1) then sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m2[i,j,t+1] = 0;
s.t. stop3:
	if (sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m3[i,j,t]*E3[j] = 1) then sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m3[i,j,t+1] = 0;
s.t. stop4:
	if (sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m4[i,j,t]*E4[j] = 1) then sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m4[i,j,t+1] = 0;
s.t. stop5:
	if (sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m5[i,j,t]*E5[j] = 1) then sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m5[i,j,t+1] = 0;
s.t. stop6:
	if (sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m6[i,j,t]*E6[j] = 1) then sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m6[i,j,t+1] = 0;
s.t. stop7:
	if (sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m7[i,j,t]*E7[j] = 1) then sum {i in ORIGIN, j in DESTINATION, t in TIMESLOTS1} m7[i,j,t+1] = 0;

s.t. avoidlocalopt {t in 1..Flights}:
	sum {i in ORIGIN, j in DESTINATION} x[i,j,t]>= 1;

s.t. setstart:
	sum {j in DESTINATION} x[2,j,1] = 1;
		
s.t. xvar1 {t in TIMESLOTS, i in ORIGIN, j in DESTINATION}:
	m1[i,j,t]*x[i,j,t] = m1[i,j,t];
s.t. xvar2 {t in TIMESLOTS, i in ORIGIN, j in DESTINATION}:
	m2[i,j,t]*x[i,j,t] = m2[i,j,t];
s.t. xvar3 {t in TIMESLOTS, i in ORIGIN, j in DESTINATION}:
	m3[i,j,t]*x[i,j,t] = m3[i,j,t];
s.t. xvar4 {t in TIMESLOTS, i in ORIGIN, j in DESTINATION}:
	m4[i,j,t]*x[i,j,t] = m4[i,j,t];
s.t. xvar5 {t in TIMESLOTS, i in ORIGIN, j in DESTINATION}:
	m5[i,j,t]*x[i,j,t] = m5[i,j,t];
s.t. xvar6 {t in TIMESLOTS, i in ORIGIN, j in DESTINATION}:
	m6[i,j,t]*x[i,j,t] = m6[i,j,t];
s.t. xvar7 {t in TIMESLOTS, i in ORIGIN, j in DESTINATION}:
	m7[i,j,t]*x[i,j,t] = m7[i,j,t];