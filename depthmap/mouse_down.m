function mouse_down(imagefig,varargins)
global glb_handles;
global mouse_state;
global last_point;
xlim = get(gca, 'XLim');
ylim = get(gca, 'YLIm');
temp = get(gca,'currentpoint');
if(temp(1,1)<xlim(1) || temp(1,1)>xlim(2) || temp(1,2)<ylim(1) || temp(1,2)>ylim(2))
    return;
end
mouse_state=1;
last_point = [temp(1,1), temp(1,2)];