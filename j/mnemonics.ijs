jwd=: 3 : 0
select. y
 case. ,'='  do. 'Self-Classify • Equal'
 case. '=.' do. 'Is (Local)'
 case. '=:' do. 'Is (Global)'
 case. ,'<'  do. 'Box • Less Than '
 case. '<.' do. 'Floor • Lesser Of (Min) '
 case. '<:' do. 'Decrement • Less Or Equal'
 case. ,'>'  do. 'Open • Larger Than '
 case. '>.' do. 'Ceiling • Larger of (Max) '
 case. '>:' do. 'Increment • Larger Or Equal'
 case. ,'_'  do. 'Negative Sign / Infinity '
 case. '_.' do. 'Indeterminate '
 case. '_:' do. 'Infinity'
 case. ,'+'  do. 'Conjugate • Plus '
 case. '+.' do. 'Real / Imaginary • GCD (Or) '
 case. '+:' do. 'Double • Not-Or'
 case. ,'*'  do. 'Signum • Times '
 case. '*.' do. 'Length/Angle • LCM (And) '
 case. '*:' do. 'Square • Not-And'
 case. ,'-'  do. 'Negate • Minus '
 case. '-.' do. 'Not • Less '
 case. '-:' do. 'Halve • Match'
 case. ,'%'  do. 'Reciprocal • Divide '
 case. '%.' do. 'Matrix Inverse • Matrix Divide '
 case. '%:' do. 'Square Root • Root'
 case. ,'^'  do. 'Exponential • Power '
 case. '^.' do. 'Natural Log • Logarithm '
 case. '^:' do. 'Power (u^:n u^:v)'
 case. ,'$'  do. 'Shape Of • Shape '
 case. '$.' do. 'Sparse '
 case. '$:' do. 'Self-Reference'
 case. ,'~'  do. 'Reflex • Passive / Evoke '
 case. '~.' do. 'Nub • '
 case. '~:' do. 'Nub Sieve • Not-Equal'
 case. ,'|'  do. 'Magnitude • Residue '
 case. '|.' do. 'Reverse • Rotate (Shift) '
 case. '|:' do. 'Transpose'
 case. ,'.'  do. 'Determinant • Dot Product '
 case. '..' do. 'Even '
 case. '.:' do. 'Odd'
 case. ,':'  do. 'Explicit / Monad-Dyad '
 case. ':.' do. 'Obverse '
 case. '::' do. 'Adverse'
 case. ,','  do. 'Ravel • Append '
 case. ',.' do. 'Ravel Items • Stitch '
 case. ',:' do. 'Itemize • Laminate'
 case. ,';'  do. 'Raze • Link '
 case. ';.' do. 'Cut '
 case. ';:' do. 'Words • Sequential Machine'
 case. ,'#'  do. 'Tally • Copy '
 case. '#.' do. 'Base 2 • Base '
 case. '#:' do. 'Antibase 2 • Antibase'
 case. ,'!'  do. 'Factorial • Out Of '
 case. '!.' do. 'Fit (Customize) '
 case. '!:' do. 'Foreign'
 case. ,'/'  do. 'Insert • Table '
 case. '/.' do. 'Oblique • Key '
 case. '/:' do. 'Grade Up • Sort'
 case. ,'\'  do. 'Prefix • Infix '
 case. '\.' do. 'Suffix • Outfix '
 case. '\:' do. 'Grade Down • Sort'
 case. ,'['  do. 'Same • Left'
 case. '[:' do. 'Cap'
 case. ,']'  do. 'Same • Right'
 case. ,'{'  do. 'Catalogue • From '
 case. '{.' do. 'Head • Take '
 case. '{:' do. 'Tail • '
 case. '{::' do. 'Map • Fetch'
 case. ,'}'  do. 'Item Amend • Amend (m} u}) '
 case. '}.' do. 'Behead • Drop '
 case. '}:' do. 'Curtail •'
 case. ,'"'  do. 'Rank (m"n u"n m"v u"v) '
 case. '".' do. 'Do • Numbers '
 case. '":' do. 'Default Format • Format'
 case. ,'`'  do. 'Tie (Gerund)'
 case. '`:' do. 'Evoke Gerund'
 case. ,'@'  do. 'Atop '
 case. '@.' do. 'Agenda '
 case. '@:' do. 'At'
 case. ,'&'  do. 'Bond / Compose '
 case. '&.' do. '&.: Under (Dual) '
 case. '&:' do. 'Appose'
 case. ,'?'  do. 'Roll • Deal '
 case. '?.' do. 'Roll • Deal (fixed seed)'
 case. 'a.' do. 'Alphabet '
 case. 'a:' do. 'Ace (Boxed Empty) '
 case. 'A.' do. 'Anagram Index • Anagram'
 case. 'b.' do. 'Boolean / Basic '
 case. 'C.' do. 'Cycle-Direct • Permute '
 case. 'd.' do. 'Derivative'
 case. 'D.' do. 'Derivative '
 case. 'D:' do. 'Secant Slope '
 case. 'e.' do. 'Raze In • Member (In)'
 case. 'E.' do. '• Member of Interval '
 case. 'f.' do. 'Fix'
 case. 'H.' do. 'Hypergeometric'
 case. 'i.' do. 'Integers • Index Of '
 case. 'i:' do. 'Steps • Index Of Last '
 case. 'I.' do. 'Indices • Interval Index'
 case. 'j.' do. 'Imaginary • Complex '
 case. 'L.' do. 'Level Of '
 case. 'L:' do. 'Level At'
 case. 'M.' do. 'Memo '
 case. 'NB.' do. 'Comment '
 case. 'o.' do. 'Pi Times • Circle Function'
 case. 'p.' do. 'Roots • Polynomial '
 case. 'p..' do. 'Poly. Deriv. • Poly. Integral '
 case. 'p:' do. 'Primes'
 case. 'q:' do. 'Prime Factors • Prime Exponents'
 case. 'r.' do. 'Angle • Polar '
 case. 's:' do. 'Symbol'
 case. 'S:' do. 'Spread '
 case. 't.' do. 'Taylor Coeff. (m t. u t.) '
 case. 't:' do. 'Weighted Taylor'
 case. 'T.' do. 'Taylor Approximation '
 case. 'u:' do. 'Unicode '
 case. 'x:' do. 'Extended Precision'
 case. '_9:' do. 'Constant Function'
 case. '_8:' do. 'Constant Function'
 case. '_7:' do. 'Constant Function'
 case. '_6:' do. 'Constant Function'
 case. '_5:' do. 'Constant Function'
 case. '_4:' do. 'Constant Function'
 case. '_3:' do. 'Constant Function'
 case. '_2:' do. 'Constant Function'
 case. '_1:' do. 'Constant Function'
 case. '9:' do. 'Constant Function'
 case. '8:' do. 'Constant Function'
 case. '7:' do. 'Constant Function'
 case. '6:' do. 'Constant Function'
 case. '5:' do. 'Constant Function'
 case. '4:' do. 'Constant Function'
 case. '3:' do. 'Constant Function'
 case. '2:' do. 'Constant Function'
 case. '1:' do. 'Constant Function'
 case. '0:' do. 'Constant Function'
end.
)

wjw=: 3 : '(>y);(jwd ,y)' NB. y is (str) Jwd to explicate
xp=:  3 : 'wjw"0 ;:y' NB. y is (str) expression to explicate

