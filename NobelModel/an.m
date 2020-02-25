function a=an(v)%Alpha for n gate
a=0.1*(-v-50)/(exp(-(v+50)/10)-1);
end