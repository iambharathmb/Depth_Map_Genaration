function mouse_move(imagefig,varargins)
global mouse_state;
global glb_handles;
global last_point;
global Seeds;
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthcolor0=[1 0 1];
depthcolor1=[0 1 1];
depthcolor2=[0 1 0];
depthcolor3=[1 0.6 1];
depthcolor4=[0.6 0.4 1];
depthcolor5=[0.4 0.6 0];
% depthcolor6=[0.8 1 1];
% depthcolor7='w';




xlim = get(gca, 'XLim');
ylim = get(gca, 'YLIm');
temp = get(gca,'currentpoint');
temp = [temp(1,1), temp(1,2)];
if(temp(1)<xlim(1) || temp(1)>xlim(2) || temp(2)<ylim(1) || temp(2)>ylim(2))
    return
end

if(mouse_state)
    % should draw scribbles on roi
    mouse_botton = get(gcbf, 'SelectionType');
    if (depthselect0==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor0,'MarkerSize',10,'Parent',glb_handles.axes1);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp,1);
        end
    elseif(depthselect1==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor1,'MarkerSize',10,'parent',glb_handles.axes1);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp, 2);
        end
    elseif(depthselect2==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor2,'MarkerSize',10);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp, 3);
        end
    elseif(depthselect3==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor3,'MarkerSize',10);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp,4);
        end
    elseif(depthselect4==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor4,'MarkerSize',10);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp, 5);
        end
    elseif(depthselect5==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor5,'MarkerSize',10);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp, 6);
        end
    elseif(depthselect6==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor6,'MarkerSize',10);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp, 7);
        end
    elseif(depthselect7==1)
        if(strcmp(mouse_botton,'normal')) % left mouse bottom
            hold on;
            p=plot([last_point(1), temp(1)],[last_point(2), temp(2)],'color',depthcolor7,'MarkerSize',10);
            set(p(1),'linewidth',2);
            Seeds = draw_line_on_img(Seeds, last_point, temp, 8);
        end
    end
        
        
%     elseif(strcmp(mouse_botton,'alt')) % right mouse bottom
%         hold on;
%         p=plot([last_point(1), temp(1)],[last_point(2), temp(2)], 'b','MarkerSize',10);
%         set(p(1),'linewidth',2);
%         Seeds = draw_line_on_img(Seeds, last_point, temp, 255);
%     end
    last_point = temp;
end
ui_update();

function Ilab = draw_line_on_img(I, p1, p2, lab)
[H, W]=size(I);
Ilab = I;
Hdiff = abs(p2(2)-p1(2));
Wdiff = abs(p2(1)-p1(1));
if(Hdiff>Wdiff)
    step = 1.0/(Hdiff+1);
else
    step = 1.0/(Wdiff+1);
end
for i = step:step:1
    p = p1*(1.0-i)+p2*i;
    Ilab(int16(p(2)),int16(p(1)))=lab;
    if(min(H,W)>40)
        Ilab(int16(p(2)+1),int16(p(1)))=lab;
        Ilab(int16(p(2)-1),int16(p(1)))=lab;
        Ilab(int16(p(2)),int16(p(1))+1)=lab;
        Ilab(int16(p(2)),int16(p(1))-1)=lab;
    end
end

    
