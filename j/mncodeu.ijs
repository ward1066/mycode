{{{
NB. Convert primitives to names.

NB. Not in final form. Just putting on Wiki for testing.

NB. Unicode display of idioms added.

0 : 0
Assigning names to primitives is accomplished by converting
the statement into a form that will show how each primitive
is used. For verbs there are only two choices for a name -
monadic or dyadic. The choice is by syntax only, with the
exception of Cap "[:". It is the same for any verb. The
valence of a verb can be determined by replacing the verb
with one that reports its valence when it is executed.

Some verbs have more than just monadic or dyadic names. For
example, dyadic "+." is either "Or" or "GCD" depending on
whether its arguments are boolean or not.

Adverbs and conjunctions present additional problems. Verbs
are executed under their control. And whether the verb is
executed monadically or dyadically varies with the adverb or
conjunction. In addition, they may take on arguments that are
not simple verbs. The possible names that adverbs and
conjunctions may take on are more that simply monadic or
dyadic.

It is not too difficult to determine how a primitive is used.
The problem is how to detemine the proper name out of all the
possible names that a primitive may take on. This his code
only handles valence but provides a hook to allow for
defining special processing routines for specific primitives.

Right now the names to be used for primitives are built from
the file '~system\packages\misc\primitiv.ijs'. This file is a
good starting point for the names as it is reasonably
consistant in its pattern for assigning names. Another
advantage in using it is that loading the file makes the
converted statements executable. This file includes no idioms

First, the statement is broken into tokens and then each
defined primitive is replaced with its ambivalent name.

A token falls into one of three types - a primitive defined
in symbols (primitives defined in file), a defined name or
constant, and an undefined name. A forth type, primitive not
defined in symbols, should not happen, but is possible if a
new primitive is added to J but file has not been updated to
reflect that. A token which is of the form of a primitive but
not defined in J will cause an error in attempting to analyze
the statement. This will result in the converted statement
containing some primitives left with ambivalent names and
with the undefined primitive unconverted.

If a primitive appears in the file then it is executed by
name, not by primitive. Therefore, if a primitive unknown to
J is defined in the file then the name will be executed
allowing one to define the unknown primitive.

A test statement is created by replacing each token in a
statement with a dummy token of the same part of speech as
the original token. When the test statement is run, each
replacement token reports how it is used in the statement by
replacing the ambivalent name with the appropriate valence
name. The dummy tokens for primitives include the name of the
primitive and its position in the statement. If the original
token is not a defined primitive the replacement simply
executes but does not modify the converted statement. If the
execution of the test statement results in an error. Then the
converted statement would be left with ambivalent names for
tokens not yet executed. Otherwise, the error is ignored.

Nouns are simply nouns. They only have one name. If there is
a name assigned to a noun it is only necessary to subsitute
in the name for the primitive. Otherwise, leave it alone.

Each verb, adverb and conjunction is replaced with a dummy
name of the same part of speech as the original. For defined
primitives these names are of the form "ambivalent-name",
'_',"position". For "@" as the forth token in the statement
would be "Atop_3". This makes each name unique and also
defines its position in tokens. Defined names are the name
with the position appended similarly. Undefined primitives
just use "Verb", "Adverb" or "Conjunction" followed by the
position.

The replacement verbs must include definitions for obverse.
This allows execution to continue if the obverse of the verb
is executed.

The replacements for nouns is the list _1 2,.3 4 defined in
the verb "Pn". It needs to have more than one item so adverbs
and conjunctions like "/" will execute its verb. The specific
values of _1 2,.3 4 are arbitrary other than it contains more
than one item an its rank is greater than one forcing most
adverbs and conjunctions run their verbs.

The parts of speech returned by 4!:0 only gives the parts of
speech for defined names. A special verb "analyzetokens"
analyzes all types of tokens and determines how the tokens of
a statement are used. See the comments for "analyzetokens" to
see the parts it defines.

This conversion tool is really intended to analyze statements
of primitives only. If any defined names appear in the
statement it is necessary that they are previously defined in
the proper part of speech so the statement will be parsed
correctly. Otherwise the undefined names will act like verbs.

Defined adverbs and conjunctions may appear in a statement to
be converted. Right now the adverbs and conjunctions are
executed with the hope that they will work with the dummy
data. As an alternative, an option to actually execute the
verbs as well in the statement with its real data allows
primitives to be properly handled. But if the defined adverb
or conjunction fails to execute a primitive verb for some
reason the verb names not processed yet will be left with its
ambivalent name.


Special Case:

As mentioned earlier, Cap ([:) is a special problem as even
though a train with a Cap makes verbs syntactically dyadic
but they really execute monadically. There is a test in
analyzetokens which should recognize any verb which acts like
Cap. Running C with a left argument of 1 1 works most of the
time.


Finally -

The original purpose of translating primitives to names was
to provide a tool to run J primitives against alternative
numbering systems like quaternions. This tool is the part
that would allow one to define extensions or alternatives to
J primitives, accept different numeric constants and if
desired, create new primitives which are executable. All you
have to do is create your own handlers for the names assigned
to primitives.

This is a work in progress. It is a challange to see how far
this can go. Right now gerunds will appear as nouns and will
not be converted properly. Names before a copula,
particularly if it is in the middle of a statement are not
handled yet.

As a next step this needs to be made into a class/object form
so to avoid name conflicts and possibly allow for more than
one set of translation tables to coexist.


Primary global names:
  tokens      - The statement with each token boxed.
  converted   - The converted statement with each token
                still boxed.
  symbols     - The primitives defined in file.
  alphas      - The replacement names for primitives. Each
                item in this list corresponds to a primitive
                in symbols. Each item is a boxed list of at
                least three names for the primitive, first
                name for it`s ambivalent form, the second
                for monadic and the third for dyadic.
                Additional names are ignored by this code
                but are available to an optional special
                processing for the primitive.
  idioms      - A string of primitives which together like
                +/ could be called Sum and &.> can be called
                Each. Right now they are restricted to idioms
                including an adverb or conjunction which binds
                the same way whether or not it is part of a
                tacit expression. One possible way to handle
                this more fully like handling hooks and forks
                would be to be able to fully parenthesize a
                statement which is not tacit.
  idiomalphas - Like alphas only the names associated with
                idioms.

Global names in Z:
  mn          - A general verb to link to the mnemonics
                converter.
  mnlocale    - The name of the locale for the mnemonics
                converter processing work area.

Locales:
  mnemonics   - The locale for mnemonics processing.
  mncode      - Contains the mnemonic scripts.
  mntemp      - A temporary area to contain defined names
                used during conversion.

Right now the z locale is used to store the mnemonic
representation of primitives. This is the way the script that
comes with J does it. This could be moved to another locale
to provide support of multiple translations to mnemonics.

The paths for the locales.
  mnemonics - mncode,z
  mncode    - z
  mntemp    - <caller>,z

Most processing is done in locale mnemonics. Processing
requiring access to the caller`s locale are done in mntemp.
)

Note 'To Do'

*  Handle gerunds. Need to have a special type for gerunds.
*  Names before a copula.
*  Add support for special code to handle specific primitives.
)

Note  'Problems'
*  "/" in primitiv.ijs has "Table Insert" backwards.
*  "paren" turns "+((+/)%#)3 4 6" into a hook.
*  "paren" gives error undefined name for m, n, u, v .
)

NB. Temporary for testing
callerloc=.coname''
cocurrent 'mncode'


NB. Support programs __________________________________________

NB.*replacetokens v Replace tokens in a literal
NB. Used to taylor the prototype scripts.
NB. Arguments:
NB.   x - Two items
NB.         Item 0 - a list of the tokens to be replaced
NB.         Item 1 - a list of the replacement tokens 
NB.   y - A literal containing the tokens to be replaced.
NB. Return:
NB.   The literal with tokens in it replaced.
replacetokens=: 4 : 0
'old new'=.x
i=.I.m=:(#old)>n=.old i.y=.;:y
;:^:_1((m#n){new)i}y
)

NB.*analyzetokens - Returns the part of speech like (4!:0)
NB. A token can be a literal as well as a name and additional
NB. parts of speech are defined. See Return.
NB. Input:
NB.   y - A list of boxed tokens.
NB. Return: A list, an integer for each token
NB.    _3 - Empty
NB.    _2 - Invalid
NB.    _1 - Unused
NB.     0 - Noun
NB.     1 - Adverb 
NB.     2 - Conjunction
NB.     3 - Verb
NB.     4 - Copula
NB.     5 - Punctuation
NB.     6 - Locale
NB.     7 - Nota Bene
NB.     8 - Cap ([:) - Makes middle verb in a fork into a monad.
NB.
NB. Special handling for verbs which act like Cap ([:)
NB.   The verb is tested by using it as the left verb in a fork
NB.   and seeing if the middle verb is executed as a monad or a
NB.   dyad.
NB.
NB. The name "testf" has to be global and is placed in mnlocale.
NB. Tried to make it local but it becomes local to do_caller and
NB. disappears.
analyzetokens=: 3 : 0&>
t=._2
if. ''-:y do. _3 return. end.
x=.((;@{.)^:L.)y
try.
    do__caller 'testf__mnlocale=:(0(1 : ''',x,'''))'
    t=.4!:0<'testf'
  catch.
    select. {.x
      case. '='     do. if. 2=#y do. t=.4 end.
      case. '(';')' do. if. 1=#y do. t=.5 end.
      case. 'N'     do. if. ('NB.'-:3{.x) *.-.':.'e.~{:4{.x do. t=.7 end.
    end.
end.
if. t=3 do. NB. Cap test.
  t=.do__caller '1((0(1 : ''',x,''')(8: : 3:)]) :: 3:)1'
  try.    testf f. end
    catch. t=._1
  end.
end.
t
)

NB. See settings for "messagebox" in message.
messagebox=:2

NB.*message v Display a message
NB. Arguments:
NB.   x - Two items, the first a title of the message.
NB.       If null then "Information" is displayed.
NB.       The second the type of message as in mb, zero
NB.       through five as levels of severity, default zero.
NB.   y - A box list of lines of text to display, each box a line.
NB. Return:
NB.   empty
NB. Global Flag:
NB.   messagebox - 0: No Display
NB.                1: Display message in ijx
NB.                2: Display in a message box
NB.                3: Display in both
NB.   debug      - 0: No Debug output.
NB.                1: Display debug output. This forces the output
NB.                   to the ijx window.
NB. This is intended to be used to display in a message box; however,
NB. it may also be displayed in the ijx window.
message=: 3 : 0
'' message y
:
y=.boxopen y
'title icon'=.2{.<S:0 x;0
title=.;(([:*#){'Information'"_;])title
icon=.' mb_icon',;icon{;:'information hand question astrisk exclamation stop'
'b x'=.0 2#:debug{messagebox,1
".x#'(1!:2&2)}:;(title,LF);(<''  ''),&.>y,&.>LF'
empty wd b#'mb "',title,'" "',(}:;y,&.>LF),'"',icon
)

NB.*debugmessage v Write out information for debugging.
debugmessage=: 3 : 0
'Debug Output' message y
)

NB.*qs v Quote a string. Double quotes if necessary.
q=.''''"_
dq=.([:>:q=])#]
qs=:(q,~q,dq)f.


NB. Definition of Primitives ______________________________

NB.*loadprimitives v Load names for primitives
NB. Argument:
NB.   y - The name of the file containing the primitive
NB.       definitions.
NB. If you create a file of your own, format it like the format
NB. of ~system\packages\misc\primitiv.ijs
NB. That format of a primitive is as follows:
NB.   monadname=:dyadname=:ambivalentname=:primitive
NB. Comment and blank lines are ignored. If only two names are
NB. assigned then the dyad name is used for ambivalent name. If
NB. only one name is assigned then monad name is used for all
NB. three. If a primitive is defined on more than one line then
NB. the names are combined for the primitive. If a name is used
NB. on more than one primitive then a warning about duplicates
NB. is issued. IF more than three names are defined they will be
NB. kept but only the first three will be used in this code.
NB. They may be used by special code if desired.
NB.
NB. If a symbol (that after the last copula) contains more than
NB. one token then it is an idiom.

NB. Build lists of symbols etc. for subsitution of primitives.
NB.   symbols     - The primitive symbols defined in file
NB.   alphas      - The names for the primitives. See comments
NB.                 above.
NB.   idioms      - A definition containing more than one
NB.                 primitive. Right now these are restricted to
NB.                 idioms which are parsed the same way whether
NB.                 in a tacit or non-tacit form.
NB.   idiomalphas - Names for the idioms.
NB.
NB. Each item alphas and idiomalphas contains three items ordered
NB. ambivalent name, monadic name, dyadic name.
NB.
NB. Rewriting this to conform of new form of primitiv.ijs
loadprimitives=: 3 : 0
load y

NB. Determine if CamelCase is used
n=.1{;:PRIMITIVES
CamelCase=:0
if. _1~:4!:0 n
    do.   CamelCase=:1
  elseif. _1=4!:0 tolower&.>n
    do.   ('Warning';4) message 'Unable to determine CamelCase'
end.

p=.;:&.><;._2 tolower^:(-.CamelCase)PRIMITIVES

symbols=:{.&>p
alphas=:build_alphas p

NB. Get idioms
if. 0=4!:0<'IDIOMS'
  do.   p=.;:&.><;._2 tolower^:(-.CamelCase)IDIOMS
  else. p=.idioms=:idiomalphas=:''
end.
idioms=:".&.>;{.&.>p
idioms=:;:@paren&.>idioms
idiomalphas=:build_alphas p

NB. Define the names for idioms so converted
NB. statements will execute.
f=.(13 : 'do_z_;(,(<'' =: ''),,)/(~.x),(<;:^:_1 y)')
idiomalphas f&> idioms

NB. Remove open paren so idioms will be recognized.
idioms=:}.&.>idioms

NB. Make sure that the longer idiom of two which start the
NB. same comes first.
idioms=:idioms{~m=.\:idioms
idiomalphas=:m{idiomalphas

NB. Disable check for idioms control if no idioms.
CheckForIdioms=:TraceAvailable=:*#idioms

''
)

mnprimitives=:'z'

NB.*build_alphas v Build and name tables
NB. Argument:
NB.   y - A boxed list of tokens as defind in file.
NB.       This is PRIMITIVES and possibly IDIOMS.
NB.       The tokens consist of a primitive or idiom
NB.       followed by one or more names, the first is
NB.       the dyadic, the last monadic and the second
NB.       is used as ambivalent. Any additional names follow.
NB. Return:
NB.   A boxed list. Each item is the names for the
NB.   corresponding primitive or idiom. These names
NB.   are at least three, ambivalent, monadic and dyadic.
NB.   If more names were supplied then they follow.
NB. The names are expanded to at least three and reordered
NB. as described above. A check is made to assure no duplicates
NB. exist. (No check between IDIOMS and PRIMITIVES)
build_alphas=: 3 : 0
n=.(~.@|.@}.)&.>y
d=.(]{~[:I.i.~~:[:i.#);n
if. #d do.
  (('Warning! Duplicates in ',file);4) message d
end.
(_1|.(([:i.3>.#)<.[:<:#){])&.>n
)

NB. define_primitives v Define names for primitives
NB. Define the names associated with the primitives so the
NB. names will execute as the primitives.
NB. Arugments:
NB.   y - A list of primitives and associated names as
NB.       defined in ~system\packages\misc\primitiv.ijs
NB.   x - The locale in which to define the names
NB.       The default is the "z" locale
NB. Return: None
define_primitives=: 3 : 0
'z' define_primitives y
:
p=.;:&.><;._2 y
x=.{.cutopen x
def=.([:do__x[:>[:;(,((<' =: ')"_),,)/)&.>
empty def 1|.&.>p
)

NB. Main Program ______________________________________________

NB.*C v The main program to convert the primitives in a statement
NB. Arguments:
NB.   x - (Optional) One to four numbers. Choices which affect
NB.       the result. See Initial Values for Options.
NB.     First number:
NB.         When the statement is tacit if it is to be assumed
NB.         to be a monadic or dyadic tacit definition.
NB.       1 Assume monadic.
NB.       2 Assume dyadic.
NB.     Second number:
NB.       0 Replace named tokens and constants with dummys
NB.         and execute the statement in dummy mode.
NB.       1 Only replace defined primitives and execute the
NB.         statement fully.
NB.       2 Just convert primitives found in symbols to
NB.         ambivalent names and return that result.
NB.     Third number - Expand idioms:
NB.       0 Do not expand.
NB.       1 Expand.
NB.     Forth number - Special handling:
NB.       0 Disable.
NB.       1 Enable. 
NB.   y - A text string containing the statement.
NB. Return:
NB.   The statement with the primitives defined in symbols
NB.   converted to the appropriate names. Since the names from
NB.   file are defined the result is executable.
NB. Global of interest:
NB.   runtest - True when second number of x is 1.
NB.             A flag to tell verbtest to run the verb when
NB.             testing it instead of a dummy verb.
NB.   debug   - If true some intermediate results are displayed
NB.             in the ijx window.
NB.   caller ???
NB.   mntemp ???
NB. Logic:
NB.
NB. See Wiki comments
C=:3 : 0
'' C y
:
coerase mntemp
((],copath) caller) 18!:2 mntemp
x=.x,(#x)}.TacitValence,ConvertType,CheckForIdioms,EnableSpecialHandling
'tacit conv replaceidioms specialhandling'=:x
runtest=:conv=1
converted=:(;:`handleidioms@.replaceidioms"_)y
j=.(t=.j<#symbols)#j=.symbols i. converted
converted=:(j{alphas)(I.t)}converted
t=.analyzetokens converted
t=.5(I.t e. runtest#0)}t
if. +/l=.t=_1 do.
  m=.'The following name(s) are undefined. Treated as verbs'
  'Warning' message m;l#converted
end.
if. conv=2
  do.
    converted=:((;@{.)^:L.)&.>converted
    r=.a:
  else.
    r=.converted((t{partsofspeech)@.])&.>i.#t
    dy=.'~'#~tacit=2
    do__mntemp '0!:010 ',qs'(',(;:^:_1 r),,')',dy,'1 2'
NB.    0!:010 '(',(;:^:_1 r),,')',dy,'1 2'
end.
if. +./l=.<:L."0 converted do.
  m=.1<>./#&>~.&.>converted
  converted=:l(]`({.@;@])@.[)"0 converted
  if. m do.
    m=.(<'Untested Primitives:'),(<'    '),&.>l#r
    ('Primitives Not Tested';4) message m
  end.
end.
".debug#'debugmessage <"1 ":(;:y),r,:converted'
;:^:_1 a:(~:#])converted
)

NB. Default Options (x if C is monadic)
TacitValence=:1
ConvertType=:0
CheckForIdioms=:1
EnableSpecialHandling=:1

NB.*handleidioms v find and handle defined idioms.
NB. Argument:
NB.   y - The statement to scan.
NB.   x - Unused. Needs to be dyadic to avoid an error.
NB. Return:
NB.   The tokens with any idioms replaced with its alpha triple.
NB.
NB. This is a special pass through tokens to look for any idioms there.
NB. It is an experiment to see if this is of interest. idioms are
NB. restricted to those built with adverbs and conjunctions for now.
NB. Trains could be handled only if there is a reliable way to recognize
NB. recognize them. One way would be to add parentheses fully to a
NB. statement.
NB.
NB. Idioms defined in file are located and replaced by
NB.   0: Convert the statement to tokens in both its original form
NB.      and parenthesis added.
NB.   1. Build a table, idioms rows and items columns and a one for
NB.      each idiom found.
NB.   2. Extend each one found with ones to the length of each idiom.
NB.   3. To eliminate any overlapping idioms, sort the table descending,
NB.      add the rows and throw out any row with a number greater than
NB.      one. This eliminates overlaps of idioms and picks the leftmost
NB.      or longest if more than one idiom start at the same place.
NB.   4. Use the ambivalent name of the idiom to build a test name and
NB.      put it in testing along with nuls to replace the original
NB.      primitives.
NB.
NB. This is awful! It really needs to be rewritten.
handleidioms=:3 : 0
NB. Setp 0
tok=.;:y
try. partok=.;:paren y
  catch.
    ('Internal Error';5) message paren_message
    partok=.y
end.
NB. Step 1
n=.idioms E.&>< partok
rc=.(/:|."1)4$.$.n
if. 0=#rc do. tok return. end.
'iidm itok lidm'=.|:remove_overlaps rc,.#&>({."1 rc){idioms
NB. iidm - Index of the idioms.
NB. itok - index of the start of idioms in tokens
NB. lidm - Index of idioms in partok.
inp=.([:-.(;:'()')e.~])#[:i.#  NB. Index of Non-Parens.
j=.inp partok
i=.(((<,'(') = ])i.0:)&>iidm{idioms
NB. Skip open parens for token idiom start and length.
lidm=.(<:+#&>iidm{idioms)-i
idm=.;lidm{.&.><"0 iidm{idiomalphas
itok=.;(itok+i)+&.>i.&.>lidm
NB. Step 4
partok=.idm itok}partok
(j{partok)(inp tok)}tok
)
paren_message=:0 : 0
Error attempting to search for mnemonics.

The verb `paren` has a few bugs. It will create hooks incorrectly
for some expressions. It also fail for the names `m`, `n`, `u`
and `v`. Turn off the `Replace Idioms` radio button and try again.
)

NB.*remove_overlaps v Remove overlapping idioms
NB. Argument:
NB.   y - A list of triples of numbers -
NB.       0 - The index of the idiom
NB.       1 - The index of the token
NB.       2 - The length of the idiom
NB. Return:
NB.   The same list of triples except any overlapping idioms
NB.   are removed.
remove_overlaps=: 3 : 0
r=.i.0 0
while. #y do.
  'a y'=.({.;}.)y
  m=.(+/}.a)<:1{"1 y
  r=.r,a
  y=.m#y
end.
r
)

handlespecialhandling=: 3 : 0

)

NB. Definitions for parts of speech _________________________


Testv=:]                    NB. Dummy verb for use in verbcode

NB.*buildtest v Build definitions to test verbs, adverbs and conjunctions
NB. Arguments:
NB.   x - The prototype script to use in defining test code.
NB.       See prototype definitions named xxxcode below.
NB.   y - The index of the token in converted.
NB. Return:
NB.   The replacement name for a conjunction which defines the primitive
NB.   and its position in tokens. Subsitutions are made for:
NB.     ).        - Replace with ) so multiple scripts may be included
NB.                 within a script
NB.     symbol    - The token (or idiom) to be replaced
NB.     testname  - The name for the token`s test script
NB.     index     - The index to the token for replacement
NB.     monadname - The replacement name if used monadically
NB.     dyadname  - The replacement name if used dyadically
NB.
NB.   The name returned is eventually defined in __mntemp.
NB. Logic:
NB.   The purpose of this is to create a name and its definition
NB.   to be used in the test statement. These are defined using
NB.   the information in x and y and the prototype definitions
NB.   defined after this verb.
NB.
NB.   First, it determines the type of token, a primitive in symbols,
NB.   an idiom found in idioms, a defined name or a primitive not
NB.   in symbols. From this it assigns an appropriate name for the
NB.   dummy and the names to use for the monadic and dyadic names.
NB.
NB.   The index to the token is appended to the dummy name and quotes
NB.   are put around the monadic and dyadic names as they are literals
NB.   in the prototype scripts. The subsitutions are made in the
NB.   prototype script and the resultant script is defined. The
NB.   name for the script is returned for insertion into the test
NB.   script.
NB.
NB.   The last two names to be subsituted are embedded in quotes as
NB.   that is how they appear in the prototypes.
NB.
NB.   If a name is a special name which includes a period (like x)
NB.   the period is removed in the dummy name created to avoid an
NB.   error. This still does not mean that special names will be
NB.   converted properly.
buildtest=: 4 : 0
xx=.;(([:<3&#)^:(1:=L.))converted{~i=.y
nam=.(('.'"_~:])#]),(;{.xx),'_',":y
oldnew=.(;:'testname index symbol monadname dyadname'),:(nam;":i),3{.xx
oldnew=.<"1 (3({.,[:qs&.>}.)"1 oldnew),.').';')'
mntemp defname oldnew replacetokens x
nam
)

NB.*defname v Define a script in a specified locale.
NB. Arguments:
NB.   y - A script to define.
NB.   x - The locale name in which to define the script.
defname=:4 : 0
caller=.coname''
cocurrent x
0!:0 y
cocurrent caller
)

NB.*replacetokens v Replace tokens in prototypes.
NB. Arguments:
NB.   x - A list of two lists. The first list is the values found
NB.       in the protorypes and the second list contains the
NB.       values to replace them with.
NB.   y - The prototype.
NB. Return:
NB.   A literal ready to be defined as a script and used for testing
NB.   how a token is used in a statement.
replacetokens=: 4 : 0
'old new'=.x
i=.I.m=:(#old)>n=:old i.t=.;:y
;:^:_1((m#n){new)i}t
)

NB. Prototypes for default primitive replacements.
NB.
NB. These are used as arguments to buildtest which scans the
NB. scripts and replaces specified tokens. These are defined as
NB. nouns with the definition prototype as the first line of the
NB. noun. Right parens to be in the definition are represented as
NB. ")." which is an invalid token in J. They are replaced with
NB. ")" along with the other tokens then the script is defined.
NB.
NB. Other key words to use are "testname" for the name of the
NB. script to build, "monadname" for the name for the monadic
NB. version of the primitive and "dyadname" for the dyadname of
NB. the primitive.

NB. Model code to help building tests

NB.*verbcode n The prototype test code for verbs.
NB. This is a definition to handle the monadic and dyadic, and
NB. normal and obverse forms of executing a verb. The appropriate
NB. name for the verb replaces the name in converted with the
NB. appropriate name then a verb is executed, either the actual
NB. verb or a dummy depending on the value of runtest.
NB.
NB. This does not handle adverses.
verbcode=:(<"0'Testv';5!:5<'Testv') replacetokens 0 : 0
testname =: (3 : 0) :. (3 : 0)
index replace__mnlocale <'monadname'
if. runtest__mnlocale
  do.   symbol^:_1 y
  else. Testv y
end.
:
index replace__mnlocale <'dyadname'
if. runtest__mnlocale
  do.   x symbol&._1 y
  else. x Testv y
end.
).
index replace__mnlocale <'monadname'
if. runtest__mnlocale
  do.   symbol y
  else. Testv y
end.
:
index replace__mnlocale <'dyadname'
if. runtest__mnlocale
  do.   x symbol y
  else. x Testv y
end.
).
)

NB.*adverbcode n The prototype code for adverbs.
NB. The appropriate name is replaced in converted then the
NB. adverb is executed, even if it is used defined.
adverbcode=:0 : 0
testname =: 1 : 0
index replace__mnlocale <'monadname'
u symbol y
:
index replace__mnlocale <'dyadname'
x u symbol y
).
)

NB.*conjunctioncode n The protorype code for conjunctions.
NB. Like adverbcode.
conjunctioncode=:0 : 0
testname =: 2 : 0
index replace__mnlocale <'monadname'
u symbol v y
:
index replace__mnlocale <'dyadname'
x u symbol v y
).
)

NB.*replace v Save the replacement name for a token.
NB. Arguments:
NB.   x - The index of the token in the statement.
NB.   y - The name to be used to replace the token.
NB. Return: Nothing useful.
NB. Logic:
NB.   This saves the name in a global list of boxes in the position
NB.   corresponding to the token in tokens.
replace=:4 : 0
converted=:y x}converted
)

NB.*checkobverse a Determine if a verb has an obverse
NB. Argument:
NB.   u - The verb
NB. Return:
NB.   None
NB. This is not used right now, but I haven`t deleted it yet.
NB. This is to check to verify that a verb has an obverse and give
NB. an error if it does not. It can be used in the obverse section
NB. of verbcode as a check.
checkobverse =: 1 : 0
try.
    u b._1
  catch.
    v=. u
    ('Inverse Error';3) message 'The verb ',(5!:5<'v'),' has no obverse.'
end.
Pn''
)

NB.*P? v These handle the various parts of speech.
NB. Arguments:
NB.   [ - The item from converted.
NB.   ] - The index of the item in converted.
NB. Return:
NB.   The appropriate replacement to go into converted. It is
NB.   normally the name of a definition returned from buildtest but
NB.   may be the original item.
NB.
Pn  =: 4 : 0                NB. Must handle here as nouns do not run.
if. L.x          do. ;r[converted=:(r=.{.x) y}converted
  elseif. conv=2 do. x
  elseif.        do. '_1 2,.3 4'
end.
)
Pa  =:[:adverbcode&buildtest]
Pc  =:[:conjunctioncode&buildtest]
Pv  =:[:verbcode&buildtest]
Pcop=: 4 : ';runtest{;:''] =:'''
Pp  =:[  NB.  'Punctuation'"_
Pl  =:]undefined&'Locale'
Pnb =:[                     NB.  'Nota Bene'"_
Pcap=:'[:'"_
Pin =:Pn f.                 NB. Treat invalid terms as nouns.
Pun =:[:verbcode&buildtest] NB. Treat undefined terms as verbs.
Pmt =:[

NB. The following gerund list simplifies building the test statement.
NB.            0   1  2  3  4    5    6  7   8    _3    _2   _1
NB.            n   a  c  v  cop  p    l  NB  cap  empty inv  unused   
partsofspeech=:Pn`Pa `Pc`Pv`Pcop`Pp  `Pl`Pnb`Pcap`Pmt  `Pin `Pun

NB.*undefined v Display a serious error if part of speech undefined.
undefined=: 4 : 0
('Serious Error';5) message 'Part of speech "',y,'" is not defined!'
)

0 : 0 NB. Comments on various parts of speech

Pn   - Used for all data to verbs and return from verbs in dummy
       mode. A 2-item list so verb arguments to adverbs like "/"
       will be executed.
Pcop - Copulas are changed to "]" in dummy mode to avoid an error
       since in dummy mode the name to the left of the copula is
       changed to a constant. If runtest is true it is set to
       '=:' so any assignments will be visible after converting.
Pl   - Locale? How can 4!:0 recognize this? How can I define this?
Pcap - Just let it do it`s thing for now.
Pin  - Invalid. Other number systems may generate this class.
       Use this to interpret other number systems.
Pun  - Right now they are treated as verbs by analyzetoken. That
       is what the J interpreter does, so that seemed reasonable.
Pmt  - Empty or null token. Idiom replacement creates them.
)


NB. Special Handling___________________________________________
NB.
NB. This would be better at the bottom of this script or in another
NB. script; however, to keep the file to Wiki down to one and things
NB. people may want to find at the bottom the definitions are stored
NB. then run after mnemonics are defined.

NB.*special_handling_2 v Create prototype verbs for specific primitives.
NB. Arguments:
NB.   x - The primitive.
NB.   y - The prototype script.
NB. Return: None
NB. Externals:
NB.   The primitive is added to the list special_symbols.
NB.   The prototype name is added to the list special_alphas.
NB.   The prototype verb is defined.
NB. The prototypes must be dyadic verbs defined as other protypes
NB. are defined to buildtest.
special_handling_2=: 4 : 0
nam=.(<<'handle_'),&.>&.>alphas{~symbols i.<,x
special_symbols=:special_symbols,<,x
special_alphas=:special_alphas,nam
0!:0 (;{.>nam),'=: 0 : 0',LF,y,LF,')'
)

NB.*special_handling v Queue up definitions for special_handling_2
NB. Arguments and return same as special_handling_2
NB. Saves the arguments in a table to pass to special_handling_2
special_handling=: 4 : 0
special_handling_save=:special_handling_save,x;y
)
special_handling_save=:i.0 0

NB.*special_Tie c Handle ties.
NB. This prototype forces its verbs to run even if they are not
NB. selected in the actual statement. They are run throwing away
NB. their result but getting them to update their usage in converted.
NB. Then the verbs are run if selected later by "@.".
NB. It doesn`t hurt if the verbs are run more than once.
NB. The results of Tie cannot take on x and y arguments. That is
NB. done by Agenda. Therefore no x and y in the expansion.
'`' special_handling 0 : 0
testname =: 2 : 0
index replace__mnlocale <'monadname'
u]
v]
u ` v
:
index replace__mnlocale <'dyadname'
[u]
[v]
u ` v
).
)

NB.*special_Agenda c For testing
'@.' special_handling 0 : 0
testname =: 2 : 0
u@.v.y
:
x.u@.v.y
)

NB. Test code__________________________________________________

Note 'To run verify do the following:'
cocurrent 'mnemonics'
verify ''
)

verify=:3 : 0
erase 'ppp'
debug__mnlocale=:0
loadprimitives path,'testdef.ijs'

NB. Basic tests

NB. verify that analyzetokens is working.
assert. _3 _2 _1 0 1 2 3 4 5 8 7 -: analyzetokens a:,;:'1k2 aaa 1 2 3/&+=.([:NB. xxx'

assert.(,'1') -: mn '1'
assert. '1 Plus 2' -: mn '1+2'
assert. 'Conjugate Times Negate' -: mn '+*-'
assert. 'Plus Times Minus' -: 2 mn '+*-'
a=:1 2 3
assert. 'Double a' -: mn '+:a'
NB. Error tests
debug__mnlocale=:1
'Verify' message 'Should get message about ppp is undefined.'
assert. 'Conjugate 1 ppp 2' -:1 mn '+1 ppp 2'
'Verify' message 'Should get additional message about Plus_0 untested.'
assert. 'Plus 1 ppp 2' -:1 1 mn '+1 ppp 2'
debug__mnlocale=:0
ppp=:+
assert. 'Conjugate 1 ppp 2' -:1 1 mn '+1 ppp 2'
erase 'ppp'
NB. Idiom tests
assert. 'Sum Integers 3' -: 1 0 1 mn '+/i.3'
assert. '1 2 PlusTable Integers 3' -: 1 0 1 mn '1 2+/i.3'
assert. 'CountEach Words ''aa b ccc'''   -: 1 0 1 mn '#&.>;:''aa b ccc'''
assert. 'Tally Bond Open Words ''aa b ccc''' -: 1 0 1 mn '#&>;:''aa b ccc'''
assert. 'Tally ( Each ) Words ''aa b ccc d ee''' -: 1 0 1 mn '#(&.>);:''aa b ccc d ee'''
NB. Verify finding longest idiom.
assert. 'Signum RunningSum Integers 3' -: 1 0 1 mn '*+/\i.3'
assert. 'Signum Sum Integers 3' -: 1 0 1 mn '*+/i.3'
assert. 'Signum Equal Insert 2 3 RunningSumTable 4 5' -: 1 0 1 mn '*=/2 3+/\4 5'
assert. 'Signum Sum 2 3 RunningSumTable 4 5' -: 1 0 1 mn '*+/2 3+/\4 5'
NB. Special noun only
assert. (,'m')-: mn 'm'
NB. Comjunction only.
debug__mnlocale=:1
'Verify' message 'Should not be an untested message.'
assert. 'Power' -: mn '^:'
debug__mnlocale=:0

loadprimitives path,'mndefs.ijs'

0 0$0
)

a=:('assert. '"_,(qs@mn),' -: mn '"_,qs)


NB. Unicode support ____________________________________________

NB.*UTF8 v Convert Unicode numbers or hex to U8
NB. Argument:
NB.   y - A list of numbers of unicode values in decimal
NB.       or a literal containing hexidecimal number list
NB. Return:
NB.   The numbers converted to UTF8.
NB. Any not-hex character is considered a delimiter between
NB. hex numbers.
NB. The last three lines handle the full unicode set, not just
NB. that less than 65536.
UTF8=: 3 : 0
try. if. *./y<128 do. y{a. return. end.
  catch.
    ;UTF8&.>(16&#.)&>(([:-.a:-:"0])#])<;._1]16,'0123456789abcdef'i.>y
    return.
end.
if. 1<#y do. ;UTF8&.>y return. end.
l=.#n=.64#.^:_1 y
n=.n{.~-l=.l+7<l+##:{.n
a.{~n+l{.!.128#.8{.l#1
)

NameToUnicode=: 3 : 0
e=.(#Uname)>i=.Uname i.;:y
;:^:_1(<"1 e,.i.#e){(;:y),:i{Ucode,a:
)


NB. Form Definition ____________________________________________


ALPHA=: 0 : 0
pc alpha closeok;pn "Convert J Primitives to Mnemonics";
xywh 3 9 56 11;cc s1 static ss_right;cn "Primitive Expression";
xywh 63 9 241 11;cc prim edit rightmove;
xywh 3 25 56 11;cc s2 static ss_right;cn "Mnemonic Expression";
xywh 63 25 241 11;cc nam edit rightmove;
xywh 8 44 73 10;cc convertidioms checkbox rightscale;cn "Replace Idioms";
xywh 8 52 73 10;cc special checkbox rightscale;cn "Enable Special Handling";
xywh 8 68 73 10;cc real checkbox rightscale;cn "Use Real Data";
xywh 93 44 93 10;cc toclip checkbox leftscale rightscale;cn "Convert and Copy to Clipboard";
xywh 93 52 93 10;cc toijx checkbox leftscale rightscale;cn "Convert and Run in ijx Window";
xywh 93 68 93 10;cc dbg checkbox leftscale rightscale;cn "Debug";
xywh 200 44 102 10;cc mon radiobutton leftscale rightmove;cn "Assume Tacit Expression is Monadic";
xywh 200 52 102 10;cc dyad radiobutton leftscale rightmove group;cn "Assume Tacit Expression is Dyadic";
xywh 197 40 107 27;cc mondyad groupbox leftscale rightmove;cn "";
xywh 200 68 50 10;cc uc checkbox leftscale rightscale;cn "Show Unicode";
pas 6 6;pcenter;
rem form end;
)

alpha_run=: 3 : 0
wd ALPHA
NB. initialize form here
wd 'setfont prim "Lucida Console" 10 oem'
wd 'setfont nam "Lucida Console" 10 oem'
if. TraceAvailable
  do.
    wd 'set convertidioms ',":CheckForIdioms
  else.
    wd 'setenable convertidioms 0'
end.
NB. wd 'set special ',":EnableSpecialHandling
wd 'setenable special 0'
wd 'set real ',":1=ConvertType
wd 'set toclip ',toclip
wd 'set toijx ',toijx
wd 'set dbg ',":debug
wd 'set mon  ',":1=TacitValence
wd 'set dyad ',":2=TacitValence
if. *4!:0<'Uname'
  do.
    wd 'setenable uc 0'
  else.
    wd 'xywh 63 84 241 21;cc unic editm rightmove bottommove;'
    wd 'setfont unic "Lucida Console" 12 oem'
    wd 'setshow unic 0'
    ucxywh=:wd 'qchildxywhx unic'
end.
wd 'pshow;'
)

toclip=:toijx=:'0'
debug=:0

convert=:3 : 0
x=.TacitValence,ConvertType,CheckForIdioms,EnableSpecialHandling
wd 'set nam *',nam=:x mn prim
if. ".toclip do. wd 'clipcopy *',nam end.
if. ".toijx  do. runimmx1_jijs_  nam end.
if. ".uc     do. wd 'set unic *',NameToUnicode nam end.
)

alpha_nam_button=: 3 : 0
convert''
)

alpha_prim_button=: 3 : 0
convert''
)

alpha_convertidioms_button=: 3 : 0
CheckForIdioms=:".convertidioms
)

alpha_special_button=: 3 : 0
EnableSpecialHandling=:".special
)

alpha_real_button=: 3 : 0
ConvertType=:".real
)

alpha_toijx_button=: showijx

alpha_dbg_button=: 3 : 0
wd 'set dbg ',":debug=:".dbg
if. debug=1 do. showijx'' end.
)

alpha_mon_button=: 3 : 0
TacitValence=:1
)

alpha_dyad_button=: 3 : 0
TacitValence=:2
)

alpha_uc_button=: 3 : 0
if. uc='1'
  do.
    wd 'setxywhx unic ',ucxywh
    wd 'setshow unic 1'
  else.
    ucxywh=:wd 'qchildxywhx unic'
    wd 'setxywhx unic 1 1 1 1'
    wd 'setshow unic 0'
end.
wd 'pas 6 6'
)

NB.*showijx v If the ijx window is not shown show it.
showijx=: 3 : 0
if. -.IFSHOW_jijs_ do.
  IFSHOW_jijs_=:1
  wd newijx_jijs_ 1
  wd 'psel alpha'
end.
)

NB.*runij v Apply mn to a line or selected text
NB.   Arguments: None
NB.   Return: None
NB. runij passes to runlines the selected text or, if none,
NB. the current line in the current window.
runij=: 3 : 0
if. 0=#t=.getselection_jijs_'' do.
  t=.getline_jijs_ ''
end.
runlines t
)

NB.*runlines v Check for multiple lines and pass each line
NB. to mn.
NB. Argument:
NB.   y - A literal which may contain line feeds.
NB. Return: None
runlines=: 3 : 0
y=.LF,y
for_t. ((a:&~:)#])(LF=y)<;._1 y do.
  (1!:2&2)mn ;t
end.
)

NB.*mn v - Interface to mnemonics
NB. Arguments:
NB.   y - If null, open the form for mnemonics.
NB.       if a literal, convert the statement to mnemonics.
NB.   x - The x argument to C in mnemonicscode.
mn_z_=: 3 : 0
'' mn y
:
caller__mnlocale=: coname''
if. #y
  do.   x C__mnlocale y
  else. alpha_run__mnlocale''
end.
)


NB. Required Scripts_________________________________________

NB. A special test is made for "trace.ijs" as it is not
NB. available in J5. If it is not found then idiom checking
NB. is not available. Once J6 or greater is all that is
NB. supported then this and the related code in "alpha_run"
NB. can be pulled.

require 'files'
3 : 0 ''
TraceAvailable=:1
try. require 'trace'
  catch.
    TraceAvailable=:0
    CheckForIdioms=:0
end.
)


NB. Finish locale definitions________________________________

cocurrent 'mnemonics'
caller=:callerloc
mnlocale_z_=:coname''
coinsert 'mncode'
mntemp=:<'mntemp'
definitions=:<'z' NB. change to appropriate locale if
                  NB. the definitions are moved.

NB. Define F4 key to run selected or line with mn.
jijs_f4_fkey_jijs_=:runij__mnlocale

NB. For finding other files in this script's folder.
path=:PATHSEP_j_([,~i:~{.]);(4!:4<'caller'){4!:3''

NB. The file containing the primitive definitions:
z=.0=#fdir file=:path,'primitiv.ijs'
do^:z 'file=:jpath ''~system\packages\misc\primitiv.ijs'''


NB. loadprimitives path,'mndefs.ijs'
loadprimitives file

NB. Define special handling prototypes.
special_symbols=:special_alphas=:''
special_handling_2 &>/"1 special_handling_save
erase 'special_handling_save'

cocurrent caller
".(-.IFSHOW_jijs_)#'mn '''''

NB. End of script _________________________________________
}}}

