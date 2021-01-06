%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fourier sine series
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Function to represent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    f = @(x) abs(1-x);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Interval 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    LHS = 0;
    RHS = 2;
    
    L = (RHS - LHS);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Number of terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    N = 100;
    
    a = zeros(N,1);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for i = 1:N
        g = @(x) f(x).*sin(i*pi/L*x);
        a(i) = 2/L*integral(g,LHS,RHS);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Series representation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Target
    x = LHS:.01:RHS;
    y = f(x);
    
    %Series approximations
    u = 0;
    
    for i = 1:N
        i_string = num2str(i);
        u = u+a(i)*sin(i*pi/L*x);
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
    u = 0;
    
    for i = 1:N
        i_string = num2str(i);
        u = u+a(i)*sin(i*pi/L*x);
        plot(x,y,'--',x,u,'-')
        fig = gca;
        fig.FontSize = 16;    
        title_str = strcat(i_string,'th Fourier approximation');
        title(title_str)
        pause(.1)
    end