%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualization of linear transformations in 2D
%%
%%
%% User inputs 2 x 2 matrix of a linear transformation,
%% and the program shows the image of the standard basis vectors
%% along with grid lines under the transformation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function visualize_transformation()

    clear
    close all
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 1: GUI
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %Make GUI figure and set dimensions
        fig = figure('Name','Linear Transformation Explorer','NumberTitle','off');
        set(fig,'Position',[100 350 500 250])
        set(fig, 'MenuBar', 'none');
        set(fig, 'ToolBar', 'none');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 2: Transforming plane
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

        %Make plot figure and set dimensions
        fig2 = figure('Name','','NumberTitle','off');
        set(fig2, 'MenuBar', 'none');
        set(fig2, 'ToolBar', 'none');
        set(gcf,'Position',[600 100 600 500])
        
        %Parameters for "movie"
        A = [1 0 ; 0 1]; %Default matrix
        dt = .01;  %Default timestep
        tend = 1; %Endtime

        t_vec = 0:dt:tend; %vector of timesteps


        %Plot the standard basis vectors and grid
        plot_vectors_and_grid_lines([1;0],[0;1])


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set up Figure 1 Buttons, boxes, etc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %User defined matrix
            hh=uicontrol(fig,'Style','text');
            hh.String = 'A=';
            hh.FontSize =12;
            hh.Position= [0 180 60 40];
            
            hh1=uicontrol(fig,'Style','text');
            hh1.String = '[';
            hh1.FontSize =60;
            hh1.Position= [50 170 10 100];
            
            hh2=uicontrol(fig,'Style','text');
            hh2.String = ']';
            hh2.FontSize =60;
            hh2.Position= [120 170 10 100];

            h1 = uicontrol(fig,'Style','edit');
            h1.String = '1';
            h1.Position = [60 210 30 30];
            h1.FontSize =12;

            h2 = uicontrol(fig,'Style','edit');
            h2.String = '0';
            h2.Position = [90 210 30 30];
            h2.FontSize =12;
          
            h3 = uicontrol(fig,'Style','edit');
            h3.String = '0';
            h3.Position = [60 180 30 30];
            h3.FontSize =12;
             
            h4 = uicontrol(fig,'Style','edit');
            h4.String = '1';
            h4.Position = [90 180 30 30];
            h4.FontSize =12;

            %Button to run transformation
            h5 = uicontrol(fig,'Style','pushbutton');
            h5.Position= [300 190 160 40];
            h5.String = {'Watch transformation'};
            h5.Callback = @show_transformation;
            h5.FontSize =12;
            
            
            %Progress bar
            hh3=uicontrol(fig,'Style','text');
            hh3.String = 'Id';
            hh3.FontSize =12;
            hh3.Position= [0 120 30 40];

            hh4=uicontrol(fig,'Style','text');
            hh4.String = 'A';
            hh4.FontSize =12;
            hh4.Position= [70 120 30 40];

            hh5=uicontrol(fig,'Style','text');
            hh5.String = '*';
            hh5.FontSize =12;
            hh5.Position= [0 115 30 20];   

            %Reset button
            h6 = uicontrol(fig,'Style','pushbutton');
            h6.Position= [300 120 160 40];
            h6.String = {'Reset'};
            h6.Callback = @reset_plot;
            h6.FontSize =12;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Functions for the transformation GUI
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function plot_vectors_and_grid_lines(x,y)
            %Input: vectors x,y and grid lines based on the
            %linear combinations of x and y
            % Vectors x and y should be 2x1 column vectors
            
            %Move to figure 2 and set bounds
            figure(2)
            clf
            axis([-3 3 -3 3])

            hold on 

            %Plot grid lines
            x_line = [-10*x(1) 10*x(1); -10*x(2) 10*x(2)];
            y_line = [-10*y(1) 10*y(1); -10*y(2) 10*y(2)];

            plot(x_line(1,:), x_line(2,:),'b-')
            plot(y_line(1,:), y_line(2,:),'b-')

            for i = 1:10 %Plot all grid lines
                plot(x_line(1,:)+i*y(1),x_line(2,:)+i*y(2),'b-')
                plot(x_line(1,:)-i*y(1),x_line(2,:)-i*y(2),'b-')
                plot(y_line(1,:)+i*x(1),y_line(2,:)+i*x(2),'b-')
                plot(y_line(1,:)-i*x(1),y_line(2,:)-i*x(2),'b-')
            end

            %Plot  vectors
            quiver(0,0,x(1),x(2),'LineWidth',2)
            quiver(0,0,y(1),y(2),'LineWidth',2)

            a=gca;
            a.FontSize = 16;
        end

        function show_transformation(~,~)
            %Creates a "movie" of the transformation
            %Starts from identity and continuously deforms
            %to the matrix A
                
                %User defined matrix
                A = [str2num(h1.String),str2num(h2.String);...
                    str2num(h3.String),str2num(h4.String)];
               
                for i =1:length(t_vec) %loop over time steps
                    t = t_vec(i);

                    %Current image of vectors
                    vec1 = (t*A + (1-t)*eye(2))*[1;0]; 
                    vec2 = (t*A + (1-t)*eye(2))*[0;1]; 

                    plot_vectors_and_grid_lines(vec1,vec2) %plot current vectors

                    
                    %Update the GUI progress bar
                    hh3=uicontrol(fig,'Style','text');
                    hh3.String = 'Id';
                    hh3.FontSize =12;
                    hh3.Position= [0 120 30 40];
                    
                    hh4=uicontrol(fig,'Style','text');
                    hh4.String = 'A';
                    hh4.FontSize =12;
                    hh4.Position= [70 120 30 40];
                    
                    hh5=uicontrol(fig,'Style','text');
                    hh5.String = '*';
                    hh5.FontSize =12;
                    hh5.Position= [70*t_vec(i) 115 30 20];   
                    
                    pause(.01)
                    
          
                    
                end
        end
    
    function reset_plot(~,~)
            %Resets the GUI to original state
            plot_vectors_and_grid_lines([1;0],[0;1])
            
            fig = figure(1);
            clf
            
            %User defined matrix
            hh=uicontrol(fig,'Style','text');
            hh.String = 'A=';
            hh.FontSize =12;
            hh.Position= [0 180 60 40];
            
            hh1=uicontrol(fig,'Style','text');
            hh1.String = '[';
            hh1.FontSize =60;
            hh1.Position= [50 170 10 100];
            
            hh2=uicontrol(fig,'Style','text');
            hh2.String = ']';
            hh2.FontSize =60;
            hh2.Position= [120 170 10 100];

            h1 = uicontrol(fig,'Style','edit');
            h1.String = '1';
            h1.Position = [60 210 30 30];
            h1.FontSize =12;

            h2 = uicontrol(fig,'Style','edit');
            h2.String = '0';
            h2.Position = [90 210 30 30];
            h2.FontSize =12;
          
            h3 = uicontrol(fig,'Style','edit');
            h3.String = '0';
            h3.Position = [60 180 30 30];
            h3.FontSize =12;
             
            h4 = uicontrol(fig,'Style','edit');
            h4.String = '1';
            h4.Position = [90 180 30 30];
            h4.FontSize =12;

            h5 = uicontrol(fig,'Style','pushbutton');
            h5.Position= [300 190 160 40];
            h5.String = {'Watch transformation'};
            h5.Callback = @show_transformation;
            h5.FontSize =12;
            
            
            hh3=uicontrol(fig,'Style','text');
            hh3.String = 'Id';
            hh3.FontSize =12;
            hh3.Position= [0 120 30 40];

            hh4=uicontrol(fig,'Style','text');
            hh4.String = 'A';
            hh4.FontSize =12;
            hh4.Position= [70 120 30 40];

            hh5=uicontrol(fig,'Style','text');
            hh5.String = '*';
            hh5.FontSize =12;
            hh5.Position= [0 115 30 20];   

        %Reset button
            h6 = uicontrol(fig,'Style','pushbutton');
            h6.Position= [300 120 160 40];
            h6.String = {'Reset'};
            h6.Callback = @reset_plot;
            h6.FontSize =12;
    end

end