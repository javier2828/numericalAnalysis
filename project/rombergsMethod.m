function y = rombergsMethod(a,b,m,n);

 %the following lines are for checking for impossible cases
if m < 0 || n < m
    fprintf('error')
    return
end

syms f(x) %creation of symbolic function
f = symfun((1-cos(x))/x,x);

h = 1/(2^n)*(b-a); %height of the trapezoid

if m == 0 %lines 14 to 17 outline the trapezoid rule
    y = h/2*(0+f(b)); %division by zero hurt matlabs brain. setting f(a) to zero
    for j = 1:(2^n-1)
        y = y+h*f(a+h*j);
    end  
else %line 19 describes the richardson extrapolation iterative solution
    y = 1/(4^m-1)*(4^m*rombergsMethod(a,b,m-1,n)-rombergsMethod(a,b,m-1,n-1));
end
y = vpa(y,6); %formats the answer
        
    
