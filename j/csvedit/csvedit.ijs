NB. csvedit - CSV editor

require 'jzgrid csv'
coclass 'pcsvedit'

TITLE=: 'CSV Editor'

F=: 0 : 0
pc f;
menupop "&File";
menu new "&New" "Ctrl+N" "" "";
menu newwin "New &Window" "Ctrl+Shift+N" "" "";
menu open "&Open ..." "Ctrl+O" "" "";
menusep;
menu save "&Save" "Ctrl+S" "" "";
menu saveas "Save &As ..." "" "" "";
menusep;
menu close "&Close" "" "" "";
menupopz;
menupop "&Edit";
menu insrows "Insert Rows" "" "" "";
menu approws "Append Rows" "" "" "";
menu delrows "Delete Rows" "" "" "";
menusep;
menu inscols "Insert Columns" "" "" "";
menu appcols "Append Columns" "" "" "";
menu delcols "Delete Columns" "" "" "";
menusep;
menu flip "Flip" "" "" "";
menu headers "Edit Headers" "" "" "";
menupopz;
menupop "&View";
menu viewcsv "CSV" "" "" "";
menu viewmat "Viewmat" "" "" "";
menusep;
menu viewplot "Plot" "" "" "";
menupopz;
menupop "&Help";
menu help "&Contents" "F1" "" "";
menu helpuse "&Using Grid" "" "" "";
menusep;
menu helpabout "&About" "" "" "";
menupopz;
sbar 3;
sbarset sthelp 100 "Press F1 for help.";
sbarset stready 50 "Ready";
sbarset stoption 75 "option";
sbarshow;
xywh 0 0 320 240;cc grid isigraph rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)

create=: 3 : 0
  wd F
  MISVAL=: <0
  SEP=: ','
  HEAD=: 0
  grid=: '' conew 'jzgrid'
  new ''
  wd 'pshow;'
)
DIR=: ({.~ i:&PATHSEP_j_) (4!:4 <'create_pcsvedit_'){::4!:3''

destroy=: 3 : 0
  if. check_dirty'' do. ''return. end.
  destroy__grid''
  wd'pclose'
  codestroy ''
)

f_close=: destroy
f_close_button=: destroy

f_newwin_button=: 3 : 0
  ''conew'pcsvedit'
)

f_new_button=: 3 : 0
  if. check_dirty'' do. ''return. end.
  new ''
)

new=: 3 : 0
  CELLDATA=: <"0 *./~0*i.20
  HDRCOL=: 'A'
  HDRROW=: 1
  reset 'Untitled'
)

FILEDLG=: '" "" "" "CSV (*.csv)|*.csv|All Files (*.*)|*.*" '
OPN1=: 'mbopen "Open - '

f_open_button=: 3 : 0
  if. check_dirty'' do. ''return. end.
  if. 0=#fn=. wd OPN1,TITLE,FILEDLG,'ofn_filemustexist' do. ''return. end.
  if. _1-:r=. read fn do. ''return. end.
  'HDRCOL HDRROW CELLDATA'=: r
  CELLDATA=: {.@((>MISVAL)&".)&.> CELLDATA
  reset fn
)

reset=: 3 : 0
  DIRTY=: 0
  show__grid 'CELLDATA HDRCOL HDRROW'
  set_pos''
  set_title y
)

set_title=: 3 : 0
  FNAME=: y
  wd 'pn *',FNAME,(DIRTY#'*'),' - ',TITLE
)

set_pos=: 3 : 0
try.  wd 'set stoption *',M=. ": readmark__grid''
catch. _1 [ smoutput 'Position: ',M end.
)

isnum=: 3 : '(-.0-:0".y) +. (,''0'')-:y'
hassep=: 3 : 'SEP e.y'
remquot=: ('""';'"')&stringreplace

read=: 3 : 0
  if. _1 -: d=. readcsv y do.
    _1 [ wdinfo 'Error reading data' return.
  end.
  if. (2~:#$d) +. (0=*/$d) do.
    _1 [ wdinfo 'Bad data shape' return.
  end.
  d=. remquot &.>d
  if. ''-: tl=. 0 0{::d do.
    (<}.{.d) , (<}.{."1 d) , (<}."1}. d)
  elseif. isnum tl do.
    (<'A') , (<1) , (<d)
  elseif. ([: isnum 1 0{::])^:(1<#) d do.
    (<{.d) , (<1) , (<}.d)
  elseif. ([: isnum 0 1{::])^:(1<{:@$) d do.
    (<'A') , (<{."1 d) , (<}."1 d)
  elseif. do.
    _1 [ wdinfo 'Bad row/column headers'
  end.
)

CHK1=: ' "Save Changes - ',TITLE,'"'
CHK2=: ' "There are changes in',LF,'    '
CHK3=: LF,'Do you want to save it?" mb_iconexclamation mb_yesnocancel'
SAV1=: 'mbsave "Save - '
SAV2=: 'ofn_pathmustexist ofn_overwriteprompt'

check_dirty=: 3 : 0   NB. 1 - cancel
  if. -.DIRTY do. 0 return. end.
  if. 'CANCEL'-:r=. wd 'mb ',CHK1,CHK2,FNAME,CHK3 do. 1 return. end.
  if. 'NO'-:r do. 0 return. end.
  _1-:f_save_button''
)

f_save_button=: 3 : 0
  if. FNAME-:'Untitled' do. f_saveas_button'' return. end.
  save FNAME
)

f_saveas_button=: 3 : 0
  if. 0=#fn=. wd SAV1,TITLE,FILEDLG,SAV2 do. _1 return. end.
  save fn
)

save=: 3 : 0
  end_headers''
  if. _1-:r=. write y do. _1 return. end.
  DIRTY=: 0
  set_title r
  1
)

fmtdata=: 3 : 0
  d=. <"0 CELLDATA__grid
  if. c=. 0<#$HDRCOL__grid do.
    d=. HDRCOL__grid,d end.
  if. 0<#$HDRROW__grid do.
    if. c do.
      d=. ('';HDRROW__grid),.d else.
      d=. HDRROW__grid ,.d end.
  end.
  d
)


fmtcsv=: 3 : 0
  dat=. ,each 8!:2 each y
  f=. (,&',')`('"'&,@(,&'",'))@.hassep@(#~ >:@(=&'"'))
  NB. f=. '"'&,@(,&'",')@(#~ >:@(=&'"'))
  dat=. f each dat
  f=. <@(,&LF)@}:@;
  dat=. ;f"1 dat
)

mywritecsv=: 4 : 0
  dat=. fmtcsv x
  if. _1-: dat fwrites r=. extcsv y do.
    _1 return. end.
  r
)

write=: 3 : 0
  d=. fmtdata''
  if. _1 -: r=. d mywritecsv y do.
    wdinfo 'Error writing CSV' return.
  end.
  r
)

set_dirty=: 3 : 0
  if. -.DIRTY do. set_title FNAME [ DIRTY=: 1 end.
)

grid_gridhandler=: 3 : 0
  res=. 1 NB. typically want to continue processing
  NB.   smoutput y
  NB.   smoutput (] ,: ".@(,&'__grid')&.>);:'Px Py Row Col Ctrl Shift'
  select. y
  case. 'change' do.
    set_dirty''
  case. 'mark' do.
    set_pos''
  case. 'click' do.
    'r c'=. <:$CELLDATA__grid
    M=. ''
    if. Row__grid<0 do. M=. r,Col__grid,0,Col__grid end.
    if. Col__grid<0 do. M=. Row__grid,c,Row__grid,0 end.
    if. (Row__grid<0)*.(Col__grid<0) do. M=. '' end.
    if. #M do. res=. 0 [ show__grid '' [writemark__grid M end.
  end.
  res
)


f_insrows_button=: 3 : 0
  if. check_headers'' do. _1 return. end.
  if. _1-:set_select'' do. _1 return. end.
  if. sysevent-:'f_approws_button' do. r1=. r1+rn-1
  else. r1=. r1 - 1 end.
  tn=. #CELLDATA
  if. r1=_1 do. CELLDATA=: (-tn+rn){.!.MISVAL CELLDATA
  else. CELLDATA=: ((1 j. rn) r1}tn#1)#!.MISVAL CELLDATA end.
  if. 0<#$HDRROW do.
    if. r1=_1 do. HDRROW=: (-tn+rn){.HDRROW
    else. HDRROW=: ((1 j. rn) r1}tn#1)#HDRROW end.
  end.
  update''
)
f_approws_button=: f_insrows_button

f_inscols_button=: 3 : 0
  if. check_headers'' do. _1 return. end.
  if. _1-:set_select'' do. _1 return. end.
  if. sysevent-:'f_appcols_button' do. c1=. c1+cn-1
  else. c1=. c1 - 1 end.
  tn=. {:$CELLDATA
  if. c1=_1 do. CELLDATA=: (-tn+cn)({.!.MISVAL)"1 CELLDATA
  else. CELLDATA=: ((1 j. cn) c1}tn#1)(#!.MISVAL)"1 CELLDATA end.
  if. 0<#$HDRCOL do.
    if. c1=_1 do. HDRCOL=: (-tn+cn){.HDRCOL
    else. HDRCOL=: ((1 j. cn) c1}tn#1)#HDRCOL end.
  end.
  update''
)
f_appcols_button=: f_inscols_button

f_delrows_button=: 3 : 0
  if. check_headers'' do. _1 return. end.
  if. _1-:set_select'' do. _1 return. end.
  tn=. #CELLDATA
  if. tn<:rn do. wdinfo 'Cannot delete all rows' return. end.
  CELLDATA=: (-.(i.tn) e. r1+i.rn)#CELLDATA
  if. 0<#$HDRROW do.
    HDRROW=: (-.(i.tn) e. r1+i.rn)#HDRROW
  end.
  update''
)

f_delcols_button=: 3 : 0
  if. check_headers'' do. _1 return. end.
  if. _1-:set_select'' do. _1 return. end.
  tn=. {:$CELLDATA
  if. tn<:cn do. wdinfo 'Cannot delete all columns' return. end.
  CELLDATA=: (-.(i.tn) e. c1+i.cn)#"1 CELLDATA
  if. 0<#$HDRCOL do.
    HDRCOL=: (-.(i.tn) e. c1+i.cn)#HDRCOL
  end.
  update''
)


set_select=: 3 : 0
  CELLDATA=: CELLDATA__grid
  if. 0=#M=. readmark__grid'' do. _1[wdinfo'Nothing selected' return. end.
  'r1 c1 r2 c2'=: 4$M
  'r1 r2'=: r1 (<. , >.) r2
  'c1 c2'=: c1 (<. , >.) c2
  rn=: 1 + r2-r1
  cn=: 1 + c2-c1
)

update=: 3 : 0
  show__grid 'CELLDATA HDRCOL HDRROW'
  set_dirty''
)

f_flip_button=: 3 : 0
  end_headers''
  M=. readmark__grid''
  CELLDATA=: |:CELLDATA__grid
  HDRCOL=: HDRROW__grid
  HDRROW=: HDRCOL__grid
  writemark__grid |.M
  update''
)

check_headers=: 3 : 0
  wdinfo^:HEAD 'Operation not allowed in Edit Headers mode.'
  HEAD
)

end_headers=: 3 : 0
  if. HEAD do. f_headers_button'' end.
)

f_headers_button=: 3 : 0
  HEAD=: -.HEAD
  wd'set headers ',":HEAD
  M=. readmark__grid''
  if. HEAD do.
    c=. ":&.>gethdrcol__grid HDRCOL__grid
    r=. '';":&.>gethdrrow__grid HDRROW__grid
    d=. r,.c,CELLDATA__grid
    CELLDATA=: d
    HDRCOL=: ''
    HDRROW=: ''
  else.
    CELLDATA=: }.}."1 CELLDATA__grid
    HDRCOL=: ":&.>}.{.CELLDATA__grid
    HDRROW=: ":&.>}.{."1 CELLDATA__grid
  end.
  writemark__grid 0>.M+<:HEAD*2
  update''
)

f_viewcsv_button=: 3 : 0
  require 'jview'
  ('Preview - ',TITLE) wdview FNAME;fmtcsv fmtdata''
)

f_viewmat_button=: 3 : 0
  require 'viewmat'
  viewmat >CELLDATA__grid
)

f_viewplot_button=: 3 : 0
  require 'plot'
  plot >CELLDATA__grid
)

f_help_button=: 3 : 0
  require jpath '~system\extras\util\browser.ijs'
  if. sysevent-:'f_helpuse_button' do.
    p=. jpath '~system\extras\help\user\grid_actions.htm'
  else.
    p=. DIR,PATHSEP_j_,'help.html'
  end.
  launch_jbrowser_ p
)
f_helpuse_button=: f_help_button

f_helpabout_button=: 3 : 0
  t=. 'Comma Separated Value',LF,'Grid Editor',LF,LF
  wdinfo ('About ',TITLE);t,'(C) 2006 Oleg Kobchenko'
)


f_octrl_fkey=: f_open_button
f_nctrl_fkey=: f_new_button
f_sctrl_fkey=: f_save_button
f_nctrlshift_fkey=: f_newwin_button
f_f1_fkey=: f_help_button

f_newwin_button''

