%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Using Monte Carlo to calculate pi
%
%
%  
%
%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


N_in = 0;
N_out = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Make plots of circle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Circle
    circ_ind = 0:.01:2*pi;
    circ_x = .5*cos(circ_ind);
    circ_y = .5*sin(circ_ind);
    
    %Square
    x = [-.5 .5 .5 -.5 -.5];
    y = [-.5 -.5 .5 .5 -.5];
    
    %Plot
    hold on
    plot(circ_x,circ_y,'r-','LineWidth',3)
    plot(x,y,'r-')
    pbaspect([1 1 1])
    drawnow
    
%%%%%%%%%%%%%%%%%%%%%%%
%% Monte Carlo
%%%%%%%%%%%%%%%%%%%%%%

while 1==1
    
    pt = rand(2,1)-.5;
    
    plot(pt(1),pt(2),'b.')
    
    if(norm(pt)<.5)
        N_in = N_in+1;
    else
        N_out = N_out+1;
    end

    pi_approx = 4*N_in/(N_out+N_in);
    
    pi_title = num2str(pi_approx,20);
    
    if mod(N_in,1000)==0 %%Speed up
        title(strcat('\pi \approx ', {' '}, pi_title))
            plot(circ_x,circ_y,'r-','LineWidth',3)
            plot(x,y,'r-')
        drawnow
    end
end

