%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualization of span in 3D
%
%
% User inputs 3 vectors in R^3
% Can plot either 1 or many random linear combinations of those vectors
% After many are plotted, user can visualize the spanned subspace
%
%
%
% Written by Matthew S. Mizuhara and Nicholas A. Battista
%            The College of New Jersey
%            Feb 3, 2023
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function visualize_span()

    clear
    close all

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 1: GUI
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %Make GUI figure and set dimensions
        fig = figure('Name','Span Explorer','NumberTitle','off');
        set(fig,'Position',[50 250 620 200])
        set(fig, 'MenuBar', 'none');
        set(fig, 'ToolBar', 'none');
        

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set up Figure 1 Buttons, boxes, etc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %%%%%%%%%
            %Vector1
            %%%%%%%%%
            g1=uicontrol(fig,'Style','text');
            g1.String = 'v1=';
            g1.FontSize =12;
            g1.Position= [0 80 60 40];
            
            g11=uicontrol(fig,'Style','text');
            g11.String = '[';
            g11.FontSize =85;
            g11.Position= [50 50 10 140];
            
            g12=uicontrol(fig,'Style','text');
            g12.String = ']';
            g12.FontSize =85;
            g12.Position= [90 50 10 140];

            h11 = uicontrol(fig,'Style','edit');
            h11.String = '1';
            h11.Position = [60 120 30 30];
            h11.FontSize =12;

            h12 = uicontrol(fig,'Style','edit');
            h12.String = '0';
            h12.Position = [60 90 30 30];
            h12.FontSize =12;

            h13 = uicontrol(fig,'Style','edit');
            h13.String = '0';
            h13.Position = [60 60 30 30];
            h13.FontSize =12;

            vec1 = [str2num(h11.String);str2num(h12.String);str2num(h13.String)];
             

            %%%%%%%%%%
            %Vector 2
            %%%%%%%%%%
            g2=uicontrol(fig,'Style','text');
            g2.String = 'v2=';
            g2.FontSize =12;
            g2.Position= [100 80 60 40];

            g21=uicontrol(fig,'Style','text');
            g21.String = '[';
            g21.FontSize =85;
            g21.Position= [150 50 10 140];
            
            g22=uicontrol(fig,'Style','text');
            g22.String = ']';
            g22.FontSize =85;
            g22.Position= [190 50 10 140];

            h21 = uicontrol(fig,'Style','edit');
            h21.String = '0';
            h21.Position = [160 120 30 30];
            h21.FontSize =12;
          
            h22 = uicontrol(fig,'Style','edit');
            h22.String = '1';
            h22.Position = [160 90 30 30];
            h22.FontSize =12;
           
            h23 = uicontrol(fig,'Style','edit');
            h23.String = '0';
            h23.Position = [160 60 30 30];
            h23.FontSize =12;

            vec2 = [str2num(h21.String);str2num(h22.String);str2num(h23.String)];
                
            %%%%%%%%%%
            %Vector 3
            %%%%%%%%%%
            g3=uicontrol(fig,'Style','text');
            g3.String = 'v3=';
            g3.FontSize =12;
            g3.Position= [200 80 60 40];

            g31=uicontrol(fig,'Style','text');
            g31.String = '[';
            g31.FontSize =85;
            g31.Position= [250 50 10 140];
            
            g32=uicontrol(fig,'Style','text');
            g32.String = ']';
            g32.FontSize =85;
            g32.Position= [290 50 10 140];

            h31 = uicontrol(fig,'Style','edit');
            h31.String = '0';
            h31.Position = [260 120 30 30];
            h31.FontSize =12;
          
            h32 = uicontrol(fig,'Style','edit');
            h32.String = '0';
            h32.Position = [260 90 30 30];
            h32.FontSize =12;
           
            h33 = uicontrol(fig,'Style','edit');
            h33.String = '1';
            h33.Position = [260 60 30 30];
            h33.FontSize =12;
 
            vec3 = [str2num(h31.String);str2num(h32.String);str2num(h33.String)];
         
            %Button to generate 1 linear combination
            h5 = uicontrol(fig,'Style','pushbutton');
            h5.Position= [320 80 270 40];
            h5.String = {'Generate 1 linear combination'};
            h5.Callback = @generate_one_lin_combo;
            h5.FontSize =12;
            
            %Button to generate many linear combinations
            h6 = uicontrol(fig,'Style','pushbutton');
            h6.Position= [320 20 270 40];
            h6.String = {'Generate 1000 linear combinations'};
            h6.Callback = @generate_lin_combos;
            h6.FontSize =12;

            %Button to plot new basis vectors
            h7 = uicontrol(fig,'Style','pushbutton');
            h7.Position= [320 140 270 40];
            h7.String = {'Set new vectors'};
            h7.Callback = @plot_original_vectors;
            h7.FontSize =12;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Figure 2: Visualization plane
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

                %Make plot figure and set dimensions
                fig2 = figure('Name','','NumberTitle','off');
                gca;
                fig2axes = fig2.CurrentAxes;
                set(fig2,'Position',[700 100 600 500])
                tempa=[];
                tempb=[];
                tempc=[];
 
                plot_original_vectors()
               

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Generate many new linear combinations
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        function generate_lin_combos(~,~)
    
            if exist('tempa','var')
                delete(tempa)
                delete(tempb)
                delete(tempc)
            end
    
            i = 1;
            Q = orth([vec1, vec2, vec3]); %create orthogonal basis of range, helps prevent bias in sampling coefficients
            
            while i<100
                coef = 6*rand(rank(Q),10)-3; %random coefficients between [-3,3]
    
                pt = Q*coef;
    
                if gcf == fig  %if wrong figure is clicked, change figure to plane
                    figure(2)
                end
    
                hold on
                plot3(fig2axes,pt(1,:),pt(2,:),pt(3,:),'r.','MarkerSize',10)
                hold off
    
                drawnow
                i = i+1;
            end
        end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Generate one new linear combination
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        function generate_one_lin_combo(~,~)
                
                if exist('tempa','var')
                    delete(tempa)
                    delete(tempb)
                    delete(tempc)
                end

                coef = 4*rand(3,1)-2; %3 random coefficients between [-2,2]

                
                pt = [vec1 vec2 vec3]*coef;

                while max(pt)>2 %off figure
                    coef = 4*rand(3,1)-2; %3 random coefficients between [-2,2]
                    pt = [vec1 vec2 vec3]*coef;
                end

                if gcf == fig  %if wrong figure is clicked, change figure to plane
                    figure(2)
                end

                pt1 = vec1*coef(1);
                pt2 = vec2*coef(2);
                pt3 = vec3*coef(3);

                hold on
                tempa=quiver3(fig2axes,0,0,0,pt1(1),pt1(2),pt1(3),0,'Color',[.8,.4,.1],'LineWidth',2);
                tempb=quiver3(fig2axes,pt1(1),pt1(2),pt1(3),pt2(1),pt2(2),pt2(3),0,'Color',[.8,.4,.1],'LineWidth',2);
                tempc=quiver3(fig2axes,pt1(1)+pt2(1),pt1(2)+pt2(2),pt1(3)+pt2(3),pt3(1),pt3(2),pt3(3),0,'Color',[.8,.4,.1],'LineWidth',2);  
                plot3(fig2axes,pt(1),pt(2),pt(3),'r.','MarkerSize',10)
                hold off

                drawnow
            end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Plot original vectors
    %%%%%%%%%%%%%%%%%%%%%%%%%%
            
        function plot_original_vectors(~,~) 
    
                    if exist('fig2','var')
                       try close(fig2)
                       catch
                       end
                        fig2 = figure('Name','','NumberTitle','off');
                        gca;
                        fig2axes = fig2.CurrentAxes;
                        set(fig2,'Position',[700 100 600 500])
                    end
                    vec1 = [str2num(h11.String);str2num(h12.String);str2num(h13.String)];
                    vec2 = [str2num(h21.String);str2num(h22.String);str2num(h23.String)];
                    vec3 = [str2num(h31.String);str2num(h32.String);str2num(h33.String)];
                    hold on 
                    quiver3(fig2axes,0,0,0,vec1(1),vec1(2),vec1(3),0,'k--','LineWidth',3)
                    text(vec1(1),vec1(2),vec1(3),'{\bf v}_1','FontSize',17)
                    quiver3(fig2axes,0,0,0,vec2(1),vec2(2),vec2(3),0,'k--','LineWidth',3) 
                    text(vec2(1),vec2(2),vec2(3),'{\bf v}_2','FontSize',17)
                    quiver3(fig2axes,0,0,0,vec3(1),vec3(2),vec3(3),0,'k--','LineWidth',3) 
                    text(vec3(1),vec3(2),vec3(3),'{\bf v}_3','FontSize',17)
                    plot3([-2,2],[0,0],[0,0],'b-')
                    plot3([0,0],[-2,2],[0,0],'b-')
                    plot3([0,0],[0,0],[-2,2],'b-')
                    hold off
                    view(-20,40)
                    format_plot()
        end



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Format plane for visualization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function format_plot()
            axis([-2 2 -2 2 -2 2])
            xlabel('$x_1$','interpreter','latex')
            ylabel('$x_2$','interpreter','latex')
            zlabel('$x_3$','interpreter','latex')
            current_a=gca;
            current_a.XTick = [-2,-1,0,1, 2];
            current_a.YTick = [-2,-1,0,1,2];
            current_a.ZTick = [-2,-1,0,1,2];
            
            set(fig2axes,'FontSize',16)
                 
        end
end