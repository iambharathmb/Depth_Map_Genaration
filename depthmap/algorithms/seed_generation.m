function [nlabels, labels, idx] = seed_generation(mod_img,scale)

if nargin<2, scale = 1; end;

ref=im2double(mod_img); ref = imresize(ref,scale);
%L{1} = find(ref(:,:,1)==0.4 & ref(:,:,2)==1.0 & ref(:,:,3)==1.0); % R  stores the indices of all pixels which are red to L{1}
%L{2} = find(ref(:,:,1)==0.0 & ref(:,:,2)==1.0 & ref(:,:,3)==1.0); % G
%L{3} = find(ref(:,:,1)==0.0 & ref(:,:,2)==0.0 & ref(:,:,3)==1.0);
% L{1} = find(ref(:,:,1)==0.23 & ref(:,:,2)==0.44 & ref(:,:,3)==0.34);
% L{2} = find(ref(:,:,1)==1.0 & ref(:,:,2)==0.6 & ref(:,:,3)==0.78);

 L{2} = find(ref(:,:,1)==0.0 & ref(:,:,2)==1.0 & ref(:,:,3)==1.0);
 L{1} = find(ref(:,:,1)==1.0 & ref(:,:,2)==0.0 & ref(:,:,3)==1.0); % B
 L{3} = find(ref(:,:,1)==0.0 & ref(:,:,2)==1.0 & ref(:,:,3)==0.0);
 L{4} = find(ref(:,:,1)==1.0 & ref(:,:,2)==0.6 & ref(:,:,3)==1.0);
 L{5} = find(ref(:,:,1)==0.6 & ref(:,:,2)==0.4 & ref(:,:,3)==1.0);
 L{6} = find(ref(:,:,1)==0.4 & ref(:,:,2)==0.6 & ref(:,:,3)==0.0);

num = 0;
nlabels = 0;
for i=1:6
    nL = size(L{i},1);  %no of individual color pixels are stored in nL 
    if nL > 0             % if nL>0 then nlabel is incremented so for red nlabel=1 for green 2,for blue nlabel=3
        nlabels = nlabels + 1;
        labels(num+1:num+nL) = nlabels; %an array labels is created in which for red, labels(1)=1,labels(2)=2..etc upto label(nL)  simlilarly for green labels(nL+1)=2,labels(nL+2)=2...etc 
        idx(num+1:num+nL) = L{i}; % idx is similar to lablels bt is stores the original indices of the individual colors at each location from 1 to nL 
        num = num + nL;
    end;
end;
