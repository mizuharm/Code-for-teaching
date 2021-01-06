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

%%%%%%%%%%%%%%%%%%%%%%
%% Parameters
%%%%%%%%%%%%%%%%%%%%%%

    x = -10:.1:10;
    t = 0:.01:3;

    c = 3;
    
%%%%%%%%%%%%%%%%%%%%%%
%% Initial conditions
%%%%%%%%%%%%%%%%%%%%%%

    f = @(x) 1./(x.^2+1);
    g = @(x) 0;
    
%%%%%%%%%%%%%%%%%%%%%%%
%% Solution
%%%%%%%%%%%%%%%%%%%%%%%

    syms a b s
    
    int_term = 1/(2*c)*int(g(s),a-c*b,a+c*b);
    
    %int_term = matlabFunction(int_term);
    int_term = @(t,x) 0;
    
    [X,T] = meshgrid(x,t);
      
    u = 1/2*(f(X-c.*T)+f(X+c.*T)) + ...
        int_term(X,T);
        

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
                plot(x,1/2*f(x-c.*t(j)),'--',x,1/2*f(x+c.*t(j)),'--')
                hold off
                xlabel('x','interpreter','latex')
                ylabel('u','interpreter','latex')
                a=gca;
                a.FontSize = 16;
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
                plot3(x,t(j)*ones(1,length(x)),1/2*(f(x-c.*t(j))+f(x+c.*t(j))) + ...
                        int_term(x,t(j)))
                a=gca;
                a.FontSize = 16;
                hold off
            pause(0)
        end
    end
    
%%%%%%%%%%%%%%%%%%%%
%% Final image
%%%%%%%%%%%%%%%%%%%%
    clf

    subplot(1,2,1)
%         plot(x,u(end,:))
%         xlabel('x','interpreter','latex')
%         ylabel('u','interpreter','latex')
%         a=gca;
%         a.FontSize = 16;
        hold on
        s=surf(X,T,u);
        s.EdgeColor = 'none';
        view(angle,45)
        xlabel('x','interpreter','latex')
        ylabel('t','interpreter','latex')
        zlabel('u','interpreter','latex')
        a=gca;
        a.FontSize = 16;
        hold off
        
    subplot(1,2,2)
        hold on
        s=surf(X,T,u);
        s.EdgeColor = 'none';
        view(angle,45)
        xlabel('x','interpreter','latex')
        ylabel('t','interpreter','latex')
        zlabel('u','interpreter','latex')
        a=gca;
        a.FontSize = 16;
        hold off