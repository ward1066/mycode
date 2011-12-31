(datatype num 
  if (number? N) 
  ____________ 
  N : (num N); 
  M : (num M); N : (num N); 
  _________________________ 
  (+ M N) : (num (M + N));) 
  

(define myadd 
  {(num M) --> (num N) --> (num (M + N))} 
   M N -> (+ M N)) 

(datatype negnum
   N : (num N) < 0;
   ____________________
   N : (negnum N);

   M : (negnum M);
   ____________________
   (* M M) : (negnum (M * M));)

(define negsqr
   {(negnum N) --> (num (N*N))}
   N -> (* N N))