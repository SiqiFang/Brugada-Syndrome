function a=am(v) %Alpha for m gate
a=0.1*(v+40)/(1-exp(-(v+40)/10));
end
