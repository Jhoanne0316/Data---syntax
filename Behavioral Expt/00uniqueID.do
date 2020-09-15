/*UNIQUE ID*/

tostring session hh round new_vks, generate(ses hh2 rnd new_vks2)

replace ses="02" if ses=="2"
replace ses="03" if ses=="3"
replace ses="04" if ses=="4"
replace ses="05" if ses=="5"
replace ses="06" if ses=="6"
replace ses="07" if ses=="7"
replace ses="08" if ses=="8"
replace ses="09" if ses=="9"
tab ses

replace hh2="01" if hh2=="1"
replace hh2="02" if hh2=="2"
replace hh2="03" if hh2=="3"
replace hh2="04" if hh2=="4"
replace hh2="05" if hh2=="5"
replace hh2="06" if hh2=="6"
replace hh2="07" if hh2=="7"
replace hh2="08" if hh2=="8"
replace hh2="09" if hh2=="9"
tab hh2

replace rnd="01" if rnd=="1"
replace rnd="02" if rnd=="2"
replace rnd="03" if rnd=="3"
tab rnd

gen uniqueID=ses+hh2+rnd+new_vks2
