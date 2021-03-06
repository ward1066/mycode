\* I attach the code for a mathlib file,containing the following functions
 
abs       absolute value
fmod      x mod y or more explicitly, if y is non-zero, the value x - i*y 
          is returned, where i is an integer such that the result is 0, or 
          has the same sign as x and magnitude less than the magnitude of y.
          If y is 0, an error occurs.
exp                   e to the power x 
sinh, cosh, tanh      hyperbolic sine, cosine and tangent functions
sqrt_                 (there already is' sqrt' in Qi) square root of 
                      x for non-negative x
log, log10            natural logarithm and base 10 logarithm
sin, cos, tan         the trigonometric functions sine, cosine and tangent
asin, acos, atan      the inverse trigonometric functions arcsin, arccos and arctan.               The angles returned are in radians.
 
there is also expt which computes x to the power y (where meaningful).*\

\* auxiliary functions *\

(define sign
  0.0 -> 0
  X -> (if (> X 0) 1 -1))
  
(define div
   X Y -> (floor (/ X Y)))
   
\* fast integer power*\

(define square
  X -> (* X X) )

(define even?
  N -> true  where (= (* 2 (div N 2)) N)
  _ -> false)
  
(define power-pos
  X 1 -> X
  X N -> (let Y (square (power-pos X (div N 2)))
            (if (even? N) Y (* X Y))))
            
(define power
  X 0 -> 1    
  X N -> (let NP (abs N)
              P (power-pos X NP)
              (if (> N 0) P (/ 1 P))))
              
\*======================================================*\  
  
(define abs
  X -> (if (> X 0) X (- 0 X)))

(define floor X -> (FLOOR X)) 

(define ceiling X -> (CEILING X))   
 
(define fmod
  _ 0.0 -> (error "undefined!~%")
  X Y -> (let Y (abs Y)
              Q (/ X Y)
              (if (> X 0) (- X (* (floor Q) Y)) 
                          (- X (* (ceiling Q) Y)))))

\* this constant is system dependent and may be changed *\
\* if set too small termination is not always guaranteed *\
(set tolerance .0000000001) 

(set e          2.7182818284590452354) 
(set log_10     2.30258509299404568402)
(set pi         3.14159265358979323846)
(set pi_halved  1.57079632679489661923)
(set pi_quarter 0.78539816339744830962)
(set two_pi     6.28318530717958647692)


(define small-enough?
   X -> (< (abs X) (value tolerance)))

\*======================================================*\

(define exp
  X -> (let  X1 (ceiling X)
             X2 (- X X1)
             (if (< X2 -0.5) (/ 1.0 (exp (- 0 X)))
                             (exp-large X))))
           
(define exp-large
  X -> (let X1 (ceiling X)
              P (power (value e) X1)
              (* P (exp-h (- X X1)))))

(define exp-h
  X -> (while-exp 1 1.0 1.0 X))
  
(define while-exp 
  I P Sum X -> Sum  where (small-enough? P) 
  I P Sum X -> (let NewP (/ (* P X) I)
                (while-exp (+ I 1) NewP (+ Sum NewP) X)))
                
(define sinh
  X -> (let Exp_X (exp X)
           (/ (- Exp_X (/ 1.0 Exp_X)) 2.0)))

(define cosh
  X -> (let Exp_X (exp X)
           (/ (+ Exp_X (/ 1.0 Exp_X)) 2.0))) 
           
(define tanh
  X -> (sign X)     where (> (abs X) 20.0) 
  X -> (let Exp_2X (exp (+ X X))
            (/ (- Exp_2X 1.0) (+ Exp_2X 1.0))))
                       
\*======================================================*\  
    
(define expt
  0 Y -> (error "expt undefined!~%")  where (<= Y 0) 
  X Y -> (error "expt undefined!~%")  where (and (not (integer? Y))(< X 0))
  X Y -> (if (integer? Y)
             (power X Y)
             (exp (* Y (log X)))))
               

\*======================================================*\

(define sqrt_
  X -> (error "sqrt(x) for x < 0!~%")   where (< X 0)
  X -> (scale-sqrt X 1.0))
        
(define scale-sqrt
  X F -> (* (sqrt-h X) F)    where (< X 1.0)
  X F -> (scale-sqrt (/ X 100.0) (* F 10.0)))
  
(define sqrt-h 
  X -> (while-sqrt X (/ X 2) X))
   
(define while-sqrt
   X0 X A -> X      where (small-enough? (- X X0))
   X0 X A -> (while-sqrt X (mean A X0) A))

(define mean
   X Y -> (/ (+ Y (/ X Y)) 2.0))    

\* =====================================================*\

(define log
  X -> (error "log(x) for x < 0!~%")   where (< X 0)
  X -> (let Sgn (if (< X 0.5) -1 1)
            X   (if (< X 0.5) (/ 1.0 X) X)       
            (* (scale-log X 0) Sgn)))
               
(define scale-log
  A K -> (+ (log-h A) K)    where (< A 1.0)
  A K -> (scale-log (/ A (value e)) (+ K 1)))
  
(define log-h
  X -> (let X (/ (- X 1.0) (+ X 1.0))
            X2 (* X X)
            (while-log 3 X X X2)))

(define while-log 
  I P Sum X2 -> (* Sum 2.0)  where (small-enough? P)
  I P Sum X2 -> (let Ptmp (* P X2)
                 (while-log (+ I 2) Ptmp (+ Sum (/ Ptmp I)) X2)))
                 
(define log10
  X -> (/ (log X) (value log_10)))
                  
\* =====================================================*\
\*definition of sine*\
(define sin
  X -> (let Sgn (sign X)
            X   (fmod (abs X) (value two_pi))
            Sgn (if (> X (value pi)) (- 0 Sgn) Sgn)
            X   (if (> X (value pi)) (- X (value pi)) X)
            X   (if (> X (value pi_halved)) 
                         (- (value pi) X) X)
            (* (sin-h X) Sgn)))

(define sin-h
  X -> (while-sin 3 X X -1 (* X X)))
  
(define while-sin 
  I P Sum Sgn X2 ->  Sum  where  (small-enough? P)
  I P Sum Sgn X2 -> (let NewP (/ (/ (* P X2) I) (- I 1))
               (while-sin (+ I 2) NewP (+ Sum (* NewP Sgn)) (- 0 Sgn) X2)))
    
(define cos
  X -> (sin (- (value pi_halved) X)))
  
(define tan
  X -> (/(sin X) (cos X)))
  
\* =====================================================*\ 
 
 (define asin
   X -> (error "asin(x) for |x| > 1!~%")   where (>= (abs X) 1)
   X -> (let Sgn (sign X)
             X   (abs X)
             (if (< X 0.7) 
               (* (asin-h X) Sgn) 
               (- (value pi_halved) (* (asin-h (sqrt_ (- 1.0 (square X)))) Sgn)))))
  
 (define asin-h
   X -> (while-asin 3 X X (* X X)))
   
 (define while-asin
   I P Sum X2 ->  Sum  where  (small-enough? P)
   I P Sum X2 -> (let Ptmp (/ (* (* P X2) (- I 2)) (- I 1))
               (while-asin (+ I 2) Ptmp (+ Sum (/ Ptmp I)) X2)))
                              
(define acos
  X -> (- (value pi_halved) (asin X)))
  
\* =====================================================*\

(define transf 
  X -> (/ (- 1.0 X) (+ 1.0 X)))
  

(define atan 
  X -> (let Sgn (sign X)
            X (abs X)
            (if (> X 1.0) (* (atan_gt1 X) Sgn)
                          (* (atan_lt1 X) Sgn))))
(define atan_gt1
  X -> (- (value pi_quarter) (atan_lt1 (transf X))))


(define atan_lt1
  X -> (let Sgn (sign X)
            X (abs X)
            (if (> X 0.4142) 
                (* (- (value pi_quarter) (atan-h (transf X)) ) Sgn)
                (*(atan-h X) Sgn)) ) )
(define atan-h
  X -> (while-atan 3 X X -1 (* X X)))
  
(define while-atan 
  I P Sum Sgn X2 ->  Sum  where  (small-enough? P)
  I P Sum Sgn X2 -> (let Ptmp  (* P X2) 
               (while-atan (+ I 2) Ptmp (+ Sum (* (/ Ptmp I) Sgn)) (- 0 Sgn) X2)))

                 
 