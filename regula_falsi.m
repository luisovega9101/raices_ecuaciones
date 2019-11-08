function []=regula_falsi(f,a,b,error)
%% SE DEBE DECLARAR SIMBÓLICA LA VARIABLE DE LA FUNCIÓN (f)
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
else
    n_iter=1000;
    if sum(size(error))~=2
        error('La tolerancia debe ser un escalar.'); 
    end
end

%% Teorema
if subs(f,a)*subs(f,b)>0
    error('Imposible de aplicar el metodo: note que --> f(a)*f(b)>0');
end

%% Metodo de Regula Falsi
  n = 1;
  i(n)=n;
  %el comando vpa procede a evaluar con la precisión solicitada (si es posible)
  x(n) = a - (subs(f,a)*(b-a)/(subs(f,b)-subs(f,a)));
  E(n) = abs(b - a);
  ya = subs(f,a);
  yx = subs(f,x(n));
  while (E >=error) & (n<n_iter)
      if (yx==0) 
          fprintf('La raiz es exactamente: %f',x(n));
          break;
      end
      if (ya*yx < 0) 
          b = x(n); 
      else
          a = x(n);
      end
       n = n + 1;
       i(n)=n;
       x(n) = a - (subs(f,a)*(b-a)/(subs(f,b)-subs(f,a)));
       E(n) = abs(x(n)-x(n-1));
       ya = subs(f,a);
       yx = subs(f,x(n));
  end
  
%% Formateo de las salidas
  Tabla = [i', x', E'];
  disp('-----------|-------------|------------|');
  disp(' Iteración   Aproximación   Error ')
  disp('-----------|-------------|------------|');
  disp(Tabla)
  disp('-----------|-------------|------------|');
  
end