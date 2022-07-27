function [Left,Right]=split_img(img)
n=fix(size(img,2)/2);
A=img(:,1:n,:);
B=img(:,n+1:end,:);
Left =A;
Right=B;