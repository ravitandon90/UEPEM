function total_Energy = run_UEPEM (Packet_Size, Packet_Transmission_Cost, Amplification_Energy_Multi_Path, Energy_Data_Aggregation, Num_Sensors, Area_Net, Radius_Net, M)
r = Radius_Net/M;
Area_ring = zeros (M, 1);
Cluster_Size_ring = zeros (M, 1);
Num_cluster_heads_ring = zeros (M, 1);
Energy_ring = zeros (M, 1);
Num_Sensors_ring = zeros (M, 1);
Energy_CH_ring = zeros (M, 1);
Energy_Sensor_Node_ring = zeros (M, 1);
for i = 1 : M
    ring = i - 1;
    Area_ring (i) = pi * r^2 * (2*ring+1);
    Num_Sensors_ring (i) = (Num_Sensors * r^2 * (2 *ring+1))/(Radius_Net^2);
    Num_cluster_heads_ring (i) = min(sqrt ((3 * Amplification_Energy_Free_Space * Num_Sensors * (2*ring+1)^3)/((2*Amplification_Energy_Multi_Path)*Radius_Net^2*((ring+1)^6-(ring)^6))), Num_Sensors_ring (i));    
    Cluster_Size_ring (i) = Num_Sensors_ring (i) / Num_cluster_heads_ring (i);
    Z_i = (r^4 * ((ring+1)^6-(ring)^6))/(3*(2*ring+1));
    Energy_CH_ring (i)  = Packet_Size * ((Packet_Transmission_Cost+ Energy_Data_Aggregation)*(Cluster_Size_ring (i)) + Amplification_Energy_Multi_Path * Z_i) ;
    Y_i = (r^2 * (2*ring+1)) / (2* Num_cluster_heads_ring (i));
    Energy_Sensor_Node_ring (i) = Packet_Size *(Packet_Transmission_Cost + Amplification_Energy_Free_Space * Y_i) ;
    Energy_ring (i) = Num_cluster_heads_ring (i) * Energy_CH_ring (i) + (Num_Sensors_ring(i) - Num_cluster_heads_ring(i)) * Energy_Sensor_Node_ring (i);
end
total_Energy = sum (Energy_ring)

