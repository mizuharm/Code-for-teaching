%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Explicit solver heat equation %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Goal: solve
%         u_t = k u_xx,  0<x<L, t>0
%         u(0,t) = 0, u(L,t) = 0
%         u(x,0) = f(x)
%
%   Method: Forward time, centered space finite differences
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%
%% Parameters
%%%%%%%%%%%%%%%%%%%%

    k = 5; %diffusion coefficient

    L = pi; %length of domain
    T = .2; %final time
    
    dx = .1; %space step
    dt = .001; %time step
    
    x = 0:dx:L;
    t = 0:dt:T;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initial condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %f = -abs(x-1)+1;
     f = sin(3*x);   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialize u
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    u = f';
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Forward step matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    iterMat = diag((1-2*dt*k/(dx)^2)*ones(length(x),1));
    iterMat = iterMat +diag(dt*k/(dx)^2*ones(length(x)-1,1),1);
    iterMat = iterMat +diag(dt*k/(dx)^2*ones(length(x)-1,1),-1);
    
    iterMat(1,:) = zeros(length(x),1);
    iterMat(end,:) = zeros(length(x),1);
    
    for i = 2:length(t)
        u(:,i) = iterMat*u(:,i-1);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [X,T] = meshgrid(x,t);
 
    fig=figure();

    set(fig, 'Position',  [100 206 1100 420])
       
    for i = 1:length(t)
        clf
        subplot(1,2,1)
        plot(x,u(:,i))
        a = gca;
        a.FontSize = 16;
        axis([0 L min(f) max(f)])
    
        subplot(1,2,2)
        hold on
        s=surf(X,T,u');
        s.EdgeColor = 'none';
        angle = 30+.05*i;
        view(angle,25)
        xlabel('x','interpreter','latex')
        ylabel('t','interpreter','latex')
        zlabel('u','interpreter','latex')
        plot3(x,t(i)*ones(length(x),1),u(:,i))
        a = gca;
        a.FontSize = 16;
        hold off
        pause(0)
    end