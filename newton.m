function []=newton(f,a,b,error)
% ---------------------------------------------------------------------
% Esta funcion permite determinar de manera aproximada el valor de la
% raiz de una ecuacion no lineal f(x)=0 mediante el metodo de Newton.
% De manera adicional se proporciona una tabla con el valor de la 
% aproximacion y el error corespondiente en cada iteracion.
%
% Entrada:
% f      --> Funcion simbolica
% a, b   --> Extremos del intervalo
% error  --> Tolerancia del calculo {default | 0.00001}
% n_iter --> Numero maximo de iteraciones {default | 1000}
%
% Ejemplo:
% 
% f=sym('x^2-1'); 
% newton(f,0,3,0.005);
%
% --------|----------|------------|
% Iter.       Aprox.     Error.   
% --------|----------|------------|
% ini        3.0000      3.0000       
% 1          1.6667      1.3333       
% 2          1.1333      0.5333       
% 3          1.0078      0.1255       
% 4          1.0000      0.0078       
% 5          1.0000      0.0000       
% --------|----------|------------|

%% Validacion de la entrada
if (nargin<3)  
    error('Revise los datos de entrada.');
else
    tipo = class(f);
    if all( (tipo(1:3)=='sym')>0 )~=1
        error('La funcion f debe ser simbolica.');
    end

    if sum(size(a))~=2 || sum(size(b))~=2
        error('Los extremos del intervalo deben ser escalares.'); 
    end  
end

if (nargin<4) 
    error=0.00001;
    n_iter=1000;
elseif (nargin<5) 
    n_iter=1000;
    if sum(size(error))~=2
        error('La tolerancia debe ser un escalar.'); 
    end
end

%% Teorema de Bolzano
if subs(f,a)*subs(f,b)>0
    error('Imposible de aplicar el metodo: note que --> f(a)*f(b)>0');
end

%% Metodo de Newton
if subs(f,a)*subs(diff(f,2),a)>0
    x0=a; 
else
    x0=b; 
end

n=1;
E(n)=b-a;
xn(n)=x0;
i(n)=n;
f1= diff(f);

while (E(n)>=error) & (n<n_iter)
    if subs(f,xn(n))==0
        fprintf('La raiz es exactamente: %f',x(n));
        break;
    else
		n=n+1;
		xn(n)=xn(n-1)-(subs(f,xn(n-1))/subs(f1,xn(n-1)));
		E(n)=abs(xn(n)-xn(n-1));
		i(n)=n;
    end    
end

%% Formateo de las salidas
  Tabla = [i', xn', E'];
  disp('-----------|-------------|------------|');
  disp(' Iteración   Aproximación   Error ')
  disp('-----------|-------------|------------|');
  disp(Tabla)
  disp('-----------|-------------|------------|');