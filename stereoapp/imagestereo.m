function img=imagestereo(L,R)

hIdtc = vision.ImageDataTypeConverter;
hCsc = vision.ColorSpaceConverter('Conversion','RGB to intensity');


img_L=L;
if(length(size(img_L))==2)
    img_L=repmat(img_L,[1 1 3]);
end


img_R=R;
if(length(size(img_R))==2)
    img_R=repmat(img_R,[1 1 3]);
end


leftI3chan = step(hIdtc,img_L);
leftI = step(hCsc,leftI3chan);
rightI3chan = step(hIdtc,img_R);
rightI = step(hCsc,rightI3chan);


figure(2), clf;
imshowpair(rightI,leftI,'ColorChannels','red-cyan'), axis image;
saveas(gcf, 'savedImage.jpg', 'jpg');
img=imread('SavedImage.jpg');
