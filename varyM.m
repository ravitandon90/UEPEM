Packet_Size = 4000; % packet size 500 Bytes => 4000 bits.
Packet_Transmission_Cost = 50 * (10 ^ -9); % Packet Transmission Cost = 50 nano Joule per Bit per Packet
Amplification_Energy_Multi_Path = 13 * (10 ^ -16);   % Packet Amplification Cost = 0.0013 pico Joule per Bit per metre squared
Amplification_Energy_Free_Space = 10  * (10 ^ (-12)); % 
Energy_Data_Aggregation = 5 * (10 ^ -9);
Num_Sensors = 1000;
Area_Net = 100 * 100;
Radius_Net = sqrt(Area_Net/pi);
total_Energy_EPEM = zeros (M, 1);
total_Energy_UEPEM = zeros (M, 1);
for M = 1 : 20
    total_Energy_EPEM (M) = run_EPEM (Packet_Size, Packet_Transmission_Cost, Amplification_Energy_Multi_Path, Amplification_Energy_Free_Space, Energy_Data_Aggregation, Num_Sensors, Area_Net, Radius_Net, M);
    total_Energy_UEPEM (M) = run_UEPEM (Packet_Size, Packet_Transmission_Cost, Amplification_Energy_Multi_Path, Amplification_Energy_Free_Space, Energy_Data_Aggregation, Num_Sensors, Area_Net, Radius_Net, M);
end

figure (1);
plot (total_Energy_EPEM(:));
hold on;
plot (total_Energy_UEPEM(:));