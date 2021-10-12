%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Plot slope field and trajectories %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% This program allows you to plot slope fields
% and sample trajectories from a specified initial
% condition. Once a slope field is plotted, trajectories
% can be plotted by either mouse-click on the slope field
% itself, or by using the GUI interface. Trajectories can
% be extended forward in time, backward in time, or
% in both directions. 
%
%
%
% Author: Matthew S. Mizuhara
% E-mail: mizuharm@tcnj.edu
% Institution: The College of New Jersey
% Date Created: March 2020
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function direction_field()

    clear
    close all
    
    trajNum = 0; %trajNum keeps track of which trajectory is plotted

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 1: GUI
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        fig = figure(1);
        set(fig,'Position',[100 400 500 200])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 2: Direction field 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Set up initial direction field upon open
        figure(2)
        set(gcf,'Position',[600 100 600 500])
        
        f = @(x,y) x.^2+y; %Default function
   
        xmin = -5;
        xmax = 5;
        ymin = -5;
        ymax = 5;
        
        x = linspace(xmin,xmax,21);
        y = linspace(ymin,ymax,21);

        %This step duplicates the vectors to create matrices
        %which will allow us to more easily call ordered pairs (x,y)

        [x,y] = meshgrid(x,y);

        %We now compute the slopes at each point 
        %using our function f defined above
        %For technical reasons we require dx and dy components

        dy = f(x,y); %Vertical component of each tangent line
        dx = ones(size(dy)); %Horizontal component of each tangent line (assumed to be 1)

        %For visualization, we additionally make all tangent lines uniform length
        dy_unit = dy./(sqrt(dx.^2+dy.^2))/3;
        dx_unit = dx./(sqrt(dx.^2+dy.^2))/3;

        %We use the MATLAB function "quiver" to plot
        %the direction field for the function f defined 
        %above.

        hold on
        q=quiver(x,y,dx_unit,dy_unit);
        q.ShowArrowHead = 'off';
        q.AutoScale = 'off';
        axis([xmin, xmax, ymin, ymax]);

        eqn = func2str(f);%changes to a char array
        eqn2 = eqn(7:end);%removes the '@(x,y) handle
        eqn_fix = replace(eqn2,'.',''); %removes the . used for multiplication
        eqn_fix = replace(eqn_fix,'*',''); %removes * used for multiplication
        title_str = strcat('$\frac{dy}{dx} = ',eqn_fix,'$');
        title(title_str,'interpreter','latex','FontSize',13);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set up Figure 1 Buttons, boxes, etc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %User defined direction field
            hh=uicontrol(fig,'Style','text');
            hh.String = 'dy/dx=';
            hh.FontSize =12;
            hh.Position= [0 120 60 40];

            h = uicontrol(fig,'Style','edit');
            h.String = 'x^2+y';
            h.Position = [60 130 160 40];
            h.FontSize =12;

            h1 = uicontrol(fig,'Style','pushbutton');
            h1.Position= [300 130 160 40];
            h1.String = {'Plot direction field'};
            h1.Callback = @plot_direction_field;
            h1.FontSize =12;

        %Function to plot new direction field
            function plot_direction_field(~,~)
                function_def = h.String;
                function_def = strcat('@(x,y) ', function_def);

                function_def = replace(function_def,'*','.*');

                function_def = replace(function_def,'^','.^');

                function_def = replace(function_def,'/','./');

                f = str2func(function_def);

                clf(2)

                figure(2)

                x = linspace(xmin,xmax,21);
                y = linspace(ymin,ymax,21);

                [x,y] = meshgrid(x,y);

                dy = f(x,y); %Vertical component of each tangent line
                dx = ones(size(dy)); %Horizontal component of each tangent line (assumed to be 1)
                dy_unit = dy./(sqrt(dx.^2+dy.^2))/3;
                dx_unit = dx./(sqrt(dx.^2+dy.^2))/3;

                hold on
                q=quiver(x,y,dx_unit,dy_unit);
                q.ShowArrowHead = 'off';
                q.AutoScale = 'off';
                axis([xmin, xmax, ymin, ymax]);

                eqn = func2str(f);%changes to a char array
                eqn2 = eqn(7:end);%removes the '@(x,y) handle
                eqn_fix = replace(eqn2,'.',''); %removes the . used for multiplication
                eqn_fix = replace(eqn_fix,'*',''); %removes * used for multiplication
                title_str = strcat('$\frac{dy}{dx} = ',eqn_fix,'$');
                title(title_str,'interpreter','latex','FontSize',13);
            end

        %Choose direction of trajectory
            c = uicontrol(fig,'Style','popupmenu');
            c.Position = [100 65 100 40];
            c.String = {'Forward','Backward','Both'};
            c.FontSize = 12;

            c1 = uicontrol(fig,'Style','text');
            c1.String = {'Trajectory'; 'direction:'};
            c1.Position = [0 70 90 40];
            c1.FontSize = 12;

        %Undo last trajectory button
            d = uicontrol(fig,'Style','pushbutton');
            d.Position = [300 70 160 40];
            d.String = {'Undo last trajectory'};
            d.Callback = @plotButtonPushed;
            d.FontSize = 12;

        %Function to undo last trajectory
            function plotButtonPushed(~,~)
                if(trajNum>1)
                    delete(curPlot{trajNum-1})
                    trajNum=trajNum-1;
                end
            end

        %User input initial condition
            p = uicontrol(fig,'Style','text');
            p.String = {'Initial';'condition:'};
            p.FontSize = 12;
            p.Position = [0 10 80 40];

            p1 = uicontrol(fig,'Style','text');
            p1.String = '( ';
            p1.FontSize = 12;
            p1.Position = [90 10 10 30];

            p2 = uicontrol(fig,'Style','edit');
            p2.String = '0';
            p2.FontSize = 12;
            p2.Position = [100 15  40 30]; 

            p3 = uicontrol(fig,'Style','text');
            p3.String = ',';
            p3.FontSize = 12;
            p3.Position = [140 15 20 30];

            p4 = uicontrol(fig,'Style','edit');
            p4.String = '0';
            p4.FontSize = 12;
            p4.Position = [160 15 40 30];

            p5 = uicontrol(fig,'Style','text');
            p5.String = ')';
            p5.FontSize = 12;
            p5.Position = [200 10 10 30];

            p6 = uicontrol(fig,'Style','pushbutton');
            p6.Position= [300 10 160 40];
            p6.String = {'Plot trajectory'};
            p6.Callback = @plot_initial_condition;
            p6.FontSize =12;

        %Function to plot trajectory from initial condition
            function plot_initial_condition(~,~)

                x0 = str2double(p2.String);
                y0 = str2double(p4.String);

                if(c.Value ==1) %Forward only
                    figure(2)
                    %x_part1 = [x0,xmin];
                    x_part2 = [x0, xmax];
                    %[x1,y1] = ode45(@(x,y) f(x,y),x_part1,y0);
                    [x2,y2] = ode45(@(x,y) f(x,y),x_part2,y0);
                    curPlot{trajNum} = strcat('h',num2str(trajNum));
                    curPlot{trajNum} = plot(x0,y0,'k.',x2,y2,'r-','MarkerSize',13);
                    axis([xmin, xmax, ymin, ymax]);
                end

                if(c.Value ==2 ) %Backward only
                    figure(2)
                    x_part1 = [x0,xmin];
                    %x_part2 = [x0, xmax];
                    [x1,y1] = ode45(@(x,y) f(x,y),x_part1,y0);
                    %[x2,y2] = ode45(@(x,y) f(x,y),x_part2,y0);
                    curPlot{trajNum} = strcat('h',num2str(trajNum));
                    curPlot{trajNum} = plot(x0,y0,'k.',x1,y1,'r-','MarkerSize',13);
                    axis([xmin, xmax, ymin, ymax]);
                end

                if(c.Value ==3 ) %Both directions
                    figure(2)
                    x_part1 = [x0,xmin];
                    x_part2 = [x0, xmax];
                    [x1,y1] = ode45(@(x,y) f(x,y),x_part1,y0);
                    [x2,y2] = ode45(@(x,y) f(x,y),x_part2,y0);
                    curPlot{trajNum} = strcat('h',num2str(trajNum));
                    curPlot{trajNum} = plot(x0,y0,'k.',x1,y1,'r-',x2,y2,'r-','MarkerSize',13);
                    axis([xmin, xmax, ymin, ymax]);
                end
                trajNum = trajNum+1;
            end
         
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Plot trajectories based on mouse click
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        while true %Allows user to plot arbitrarily many trajectories

            trajNum= trajNum+1;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% User clicks on plot to specify initial condition
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
                [x0,y0] = ginput(1);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Plot trajectories based on user click
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                if(c.Value ==1) %Forward only
                        figure(2)
                        %x_part1 = [x0,xmin];
                        x_part2 = [x0, xmax];
                        %[x1,y1] = ode45(@(x,y) f(x,y),x_part1,y0);
                        [x2,y2] = ode45(@(x,y) f(x,y),x_part2,y0);
                        curPlot{trajNum} = strcat('h',num2str(trajNum));
                        curPlot{trajNum} = plot(x0,y0,'k.',x2,y2,'r-','MarkerSize',13);
                        axis([xmin, xmax, ymin, ymax]);
                end
                
                if(c.Value ==2 ) %Backward only
                        figure(2)
                        x_part1 = [x0,xmin];
                        %x_part2 = [x0, xmax];
                        [x1,y1] = ode45(@(x,y) f(x,y),x_part1,y0);
                        %[x2,y2] = ode45(@(x,y) f(x,y),x_part2,y0);
                        curPlot{trajNum} = strcat('h',num2str(trajNum));
                        curPlot{trajNum} = plot(x0,y0,'k.',x1,y1,'r-','MarkerSize',13);
                        axis([xmin, xmax, ymin, ymax]);
                end
                
                if(c.Value ==3 ) %Both directions
                        figure(2)
                        x_part1 = [x0,xmin];
                        x_part2 = [x0, xmax];
                        [x1,y1] = ode45(@(x,y) f(x,y),x_part1,y0);
                        [x2,y2] = ode45(@(x,y) f(x,y),x_part2,y0);
                        curPlot{trajNum} = strcat('h',num2str(trajNum));
                        curPlot{trajNum} = plot(x0,y0,'k.',x1,y1,'r-',x2,y2,'r-','MarkerSize',13);
                        axis([xmin, xmax, ymin, ymax]);
                end
        end
end
