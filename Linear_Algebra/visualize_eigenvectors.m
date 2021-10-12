%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualization of eigenvectors in 2D
%
%
% User inputs 2 x 2 matrix, A
% Program tracks location of user's mouse
% on 2D plane as an input vector x
% Plots x and Ax simultaneously
%
%
% Written by Matthew S. Mizuhara
%            The College of New Jersey
%            October 11, 2021
%
% Inspired by David K Watson Mathematica Demonstration EigenvectorsIn2D
% https://demonstrations.wolfram.com/EigenvectorsIn2D/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function visualize_eigenvectors()

    clear
    close all
    pause(0)
    
    C = zeros(2,3); %mouse location matrix
    A = [1 1 ;0 1]; %transformation matrix
    theta_vec = 0:.01:2*pi; %vector for plotting circles
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 1: GUI
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %Make GUI figure and set dimensions
        fig = figure('Name','Eigenvector Explorer','NumberTitle','off');
        set(fig,'Position',[100 250 400 150])
        set(fig, 'MenuBar', 'none');
        set(fig, 'ToolBar', 'none');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 2: Visualization plane
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

        %Make plot figure and set dimensions
        fig2 = figure('Name','','NumberTitle','off');
        set(fig2, 'MenuBar', 'none');
        set(fig2, 'ToolBar', 'none');
        set(fig2,'Position',[600 100 600 500])
        set(fig2, 'WindowButtonMotionFcn', @mouseMove);
        title('Move your cursor on the plane to visualize inputs and outputs',...
            'interpreter','latex')
        plot_circles()
        format_plot()
                  

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set up Figure 1 Buttons, boxes, etc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %User defined matrix
            hh=uicontrol(fig,'Style','text');
            hh.String = 'A=';
            hh.FontSize =12;
            hh.Position= [0 50 60 40];
            
            hh1=uicontrol(fig,'Style','text');
            hh1.String = '[';
            hh1.FontSize =60;
            hh1.Position= [50 40 10 100];
            
            hh2=uicontrol(fig,'Style','text');
            hh2.String = ']';
            hh2.FontSize =60;
            hh2.Position= [120 40 10 100];

            h1 = uicontrol(fig,'Style','edit');
            h1.String = '1';
            h1.Position = [60 80 30 30];
            h1.FontSize =12;

            h2 = uicontrol(fig,'Style','edit');
            h2.String = '1';
            h2.Position = [90 80 30 30];
            h2.FontSize =12;
          
            h3 = uicontrol(fig,'Style','edit');
            h3.String = '0';
            h3.Position = [60 50 30 30];
            h3.FontSize =12;
             
            h4 = uicontrol(fig,'Style','edit');
            h4.String = '1';
            h4.Position = [90 50 30 30];
            h4.FontSize =12;

 
            %Button to run transformation
            h5 = uicontrol(fig,'Style','pushbutton');
            h5.Position= [200 60 160 40];
            h5.String = {'Set new matrix'};
            h5.Callback = @set_matrix;
            h5.FontSize =12;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Set new matrix
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            function set_matrix(~,~)
        
            %User defined matrix
                        A = [str2num(h1.String),str2num(h2.String);...
                            str2num(h3.String),str2num(h4.String)];

                        close(fig2)
                        fig2 = figure('Name','','NumberTitle','off');
                        set(fig2, 'MenuBar', 'none');
                        set(fig2, 'ToolBar', 'none');
                        set(fig2,'Position',[600 100 600 500])
                        set(fig2, 'WindowButtonMotionFcn', @mouseMove);
                        title('Move your cursor on the plane to visualize inputs and outputs',...
                        'interpreter','latex')
                        plot_circles()
                        format_plot()
                        
            end
         
            function mouseMove (~,~)
            %from https://www.mathworks.com/matlabcentral/answers/97563-how-do-i-continuously-read-the-mouse-position-as-the-mouse-is-moving-without-a-click-event
            
                        C = get(gca, 'CurrentPoint');
                        pt = [round(C(1,1),2);round(C(1,2),2)];
                        img = A*pt;
                        pause(0)
                        clf
                        hold on
                        quiver(0,0,pt(1),pt(2),0,'LineWidth',2)
                        quiver(0,0,img(1),img(2),0,'LineWidth',2)
                        plot_circles()                
                        hold off
                        format_plot()
                        title(gca, ['$(X_1,X_2) = ($', num2str(pt(1)), ', ',num2str(pt(2)), '$)$'],'interpreter','latex');

            end
            
        
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Plot concentric circles
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            
            function plot_circles()
                hold on
                plot(cos(theta_vec),sin(theta_vec),'b--')
                plot(2*cos(theta_vec),2*sin(theta_vec),'b--')
                plot(3*cos(theta_vec),3*sin(theta_vec),'b--')
                hold off
            end
        
            function format_plot()
                axis([-3 3 -3 3])
                xlabel('$X_1$','interpreter','latex')
                ylabel('$X_2$','interpreter','latex')
                set(gca,'FontSize',14)
                     
            end
end