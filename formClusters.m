function [Y, clusterSize, clusterHead, numClusters] = formClusters (Num_Sensors, Distance, R_net, M, Sensor_Nodes, BS, probCHElection)
Y = zeros (Num_Sensors, Num_Sensors);
clusterSize = zeros (Num_Sensors, 1);
clusterHead = zeros (Num_Sensors, 1);
numClusters=0;

for i = 1 : Num_Sensors 
    DtoBS = ((Sensor_Nodes(i, 1) - BS(1))^2 + (Sensor_Nodes(i, 2) - BS(2))^2)^(0.5);
    ratio = floor((DtoBS*M/R_net) - 0.0000001)+1;
    p = probCHElection (ratio);
    value = rand ();
    if (value <= p)
        Y(i,i) = 1;
        numClusters = numClusters + 1;
    end
end

for i = 1 : Num_Sensors
    minDistance = inf;
    minDistanceIndex = i; 
    if (Y(i, i)  ~= 1)
        for j = 1 : Num_Sensors
            if ((Distance(i, j) < minDistance) && (Y(j,j) == 1))
                minDistance = Distance(i, j);
                minDistanceIndex = j;
            end
        end
        Y (i, minDistanceIndex) = 1;
        clusterHead (i) = minDistanceIndex;
        clusterSize (minDistanceIndex) = clusterSize (minDistanceIndex) + 1;
    end
end

end