function I = Na_Current(G, P_O, V, E_Na)
    I = G.*P_O.*(V - E_Na);
end
