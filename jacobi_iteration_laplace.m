%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Jacobi iteration to solve Laplace %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Goal: solve
%         u_xx+u_yy = 0,  0<x<L, 0<y<M
%         u(0,y) = a, u(L,y) = b
%         u(x,0) = c, u(x,M) = d
%
%   Method: Center space finite difference with Jacobi iterations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%
%% Parameters
%%%%%%%%%%%%%%%%%%%%

    L = 1; %length of domain (x)
    M = 1; %width of domain  (y)
    
    dx = .01; %space step (assumed to be equal to dy)
    
    x = 0:dx:L;
    y = 0:dx:M;
    
%%%%%%%%%%%%%%%%%%%%%%
%% Boundary conditions
%%%%%%%%%%%%%%%%%%%%%%
    
    a = sin(pi*x);
    b = 3*x.*(x-1);
    c = -sin(pi*x);
    d = -3*x.*(x-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialize u
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    u = zeros(length(x),length(y));
    
%%%%%%%%%%%%%%%%%%%
%% Initialize plot
%%%%%%%%%%%%%%%%%%%%

    [X,Y] = meshgrid(x,y);
 
    fig=figure();

    set(fig, 'Position',  [100 206 600 420])
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Implement Jacobi iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Let u(i,j) correspond u(x_i, y_j)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Boundary conditions
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %Left edge (x = 0)
        u(1,:) = a;

        %Right edge (x = L)
        u(end,:) = b;

        %Bottom edge (y = 0)
        u(:,1) = c;

        %Top edge (y = M)
        u(:,end) = d;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Jacobi iteration
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for k = 1:10000 %number of times to perform Jacobi iteration
        
        v = u; %v is the old matrix to be updated to u
        
        for i = 2:length(x)-1
            for j = 2:length(y)-1
                u(i,j) = 1/4*(v(i+1,j)+v(i-1,j)+v(i,j+1)+v(i,j-1));

            end
        end
        if mod(k,100)==0
            clf
            hold on
            s=surf(X,Y,u);
            s.EdgeColor = 'none';
            angle = 30+.001*k;
            view(angle,25)
            xlabel('x','interpreter','latex')
            ylabel('y','interpreter','latex')
            zlabel('u','interpreter','latex')
            hold off
            abc = gca;
            abc.FontSize = 16;
            pause(0)
        end
    end
            
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
       
        clf
        hold on
        s=surf(X,Y,u);
        s.EdgeColor = 'none';
        angle = 30+.001*k;
        view(angle,25)
        xlabel('x','interpreter','latex')
        ylabel('y','interpreter','latex')
        zlabel('u','interpreter','latex')
        hold off

        abc = gca;
        abc.FontSize = 16;
        hold off
        pause(0)
  