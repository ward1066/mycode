/In a technique passed on by Simon Garland, you can get a more useful display of relevant information when a function is suspended. Define a function, say zs, as follows,
/        zs:{`d`P`L`G`D!(system"d"),v[1 2 3],enlist last v:value x}
/This function takes another function as its argument and returns a dictionary with entries for the current directory, function parameters, local variables referenced, global variables referenced and the function definition. 
/We demonstrate this with a trivial example. 
/b:7
/        f:{a:6;x+a*b}
/
/       f[100]                / this is OK
/142 
/        f[`100]                / this is an error
/{a:6;x+a*b} 
/'type 
/+ 
/`00 
/42 
/        zs f                / see what's what
zs:{`d`P`L`G`D!(system"d"),v[1 2 3],enlist last v:value x}