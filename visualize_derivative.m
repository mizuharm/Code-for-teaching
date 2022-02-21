%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualizing derivative of e^x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function visualize_derivative()

    clear
    close all
    
    
    xbounds = [-1, 3]; %min and max x values
    ybounds = [-1, 3]; %min and max y values
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 1: GUI
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %Make GUI figure and set dimensions
        fig = figure('Name','Derivative Explorer','NumberTitle','off');
        set(fig,'Position',[100 320 500 280])
        set(fig, 'MenuBar', 'none');
        set(fig, 'ToolBar', 'none');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 2: Function visualization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

        %Make plot figure and set dimensions
        fig2 = figure('Name','','NumberTitle','off');
        set(fig2, 'MenuBar', 'none');
        set(fig2, 'ToolBar', 'none');
        set(gcf,'Position',[600 100 600 500])
        

        cur_func_plot = plot(0,0); %create plot object for function
        cur_point1_plot = plot(0,0); %create plot for point 1
        cur_point2_plot = plot(0,0); 
        cur_secant_line = plot(0,0);
        %Plot the axes
        plot_axes(xbounds,ybounds)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set up Figure 1 Buttons, boxes, etc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %User defined function
            hh=uicontrol(fig,'Style','text');
            hh.String = 'f(x)=';
            hh.FontSize =12;
            hh.Position= [20 160 60 40];
            
            
            h1 = uicontrol(fig,'Style','edit');
            h1.String = 'x^2';
            h1.Position = hh.Position+ [60 10 60 0];
            h1.FontSize =12;
            
       %User chosen base point and dx
            h2=uicontrol(fig,'Style','text');
            h2.String = 'a=';
            h2.FontSize =12;
            h2.Position= [20 100 60 40];
            
            h3=uicontrol(fig,'Style','edit');
            h3.String = '0';
            h3.FontSize =12;
            h3.Position= h2.Position+[60 10 0 0];            


            h4=uicontrol(fig,'Style','text');
            h4.String = 'dx=';
            h4.FontSize =12;
            h4.Position= [240 100 60 40];
            

            %Slider
            h6 = uicontrol(fig,'Style','slider','Min',-1,'Max',1,'SliderStep',[0.01 0.10]);
            h6.Position = [250 80 140 20];
            h6.Value = 0.201;
            h6.Callback = @plot_secant_line;
   
            
            h5=uicontrol(fig,'Style','text');
            h5.String = num2str(h6.Value);
            h5.FontSize =12;
            h5.Position= [300 100 80 40];
            
            
            
            %Button to plot function
            h7 = uicontrol(fig,'Style','pushbutton');
            h7.Position= [250 170 160 40];
            h7.String = {'Plot new function'};
            h7.Callback = @plot_function;
            h7.FontSize =12;
           
            

            
            %Secant line slope display
            h8=uicontrol(fig,'Style','text');
            h8.String = 'Secant line slope = ';
            h8.FontSize =12;
            h8.Position= [220 0 160 40];
            
            h9=uicontrol(fig,'Style','text');
            h9.String = '0';
            h9.FontSize =12;
            h9.Position= h8.Position+ [160 0 -100 0];
            
                        
            %Function evaluation display
            h10=uicontrol(fig,'Style','text');
            h10.String = 'f(a) = ';
            h10.FontSize =12;
            h10.Position= [0 35 80 40];
            
            h11=uicontrol(fig,'Style','text');
            h11.String = '0';
            h11.FontSize =12;
            h11.Position= h10.Position+ [100 0 0 0];
            
            h12=uicontrol(fig,'Style','text');
            h12.String = 'f(a+dx) = ';
            h12.FontSize =12;
            h12.Position= [0 0 80 40];
            
            h13=uicontrol(fig,'Style','text');
            h13.String = '0';
            h13.FontSize =12;
            h13.Position= h12.Position+ [100 0 0 0];
            
            
            
            %Instructions
            
            hz=uicontrol(fig,'Style','text');
            hz.String = 'Choose your own function f(x) and base point a where you want to compute the derivative.';
            hz.FontSize =12;
            hz.Position= [000 220 fig.Position(3) 50];            

            plot_function()
            plot_secant_line()

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Functions for the transformation GUI
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function plot_function(~,~)
            %Input: str - string from GUI defining function
            str = h1.String;
            cur_func_str = ['@(x)', str]; %make anonymous function
            cur_func = str2func(cur_func_str);
            
            xvec = xbounds(1):.01:xbounds(2);
            for j = 1:length(xvec)
                   yvec(j) = cur_func(xvec(j));
            end
            
            delete(cur_func_plot)
            delete(cur_point1_plot)
            figure(2)
            pause(0)
            cur_func_plot = plot(xvec,yvec,'k-','LineWidth',2);
            cur_point1_plot = plot(str2num(h3.String),cur_func(str2num(h3.String)),'r.','MarkerSize',30);
plot_secant_line()
                   end
        
    function plot_secant_line(~,~)
            %Input: str - string from GUI defining function
            str = h1.String;
            cur_func_str = ['@(x)', str]; %make anonymous function
            cur_func = str2func(cur_func_str);
            
             %Plot secant line
             x1 = str2num(h3.String);
             y1 = cur_func(str2num(h3.String));
             x2 = x1+h6.Value;
             y2 = cur_func(x2);
             
             h5.String = num2str(h6.Value);
             h11.String = num2str(y1);
             h13.String = num2str(y2);

             figure(2)
             pause(0)
             delete(cur_point2_plot)
             delete(cur_secant_line)
             
             cur_point2_plot = plot(x2,y2,'r.','MarkerSize',30);
             
             slope  = (y2-y1)/(x2-x1);
                          h9.String = num2str(slope);
             
             yleft = slope*(xbounds(1) - x1) + y1; %secant line evaluated at x=xmin
             yright = slope*(xbounds(2) - x1) + y1;%secant line evaluated at x=xmax

             cur_secant_line = plot([xbounds(1) xbounds(2)],[yleft yright],'r--');
    end

    

        function plot_axes(xbounds,ybounds)
            %Plot x-y axes
            %Input: xbounds = [x1 x2] = min and max x values
            %       ybounds = [y1 y2] = min and max y values
            
            %Move to figure 2 and set bounds
            figure(2)
            clf

            hold on 

            %Plot axes
            plot([xbounds(1) xbounds(2)],[0,0],'b-') %x-axis
            plot([0,0],[ybounds(1) ybounds(2)],'b-') %y-axis
            axis([xbounds(1) xbounds(2) ybounds(1) ybounds(2)]);

            a=gca;
            a.FontSize = 16;
        end

           

end