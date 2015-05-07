% Zachary Baum ~~ 10090150 ~~ 12zmcb
% CISC 271 Winter 2015 ~~ Assignment 4

% This script runs the approximation on all the original data provided, and
% randomly shifted version on the data. The shifting occurs within each
% trial of the script, meaning that every time you run it you should
% recieve different values.
% 
% When performing the approximation, the direction vector, d, is found
% first. Then D is found for the residual calculation. A and b are created
% after finding D for each point of data. Once the approximation of c is
% found, the data is all plotted and the average point-line distance is
% found between the approximation and the lines used. This distance was
% found using the cross-product method; 
%                         
%        Point Line Dist = ||(x - r) cross (c - r)|| / ||(x - r)||
%
% This process is then repeated on the shifted data.


% Used as r's for both plots.
PlanarPoints = [ ...
    [0.96; 1.05; 0] ...
    [1.00; 8.02; 0] ...
    [8.07; 1.99; 0] ...
    [7.95; 7.95; 0] ...
    [5.00; 2.93; 0]];

% Used as x's for both plots.
SpatialPoints = [ ...
    [3.75; 3.75; 13.75] ...
    [3.60; 6.05; 12.98] ...
    [7.14; 2.86;  5.71] ...
    [7.73; 7.73;  1.82] ...
    [5.00; 4.05; 10.48]];


%%%%%%%%%%%%
%
% Running the least squares approximation on the original data points.
%
%%%%%%%%%%%%

r = PlanarPoints;
x = SpatialPoints;

% Create the A matrix and b vector.
A = zeros(length(r(:, 1)));
b = zeros(length(r(:, 1)), 1);

figure;
hold on;

iterationsToDo = length(r);

for i = 1 : iterationsToDo
    
    % Find the direction vector, d for each set of points.
    d = (x(:, i) - r(:, i)) / norm(x(:, i) - r(:, i));

    % Find the D for the residual calculation.
    D = eye(length(d)) - (d * d');

    % Create the A matrix for LHS of equation.
    A = A + (D' * D);
    
    % Create the b vector for RHS of equation.
    b = b + (D' * D * r(:, i));
    
    % Plot lines from the PlanarPoints through the SpatialPoints.
    xPts = [r(1, i), r(1, i) + 30 * d(1)];
    yPts = [r(2, i), r(2, i) + 30 * d(2)];
    zPts = [r(3, i), r(3, i) + 30 * d(3)];
    line(xPts, yPts, zPts, ...
        'LineStyle', '--', ...
        'LineWidth', 1, ...
        'Color', [0.05 0.95 0.5]);
    
    % Plot the initial data (Spatial and Planar) for current iteration.
    plot3(x(1, i), x(2, i), x(3, i), ...
        'b*', ...
        'MarkerSize', 12);
    plot3(r(1, i), r(2, i), r(3, i), ...
        'r*', ...
        'MarkerSize', 12); 
    
end

% Solve the approximation of the point 'c'.
c = A\b;

% Find the average distance from each line to the approximated
% least squares focal point, 'c'.
totalDist = 0;
for i = 1 : iterationsToDo
    
    dist = norm(cross(x(:, i) - r(:, i), c - r(:, i))) / ...
        norm(x(:, i) - r(:, i));
    totalDist = totalDist + dist; 
    
end

avgDist = totalDist / iterationsToDo;

% Add our approximation of 'c' to the graph.
plot3(c(1), c(2), c(3), ...
    'k*', ...
    'MarkerSize', 12);
title(['Unaltered Lines -- Average distance from lines to centre: ', ...
    num2str(avgDist)]);
        
hold off;


%%%%%%%%%%%%
%
% Running the least squares approximation on randomly shifted
% PlanarPoints. Values shifted by are between -0.1 and 0.1 inclusive.
%
%%%%%%%%%%%%

shiftedR = PlanarPoints;
shiftedX = SpatialPoints;

% Create the A matrix and b vector for the shifted data.
shiftedA = zeros(length(shiftedR(:, 1)));
shiftedb = zeros(length(shiftedR(:, 1)), 1);

figure;
hold on;

iterationsToDo = length(shiftedR);

% Randomly shift the PlanarPoints along XY plane by values in the
% range [-0.1 ... 0.1].
a = -0.1;
b = 0.1;

for i = 1 : iterationsToDo
   
    rand1 = a + (b-a) * rand(1,1);
    rand2 = a + (b-a) * rand(1,1);
    shiftedR(1, i) = shiftedR(1, i) + rand1;
    shiftedR(2, i) = shiftedR(2, i) + rand2;
    
end

for i = 1 : iterationsToDo
    
    % Find the direction vector, d for each set of shifted points.
    shiftedd = (shiftedX(:, i) - shiftedR(:, i)) / norm(shiftedX(:, i) - shiftedR(:, i));

    % Find the D for the residual calculation of the shifted points.
    shiftedD = eye(length(shiftedd)) - (shiftedd * shiftedd');

    % Create the A matrix for LHS of equation of the shifted points.
    shiftedA = shiftedA + (shiftedD' * shiftedD);
    
    % Create the b vector for RHS of equation of the shifted points.
    shiftedb = shiftedb + (shiftedD' * shiftedD * shiftedR(:, i));
    
    % Plot lines from the shifted PlanarPoints through the SpatialPoints.
    shiftedXPts = [shiftedR(1, i), shiftedR(1, i) + 30 * shiftedd(1)];
    shiftedYPts = [shiftedR(2, i), shiftedR(2, i) + 30 * shiftedd(2)];
    shiftedZPts = [shiftedR(3, i), shiftedR(3, i) + 30 * shiftedd(3)];
    line(shiftedXPts, shiftedYPts, shiftedZPts, ...
        'LineStyle', '--', ...
        'LineWidth', 1, ...
        'Color', [0.95 0.05 0.5]);
    
    % Plot the initial data (Spatial and shifted Planar) for current
    % iteration.
    plot3(shiftedX(1, i), shiftedX(2, i), shiftedX(3, i), ...
        'k*', ...
        'MarkerSize', 12);
    plot3(shiftedR(1, i), shiftedR(2, i), shiftedR(3, i), ...
        'g*', ...
        'MarkerSize', 12); 
    
end

% Solve the approximation of the point 'c' for the shifted data.
shiftedc = shiftedA\shiftedb;

% Find the average distance from each line to the approximated
% least squares focal point, 'c' for the shifted data.
totalDist = 0;
for i = 1 : iterationsToDo
    
    dist = norm(cross(shiftedX(:, i) - shiftedR(:, i), ...
        shiftedc - shiftedR(:, i))) / norm(shiftedX(:, i) - shiftedR(:, i));
    totalDist = totalDist + dist; 
    
end

avgDist = totalDist / iterationsToDo;

% Add our approximation of 'c' to the graph for the shifted data.
plot3(shiftedc(1), shiftedc(2), shiftedc(3), ...
    'b*', ...
    'MarkerSize', 12);
title(['Shifted Lines -- Average distance from lines to centre: ', ...
    num2str(avgDist)]);
        
hold off;
