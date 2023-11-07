%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualize Oscillator
%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Visualize solutions to ay'' +by'+cy = f(x)
%
%  Explicit Euler timestep:
%  y' =w;
%  w' = -b/a w - c/a y + f(x)
%%%%%%%%%%%%%%%%%%%%%%%%%

function runOscillator()


    close all
    
    %%%%%%%%%%%%%%%%%%%%%%%
    %% Coefficients of ODE 
    %%%%%%%%%%%%%%%%%%%%%%%
        a = 1;  
        b = 0;
        c = 4;

    %Initial conditions
        y0 = 1;
        y0prime = 1;
        t = 0; 

    %Timestep data
        dt = .001;
        endTime = 40;
        i = 1; %timestep index

        
    
    %Solution vectors
        yCur = y0;
        yCurPrime = y0prime;
        tVec = t;

    %Integration
    while t<endTime
        t = t+dt;
        yCur(i+1) = yCur(i) + dt*yCurPrime(i);
        yCurPrime(i+1) =yCurPrime(i) + dt*(-b/a*yCurPrime(i)-c/a*yCur(i) + myF(t));
        tVec(i+1) = t;
 
        i = i+ 1;
    end
 
    
    %Create text for solution
    
    disc = b^2-4*a*c; %discriminant

    if disc < 0 %complex roots
        realPart= -b/(2*a);
        imagPart = sqrt(-disc)/(2*a);

        if imagPart ==1
            imagPart = [];
        end

        if realPart == 0
            solnString1 = ['\sin(',num2str(imagPart),'t)'];
            solnString2 = ['\cos(',num2str(imagPart),'t)$'];
        elseif realPart == 1
            solnString1 = ['e^{t}\sin(',num2str(imagPart),'t)'];
            solnString2 = ['e^{t}\cos(',num2str(imagPart),'t)$'];
        elseif realPart == -1
             solnString1 = ['e^{-t}\sin(',num2str(imagPart),'t)'];
             solnString2 = ['e^{-t}\cos(',num2str(imagPart),'t)$'];           
        else
            solnString1 = ['e^{',num2str(realPart),'t}\sin(',num2str(imagPart),'t)'];
            solnString2 = ['e^{',num2str(realPart),'t}\cos(',num2str(imagPart),'t)$'];
        end
        
 
        
    elseif disc == 0 %repeated root

        realPart = -b/(2*a);
        if realPart==1
            solnString1 = 'e^{t}';
            solnString2 = 'te^{t}$';
        elseif realPart == -1
             solnString1 = 'e^{-t}';
            solnString2 = 'te^{-t}$';
        elseif realPart ==0
            solnString1 = '';
            solnString2 = 't$';
        else 
            solnString1 = ['e^{',num2str(realPart),'t}'];
            solnString2 = ['te^{',num2str(realPart),'t}$'];
        end

    else %real roots

         r1 = (-b+sqrt(disc))/(2*a);
         r2 = (-b-sqrt(disc))/(2*a);

         if r1 == 0
             solnString1 = '';
         elseif r1 ==1
             solnString1 = 'e^{t}';
         elseif r1 ==-1
             solnString1 = 'e^{-t}';
         else
             solnString1 = ['e^{',num2str(r1),'t}'];
         end
         if r2 ==0
             solnString2 ='$';
         elseif r2 ==1
             solnString2 = 'e^{t}$';
         elseif r2 == -1
             solnString2 = 'e^{-t}$';
         else
             solnString2 = ['e^{',num2str(r2),'t}$'];
         end
    end

    %Text of complementary solution:
    solnString = ['Complementary solution: $C_1',solnString1,'+C_2',solnString2];


    %Text of ODE problem
    [~,ystr] = myF(t);  
    if b==0 && c~=0
        ODEString = ['ODE: $', num2str(a),'\ddot{y}+',...
        num2str(c),'y=',ystr,'$'];
    elseif c==0 && b~=0
        ODEString = ['ODE: $', num2str(a),'\ddot{y}+',num2str(b),'\dot{y}='...
         ,ystr,'$'];
    elseif b==0 && c==0
         ODEString = ['ODE: $', num2str(a),'\ddot{y}=',ystr,'$'];
    else
        ODEString = ['ODE: $', num2str(a),'\ddot{y}+',num2str(b),'\dot{y}+',...
        num2str(c),'y=',ystr,'$'];
    end
       



        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% First figure: time series, solution text
        %% Second Figure: moving mass + spring
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %set figure size depending on screensize
        fig1 = figure(1);
        screensize = get( groot, 'Screensize' );
        startx = screensize(1)+screensize(3)/4;
        starty = screensize(2)+screensize(4)/4;

        fig1.Position = [startx starty screensize(4)*4/4 screensize(4)*2/4];

        %Plot results
        for i = 1:300:length(tVec)
            clf
            subplot(1,2,1)
            plot( tVec(1:i),yCur(1:i),'b.');
            axis([0 endTime min(yCur)-(max(yCur)-min(yCur))*.2 (max(yCur)-min(yCur))*.2+max(yCur)])
             title(ODEString,'interpreter','latex')
            text(tVec(floor(length(tVec)/10)),(max(yCur)-min(yCur))*.1+max(yCur),solnString,'interpreter','latex')
            fontsize(gcf,12,"points")
            xlabel('$t$','interpreter','latex')
            ylabel('$y(t)$','interpreter','latex')
 
            subplot(1,2,2)
            
            hold on
            springDraw(max(yCur),yCur(i),myF(tVec(i)))
            plot(0,yCur(i),'b.','MarkerSize',60)
            hold off
            axis([-1 1 min(yCur)-(max(yCur)-min(yCur))*.2 (max(yCur)-min(yCur))*.2+max(yCur)])
            fontsize(gcf,12,"points")
            drawnow

        end

end




%%%%%%%%%%%%%%%%%%%%%%%%
%% Aux functions
%%%%%%%%%%%%%%%%%%%%%%%%

function [y,ystr] = myF(t)

    y = sin(2*t);
    ystr = '\sin(2t)';
    %y = exp(-t);
    %ystr = 'e^{-t}';
end


function springDraw(top,ycur,force)
    numLoops = 20;
    t = pi/2:.01: numLoops*pi-pi/2;
    
    plot(1/numLoops*cos(t),top-.1/numLoops*sin(t)-(top-ycur)/(numLoops*pi)*t,'k')
    quiver(.2,ycur,0,force,2,'LineWidth',4)
    text(.3,ycur+2*force/2,'F')

end



