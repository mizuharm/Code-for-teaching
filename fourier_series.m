%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fourier sine series
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to represent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    f = @(x) heaviside(x)+1;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Interval 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    LHS = -pi;
    RHS = pi;
    
    L = (RHS - LHS)/2;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Number of terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    N = 100;
    
    a = zeros(N,1);
    b = zeros(N,1);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    a0 = 1/(2*L)*integral(f,LHS,RHS);
    
    for i = 1:N
        g = @(x) f(x).*cos(i*pi/L*x);
        a(i) = 1/L*integral(g,LHS,RHS);
    end
    

    for i = 1:N
        g = @(x) f(x).*sin(i*pi/L*x);
        b(i) = 1/L*integral(g,LHS,RHS);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Series representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Target
    x = LHS:.001:RHS;
    y = f(x);
    
    %Series approximations
    u = a0;
    
    for i = 1:N
        i_string = num2str(i);
        u = u+a(i)*cos(i*pi/L*x)+b(i)*sin(i*pi/L*x);
        plot(x,y,'--',x,u,'-')
        fig = gca;
        fig.FontSize = 16;    
        title_str = strcat(i_string,'th Fourier approximation');
        title(title_str)
        pause(.1)
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Extension of representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    figure(2)
    %Target
    x = -2*RHS:.01:2*RHS;
    y = f(x);
    
    %Series approximations
    u = a0;
    
    for i = 1:N
        i_string = num2str(i);
        u = u+a(i)*cos(i*pi/L*x)+b(i)*sin(i*pi/L*x);
        plot(x,y,'--',x,u,'-')
        fig = gca;
        fig.FontSize = 16;    
        title_str = strcat(i_string,'th Fourier approximation');
        title(title_str)
        pause(.1)
    end