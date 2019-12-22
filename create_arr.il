;;;########################################################
;;;#
;;;#  Skill code for generating an M-by-N memory array 
;;;#  from a unit memory cell layout
;;;#
;;;#  Step 1: Load the skill file in Cadence CIW window
;;;#          load "create_arr.il"
;;;#  Step 2: Run skill code. 
;;;#          create_arr("libname" "cellname" 128 128) 
;;;#  Step 3: Array layout "My_array" generated in same library
;;;#
;;;#########################################################

procedure(create_arr(lib cellview M N)
	;prog(bBox,ur,ll,urx,ury,llx,lly,dx,dy,cv,cvi)
	; Open cellview to write
	cv = dbOpenCellViewByType(lib "My_array" "layout" "maskLayout" "w")
	;printf("\n%s opened" cellview)

	;open the layout of inveter to be used
	cvi = dbOpenCellViewByType(lib cellview "layout")



; use bbox to get the dimensions 
; prBoundary is now BOUNDARY in the 2018 ASAP 7nm PDK
prb=setof(m cvi~>shapes m~>lpp==list("BOUNDARY" "drawing"))
	prb=prb~>bBox
        prb=car(prb)
        
ur=upperRight(prb)
ll=lowerLeft(prb)
urx=xCoord(ur)
ury=yCoord(ur)
llx=xCoord(ll)
lly=yCoord(ll)

;dx is the width of the cell and dy is the height of the cell
dx=urx-llx;
dy=ury-lly;

;creating the MxN array with alternate rows reversed to share common vdd and ground
for(row 0 M
for(column 0 N
 
  dbCreateInst( cv cvi "" list(column*dx row*dy) "R0")


)
)
dbClose(cvi)
	dbSave(cv)
	dbClose(cv)
)


