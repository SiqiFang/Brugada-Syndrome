function IK1 = fastK(v) % Calculation of fast K current
IK1 = (1200*exp((-v-90)/50) + 15*exp((v+90)/60));
end