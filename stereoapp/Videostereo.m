function Videostereo(path,file)
vid=VideoReader([path,file]);
n=vid.NumberOfFrames;
global anaglyph;
for i=1:200
    fram=read(vid,i);
    [L,R]=split_img(fram);
    anaglyph{i}=imagestereo(L,R);
end
 writerObj = VideoWriter('myVideo.avi');
 writerObj.FrameRate = 16;
 % set the seconds per image
%  secsPerImage = [5 10 15];
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for u=1:length(anaglyph)
     % convert the image to a frame
     frame = im2frame(anaglyph{u});
%      for v=1:secsPerImage(u) 
     writeVideo(writerObj, frame);
%      end
 end