function a=an(v)%Alpha for n gate
a=0.01*(v+50)/(1-exp(-(v+50)/10));
end