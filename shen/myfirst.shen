(tc -)

(define map
   F []->[]
   F [X|Y]->[(F X)|(map F Y)])


(print "Define foldl")
(define foldl
{A --> A}
F Z [] -> Z
F Z [X | Y] -> (foldl F (F Z X) Y))

(foldl + 0 [1 2 3])
(foldl (function +) 0 [1 2 3])

(datatype fruit
if (element? Fruit [cherry apple pear])
__
Fruit :fruit;)



(datatype fruit
__
cherry : fruit ;
__
pear : fruit;
__
lemon : fruit;)


(datatype binary
   if (element? X [0 1]) 
   __ 
   X : zero_or_one;
   
   X : zero_or_one ;
   __ 
   [X] : binary;

   \* binary right*\
   X : zero_or_one ; Y : binary;
   __
   [X | Y ] : binary;

 
   \* binary left*\
   X : zero_or_one ; [Y | Z]  : binary >> P;
   __
   [X | Y | Z] : binary >> P;
)
  

(define complement
   {binary --> binary}
   [1]->[0]
   [0]->[1]
   [1 N|X]->[0|(complement [N|X])]
   [0 N|X]->[1|(complement [N|X])]
)


(define compl 
   {binary --> binary } 
   [1]->[0] 
   [0]->[1] 
   [1 N|X]->[0 | (compl [N|X])] 
   [0 N|X]->[1 | (compl [N|X])] 

)

(define factorial 
   {int --> int}
   0 -> 1
   X -> (* X (factorial (- X 1))))

(print " Input method to read from keyboard ")

 (input) 
(* 7 5)  
(print " result should now be printed ")


(print [(* 6 5 ) is 30])

(print "IF METHODS")


(if (= (+ 5 3) 8) "true" 0)
(if (= (+ 5 3) 9) "true" 0)
(if false 1 0)

(print "LOGICAL OPERATORS")
(and (= 3 4) (= 2 2))

