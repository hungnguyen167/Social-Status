global allvarspp "hid age grossnet pwgt"
global allvarshh "hid dhi nhhmem"
  
  
*** In this version we use just 14 countries, just LIS and no OECD data:
*** But for those we have microdata and can calculate detailed income measures (by decile, e.g.)

#delimit ;
global dtasets "au81 au85 au89 au95 au01 au03 au04 au08 au10 au14" ;    

*global dtasets "au81 au85 au89 au95 au01 au03 au04 au08 au10 au14      
   at87 at94 at95 at97 at00 at04 at07 at10 at13 at16    
   be85 be88 be92 be95 be97 be00 be03 be04 be05 be06 be07 be08 be09 be10 be11 be12 be13 be14 be15 be16 be17
   ca75 ca81 ca87 ca91 ca94 ca97 ca98 ca00 ca04 ca07 ca10 ca12 ca13 ca14 ca15 ca16 ca17    
   dk87 dk92 dk95 dk00 dk04 dk07 dk10 dk13 dk16     
   fi87 fi91 fi95 fi00 fi04 fi07 fi10 fi13 fi16     
   de73 de78 de81 de84 de87 de89 de91 de94 de95 de98 de00 de01 de02 de03 de04 de05 de06 de07 de08 de09 de10 de11 de12 de13 de14 de15 de16   
   ie87 ie94 ie95 ie96 ie00 ie02 ie03 ie04 ie05 ie06 ie07 ie08 ie09 ie10 ie11 ie12 ie13 ie14 ie15 ie16 ie17     
   it86 it87 it89 it91 it93 it95 it98 it00 it04 it08 it10 it14 it16 
   nl83 nl87 nl90 nl93 nl99 nl04 nl07 nl10 nl13    
   no79 no86 no91 no95 no00 no04 no07 no10 no13 no16    
   es80 es85 es90 es95 es00 es04 es07 es10 es13 es16     
   uk74 uk79 uk86 uk91 uk94 uk95 uk96 uk97 uk98 uk99 uk00 uk01 uk02 uk03 uk04 uk05 uk06 uk07 uk08 uk09 uk10 uk11 uk12 uk13 uk14 uk15 uk16 uk17 uk18   
   us74 us79 us86 us91 us92 us93 us94 us95 us96 us97 us98 us99 us00 us01 us02 us03 us04 us05 us06 us07 us08 us09 us10 us11 us12 us13 us14 us15 us16 us17 us18" ; 
#delimit cr 
* DE83 deleted, because age range only goes until 65.
 
qui foreach ccyy in $dtasets {  
	use $allvarspp using $`ccyy'p, clear
		merge m:1 hid using $`ccyy'h, keepusing($allvarshh)
		drop if pwgt == . | pwgt <= 0 | dhi == . | dhi <= 0 
		gen eqdhi = dhi / sqrt(nhhmem)

* Income estimates:
	* Average income:
	su eqdhi [aw=pwgt]
		local eqdhi_avg = round(r(mean))
	* Average income by decile:
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, 0, r(r1))
		local eqdhi_d1 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r1), r(r2))
		local eqdhi_d2 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r2), r(r3))
		local eqdhi_d3 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r3), r(r4))
		local eqdhi_d4 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r4), r(r5))
		local eqdhi_d5 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r5), r(r6))
		local eqdhi_d6 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r6), r(r7))
		local eqdhi_d7 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r7), r(r8))
		local eqdhi_d8 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r8), r(r9))
		local eqdhi_d9 = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if eqdhi > r(r9) & eqdhi != .
		local eqdhi_d10 = round(r(mean))		
	
	keep if inrange(age, 18, 65)
	* Working-age income:
	su eqdhi [aw=pwgt]
		local eqdhi_avg_wa = round(r(mean))
	* Average income by decile:
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, 0, r(r1))
		local eqdhi_d1_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r1), r(r2))
		local eqdhi_d2_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r2), r(r3))
		local eqdhi_d3_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r3), r(r4))
		local eqdhi_d4_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r4), r(r5))
		local eqdhi_d5_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r5), r(r6))
		local eqdhi_d6_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r6), r(r7))
		local eqdhi_d7_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r7), r(r8))
		local eqdhi_d8_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if inrange(eqdhi, r(r8), r(r9))
		local eqdhi_d9_wa = round(r(mean))		
	_pctile eqdhi [aw=pwgt], nq(10)
	su eqdhi [aw=pwgt] if eqdhi > r(r9) & eqdhi != .
		local eqdhi_d10_wa = round(r(mean))		
	
	
* Output:		
	if "`ccyy'" == "au81" noisily di "dataset1,eqdhi_avg,eqdhi_d1,eqdhi_d2,eqdhi_d3,eqdhi_d4,eqdhi_d5,eqdhi_d6,eqdhi_d7,eqdhi_d8,eqdhi_d9,eqdhi_d10,eqdhi_avg_wa,eqdhi_d1_wa,eqdhi_d2_wa,eqdhi_d3_wa,eqdhi_d4_wa,eqdhi_d5_wa,eqdhi_d6_wa,eqdhi_d7_wa,eqdhi_d8_wa,eqdhi_d9_wa,eqdhi_d10_wa" 
	noisily di "`ccyy'," `eqdhi_avg' "," `eqdhi_d1' "," `eqdhi_d2' "," `eqdhi_d3' "," `eqdhi_d4' "," `eqdhi_d5' "," `eqdhi_d6' "," `eqdhi_d7' "," `eqdhi_d8' "," `eqdhi_d9' "," `eqdhi_d10' ","  `eqdhi_avg_wa' "," `eqdhi_d1_wa' "," `eqdhi_d2_wa' "," `eqdhi_d3_wa' "," `eqdhi_d4_wa' "," `eqdhi_d5_wa' "," `eqdhi_d6_wa' "," `eqdhi_d7_wa' "," `eqdhi_d8_wa' "," `eqdhi_d9_wa' "," `eqdhi_d10_wa'
	
}
