%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualization of linear combinations in 2D
%
%
% User inputs 2 vectors
% Program tracks location of user's mouse
% on 2D plane
% Plots mouse vector as a linear combination of the original vectors
%
%
% Written by Matthew S. Mizuhara
%            The College of New Jersey
%            Jan 27, 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function visualize_linear_combination()

    clear
    close all
    pause(0)
    
    C = zeros(2,3); %mouse location matrix
 
    vec1 = [2,0];
    vec2 = [1,1];
 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 1: GUI
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %Make GUI figure and set dimensions
        fig = figure('Name','Linear Combination Explorer','NumberTitle','off');
        set(fig,'Position',[100 250 400 150])
        set(fig, 'MenuBar', 'none');
        set(fig, 'ToolBar', 'none');
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 2: Visualization plane
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

        %Make plot figure and set dimensions
        fig2 = figure('Name','','NumberTitle','off');
        gca;
        fig2axes = fig2.CurrentAxes;
        set(fig2, 'MenuBar', 'none');
        set(fig2, 'ToolBar', 'none');
        set(fig2,'Position',[600 100 600 500])
        set(fig2, 'WindowButtonMotionFcn', @mouseMove);
        hold on
        plot_original_vectors()
        hold off
        format_plot()
                  

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set up Figure 1 Buttons, boxes, etc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %User defined matrix
            hh=uicontrol(fig,'Style','text');
            hh.String = 'v1=';
            hh.FontSize =12;
            hh.Position= [0 50 60 40];
            
            hh1=uicontrol(fig,'Style','text');
            hh1.String = '[';
            hh1.FontSize =60;
            hh1.Position= [50 40 10 100];
            
            hh2=uicontrol(fig,'Style','text');
            hh2.String = ']';
            hh2.FontSize =60;
            hh2.Position= [90 40 10 100];

            h1 = uicontrol(fig,'Style','edit');
            h1.String = '1';
            h1.Position = [60 80 30 30];
            h1.FontSize =12;

            h3 = uicontrol(fig,'Style','edit');
            h3.String = '3';
            h3.Position = [60 50 30 30];
            h3.FontSize =12;

            g=uicontrol(fig,'Style','text');
            g.String = 'v2=';
            g.FontSize =12;
            g.Position= [100 50 60 40];

             g1=uicontrol(fig,'Style','text');
            g1.String = '[';
            g1.FontSize =60;
            g1.Position= [150 40 10 100];
            
            g2=uicontrol(fig,'Style','text');
            g2.String = ']';
            g2.FontSize =60;
            g2.Position= [190 40 10 100];

            h2 = uicontrol(fig,'Style','edit');
            h2.String = '2';
            h2.Position = [160 80 30 30];
            h2.FontSize =12;
          

             
            h4 = uicontrol(fig,'Style','edit');
            h4.String = '4';
            h4.Position = [160 50 30 30];
            h4.FontSize =12;

 
            %Button to run transformation
            h5 = uicontrol(fig,'Style','pushbutton');
            h5.Position= [220 60 160 40];
            h5.String = {'Set new vectors'};
            h5.Callback = @set_matrix;
            h5.FontSize =12;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Set new matrix
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            function set_matrix(~,~)
        
            %User defined matrix
                        A = [str2num(h1.String),str2num(h2.String);...
                            str2num(h3.String),str2num(h4.String)];
                        if abs(det(A))<10^(-10)
                            %non-invertible-ish; send error
                        close(fig2)
                        fig2 = figure('Name','','NumberTitle','off');
                        gca;
                        fig2axes = fig2.CurrentAxes;
                        format_plot()
                        text(-3,0,'Vectors are too close to co-linear.','FontSize',17)
                        text(-3,-2,'Please try new vectors.','FontSize',17)
                        else
                        
                        vec1 = [A(1,1),A(2,1)];
                        vec2 = [A(1,2),A(2,2)];
                        
                        close(fig2)
                        fig2 = figure('Name','','NumberTitle','off');
                        gca;
                        fig2axes = fig2.CurrentAxes;
                        set(fig2, 'MenuBar', 'none');
                        set(fig2, 'ToolBar', 'none');
                        set(fig2,'Position',[600 100 600 500])
                        set(fig2, 'WindowButtonMotionFcn', @mouseMove);
                        title('Move your cursor on the plane to visualize inputs and outputs',...
                        'interpreter','latex')
                        hold on
                        plot_original_vectors()
                        hold off
                        format_plot()
                        end
            end
         
            function mouseMove (~,~)
            %from https://www.mathworks.com/matlabcentral/answers/97563-how-do-i-continuously-read-the-mouse-position-as-the-mouse-is-moving-without-a-click-event
                        
                        C = get(fig2axes, 'CurrentPoint');
                        pt = [round(C(1,1),2);round(C(1,2),2)];
                        %img = A*pt;
                        %fig2;
                        clf(fig2);
                        axes(fig2);
                        fig2axes = fig2.CurrentAxes;
                        if gcf == fig  %if wrong figure is clicked, change figure to plane
                            figure(2)
                        end
                        hold on
                        quiver(fig2axes,0,0,pt(1),pt(2),0,'Color',[.7 .5 .1],'LineWidth',2)
                        text(pt(1),pt(2),'{\bf x}','FontSize',17)
                        plot_original_vectors() 
                        [comp1,comp2]=plot_lin_combo(pt);
                        hold off
                        format_plot()
                        title(gca, ['${\bf x} = $', num2str(comp1), '${\bf v}_1$ + ',num2str(comp2), '${\bf v}_2$'],'interpreter','latex');

            end
            
        
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Plot original vectors
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            
    function plot_original_vectors()
                quiver(fig2axes,0,0,vec1(1),vec1(2),0,'k--','LineWidth',3)
                text(vec1(1),vec1(2),'{\bf v}_1','FontSize',17)
                quiver(fig2axes,0,0,vec2(1),vec2(2),0,'k--','LineWidth',3) 
                text(vec2(1),vec2(2),'{\bf v}_2','FontSize',17)
    end


            %%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Plot lin combos
            %%%%%%%%%%%%%%%%%%%%%%%%%%
            
    function [component1,component2]=plot_lin_combo(pt)
        %pt is the current point of mouse, column vector
        A = [vec1',vec2', pt];
        B = rref(A); %row reduce to find components
        component1 = B(1,end);
        component2 = B(2,end);

                if component1<=0
                quiver(fig2axes,0,0,component1*vec1(1),component1*vec1(2),0,'b','LineWidth',2)
                else
                  quiver(fig2axes,0,0,component1*vec1(1),component1*vec1(2),0,'r','LineWidth',2)                  
                end

                if component2<=0
                 quiver(fig2axes,0,0,component2*vec2(1),component2*vec2(2),0,'b','LineWidth',2) 
                else
                 quiver(fig2axes,0,0,component2*vec2(1),component2*vec2(2),0,'r','LineWidth',2) 
                end
    end



        
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Format plane for visualization
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            function format_plot()
                axis([-4 4 -4 4])
                xlabel('$x_1$','interpreter','latex')
                ylabel('$x_2$','interpreter','latex')
                current_a=gca;
                current_a.XTick = [-4,-2,0,2, 4];
                current_a.YTick = [-4,-2,0,2,4];
                
                set(fig2axes,'FontSize',16)
                     
            end
end