%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bessel function demo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Visualize solutions to
%   u_t = k \Delta u on circular disk
%   u(x,0) = f(|x|)
%   u(R,0) = 0
%
%   1. Plot Bessel function J_0
%   2. Use Bessel function orthogonal expansion
%       to solve equation.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    clear

%%%%%%%%%%%%%%%%%%%%%%
%% Parameters
%%%%%%%%%%%%%%%%%%%%%%

    num = 3; %Number of eigenfunctions in expansion
    
    k = .25; %Heat coefficient
    
    R = 1; %Radius of disk
   
    zn_vec = besselzero(0,num,1); %Zeros of Bessel_0(z)    plot(z,besselj(0,z));
    
    lambda_vec = zn_vec.^2/R.^2; %Eigenvalues
    
    x = 0:.01:R; %Radial variable
    t = 0:.01:5; %Time variable
    theta = 0:.1:2*pi+.1; %Theta variable
    
    [X2,Theta] = meshgrid(x,theta);
    
    u = zeros(length(x),1);
    
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot Bessel function
%%%%%%%%%%%%%%%%%%%%%%%%%

    figure()

    z = 0:.01:20;
    
    hold on 
        plot(z,besselj(0,z));
        plot(zn_vec,zeros(length(zn_vec),1),'.');
        text(zn_vec(1)+.2,0,'z_1','FontSize',14)
        text(zn_vec(2)+.2,0,'z_2','FontSize',14)
        text(zn_vec(3)+.2,0,'z_3','FontSize',14)
    hold off
    
    xlabel('$x$','interpreter','latex')
    ylabel('$J_0(x)$','interpreter','latex')
    title('Bessel function, $J_0$','interpreter','latex')
    abc= gca;
    abc.FontSize = 16;
     
    pause()
   
%%%%%%%%%%%%%%%%%%%%%%
%% Initial conditions
%%%%%%%%%%%%%%%%%%%%%%

    f = @(s) 5*s.^3.*(1-s);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Coefficient calculations
%%%%%%%%%%%%%%%%%%%%%%%%%%%

    c = zeros(length(lambda_vec),1);
    for n = 1:length(c)
        c(n) = integral(@(s) f(s).*besselj(0,zn_vec(n)*s/R).*s,0,R);
        c(n) = c(n)/integral(@(s) besselj(0,zn_vec(n)*s/R).^2.*s,0,R);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%
%% Solve and plot 
%%%%%%%%%%%%%%%%%%%%%%%%%

    fig=figure();

    set(fig, 'Position',  [100 206 1100 420])

    for i = 1:length(t)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Generalized Fourier expansion with Bessel functions
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            u = zeros(1,length(x));
            for n = 1:length(c)
                u = u + c(n)*besselj(0,zn_vec(n)*x/R).*exp(-lambda_vec(n)*k*t(i));
            end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Translate to Cartesian coordinates 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            u = repmat(u,[length(theta),1]);
            [xx,yy,u_cart] = pol2cart(Theta,X2,u);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Plot solution
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            clf

            subplot(1,2,1)
                hold on
                s=surf(xx,yy,u_cart);
                s.EdgeColor = 'none';
                angle = -30+.05*i;
                view(angle,45)
                caxis([0 .3])
                xlabel('x','interpreter','latex')
                ylabel('y','interpreter','latex')
                zlabel('u(x,y)','interpreter','latex') 
                title('Heat evolution with radial symmetry','interpreter','latex')
                axis([-x(end) x(end) -x(end) x(end) 0 1])
                abc=gca;
                abc.FontSize = 16;
                hold off
            subplot(1,2,2)
                hold on
                plot(x,u)
                hold off
                xlabel('r','interpreter','latex')
                ylabel('u(r,t)','interpreter','latex')
                abc=gca;
                abc.FontSize = 16;
                title('Radial component','interpreter','latex')
                axis([x(1) x(end) 0 1])
                
            pause(0)
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Auxiliary functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function x=besselzero(n,k,kind)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %
        % besselzero.m
        %
        % Find first k positive zeros of the Bessel function J(n,x) or Y(n,x) 
        % using Halley's method.
        %
        % Written by: Greg von Winckel - 01/25/05
        % Contact: gregvw(at)chtm(dot)unm(dot)edu
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        k3=3*k;

        x=zeros(k3,1);

        for j=1:k3

            % Initial guess of zeros 
            x0=1+sqrt(2)+(j-1)*pi+n+n^0.4;

            % Do Halley's method
            x(j)=findzero(n,x0,kind);

            if x(j)==inf
                error('Bad guess.');
            end
        end

        x=sort(x);
        dx=[1;abs(diff(x))];
        x=x(dx>1e-8);
        x=x(1:k);
     end

    function x=findzero(n,x0,kind)

        n1=n+1;     

        % Tolerance
        tol=1e-12;

        % Maximum number of times to iterate
        MAXIT=100;

        % Initial error
        err=1;

        iter=0;

        while abs(err)>tol && iter<MAXIT
            switch kind
                case 1
                    a=besselj(n,x0);    
                    b=besselj(n1,x0);   
                case 2
                    a=bessely(n,x0);
                    b=bessely(n1,x0);
            end

            x02=x0*x0;

            err=2*a*x0*(n*a-b*x0)/(2*b*b*x02-a*b*x0*(4*n+1)+(n*n1+x02)*a*a);

            x=x0-err;
            x0=x;
            iter=iter+1;
        end

        if iter>MAXIT-1
            warning('Failed to converge to within tolerance. ',...
                    'Try a different initial guess');
            x=inf;    
        end
    end