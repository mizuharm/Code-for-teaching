%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Inhomogeneous transport equation visualizer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Visualize solutions to
%   u_t + C u_x = f(x,t)
%   u(x,0) = g(x)
%
%   Simply use explicit solution
%   u(x,t) = g(x-Ct) + int_0^t f(x+C(z-t),z)dz
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%
%% Parameters
%%%%%%%%%%%%%%%%%%%%%%

    x = -10:.1:10;
    t = 0:.01:10;

    c = 1;
    
%%%%%%%%%%%%%%%%%%%%%%
%% Initial conditions
%%%%%%%%%%%%%%%%%%%%%%

    g = @(s) exp(-s.^2);

%%%%%%%%%%%%%%%%%%%%%%
%% Inhomogeneous term
%%%%%%%%%%%%%%%%%%%%%%

    f = @(x,t) x+t;

%%%%%%%%%%%%%%%%%%%%%%%
%% Solution
%%%%%%%%%%%%%%%%%%%%%%%

    [X,T] = meshgrid(x,t);
    
    %Inhomogeneous part
    
    int_term = @(a,b,z) f(a+c*(z-b),z);
    
    syms a b z
    int_term =matlabFunction(int(int_term,z,0,b));
    
    
        u = g(X-c.*T)+int_term(X,T);
        
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualize 
%%%%%%%%%%%%%%%%%%%%%%%%%

fig=figure();

 set(fig, 'Position',  [100 206 1100 420])
    
    for j = 1:length(t)
        if mod(j,10)==0
            clf
            
            subplot(1,2,1)
                plot(x,u(j,:))
                xlabel('x','interpreter','latex')
                ylabel('u','interpreter','latex')
                a=gca;
                a.FontSize = 16;
            subplot(1,2,2)
                hold on
                s=surf(X,T,u,'FaceAlpha',.5);
                s.EdgeColor = 'none';
                angle = -30+.01*j;
                view(angle,45)
                xlabel('x','interpreter','latex')
                ylabel('t','interpreter','latex')
                zlabel('u','interpreter','latex')
                plot3(x,t(j)*ones(1,length(x)),g(x-c.*t(j))+int_term(x,t(j)))
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
        plot(x,u(end,:))
        xlabel('x','interpreter','latex')
        ylabel('u','interpreter','latex')
        a=gca;
        a.FontSize = 16;
        
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