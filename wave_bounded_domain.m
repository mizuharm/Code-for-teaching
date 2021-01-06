%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Wave equation visualizer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Visualize solutions to
%   u_tt = C^2 u_xx
%   u(x,0) = f(x)
%   u_t(x,0)= g(x)
%
%   Simply use explicit solution
%   u(x,t) = 1/2(f(x-Ct)+f(x+Ct) 
%            + 1/(2C) int_{x-Ct}^{x+Ct} g(s)ds
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

%%%%%%%%%%%%%%%%%%%%%%
%% Parameters
%%%%%%%%%%%%%%%%%%%%%%

    x = 0:.01:pi;
    t = 0:.01:10;
    
    [X,T] = meshgrid(x,t);
    
    u = zeros(size(X));
%%%%%%%%%%%%%%%%%%%%%%
%% Initial conditions
%%%%%%%%%%%%%%%%%%%%%%

    f = @(x) sin(x)+.2*sin(2*x)+.3*sin(3*x);
    %f = @(x) .1*exp(-(x-pi/2).^2/.1);
    g = @(x) 0;
    
%%%%%%%%%%%%%%%%%%%%%%%
%% Solution
%%%%%%%%%%%%%%%%%%%%%%%
    
    a = zeros(1000,1);
    b = a;
    for n = 1:100
        a(n) = 2/pi*integral(@(s) f(s).*sin(n*s),0,pi);
        b(n) = 2/(n*pi)*integral(@(s) g(s).*sin(n*s),0,pi);

        u = u + (b(n)*sin(n*pi*T)+a(n)*cos(n*pi*T)).*sin(n*X);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualize 
%%%%%%%%%%%%%%%%%%%%%%%%%

fig=figure();

 set(fig, 'Position',  [100 206 1100 420])
    
    for j = 1:length(t)
        if mod(j,10)==0
            clf
            
            subplot(1,2,1)
                hold on
                plot(x,u(j,:))
                hold off
                xlabel('x','interpreter','latex')
                ylabel('u','interpreter','latex')
                abc=gca;
                abc.FontSize = 16;
                axis([x(1) x(end) min(min(u)) max(max(u))])
            subplot(1,2,2)
                hold on
                s=surf(X,T,u,'FaceAlpha',.5);
                s.EdgeColor = 'none';
                angle = -30+.01*j;
                view(angle,45)
                xlabel('x','interpreter','latex')
                ylabel('t','interpreter','latex')
                zlabel('u','interpreter','latex')
                plot3(x,t(j)*ones(1,length(x)), u(j,:))
                abc=gca;
                abc.FontSize = 16;
                hold off
            pause(0)
        end
    end
    
%%%%%%%%%%%%%%%%%%%%
%% Final image
%%%%%%%%%%%%%%%%%%%%
    clf

    subplot(1,2,1)
        plot(x,u(end,:))
        xlabel('x','interpreter','latex')
        ylabel('u','interpreter','latex')
        abc=gca;
        abc.FontSize = 16;
        
    subplot(1,2,2)
        hold on
        s=surf(X,T,u);
        s.EdgeColor = 'none';
        view(angle,45)
        xlabel('x','interpreter','latex')
        ylabel('t','interpreter','latex')
        zlabel('u','interpreter','latex')
        abc=gca;
        abc.FontSize = 16;
        hold off