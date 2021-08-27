transect_distance = zeros(10, 1);
for i = 2 : 10
    transect_distance(i) = distance(lat(i - 1), long(i - 1), lat(i), long(i), [6378.137 0.0818191910428158]);
end