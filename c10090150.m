% Zachary Baum ~~ 10090150 ~~ 12zmcb
% CISC 271 Winter 2015 ~~ Assignment 3
%
% In the follwing script, the bSub.m function is called.
% The function has been included in the .zip file of the
% assignment.

% This script runs the analysis on all of the four datasets
% provided.
% 
% First, it finds the matrix A, and vector b for use in the
% approximation. The script then performs the QR decomposition
% and backsubstitution. Next, it finds the radius of the
% approximation and then will find the RMSE geometrically and 
% algebraicly. Lastly, it will plot the original dataset and
% newly approximated centre of the data.

% To see the results of each dataset, I have used 'pause' between
% each individual group of data, so it will output the results one
% group of data at a time.

% Analysis of group1.dat.
data = load('group1.dat');

[m, n] = size(data);

% Create the A matrix, and b vector.

A = ones(n, m + 1);
b = zeros(n, 1);

for i = 1 : n

    % Fill b with -(Data(i)'*Data(i)).
    b(i) = -1 * data(:, i)' * data(:, i);
    
    for j = 1 : m  
        
        % Fill A with -2(Data(ji)).
        A(i, j) = -2 * data(j, i);
        
    end
end

% Perform the QR decomposition.
[Q, R] = qr(A, 0);
e = Q' * b;

% Perform the backsubstitution.
% This next step is equivalent to x = R \ (Q' * b).
x = bSub(R, e);

% Determine the radius using the new vector x.
radius = sqrt((dot(x(1 : 3), x(1 : 3))) - x(4));

% Use Euclidian Distances to find the RMSE. (Geometric Method)
RMSEsum = 0;

for i = 1 : n
    
    % Find the distance between the original data points
    % and the approximated centre.
    dist1 = (x(1) - data(1, i))^2;
    dist2 = (x(2) - data(2, i))^2;
    dist3 = (x(3) - data(3, i))^2;
    RMSEsum = RMSEsum + (sqrt(dist1 + dist2 + dist3) - radius)^2;

end

% Divide by the number of points and square-root it.
RMSEsum = sqrt(RMSEsum / n);

% Use SSE to find the RMSE. (Algebraic Method)
SSE = (b - (A * x))' * (b - (A * x));
RMSE = sqrt(SSE / n);

% Plot the original sphere data.
title(['Group 1 Data: RMSE Error (Geometric): ', num2str(RMSEsum), ...
    '-- RMSE Error (Algebraic): ', num2str(RMSE)]);
       
for i = 1 : n
    
    hold on;
    plot3(data(1, i), data(2, i), data(3, i),'m*', 'MarkerSize', 15)
    
end

% Plot the newly approximated centre of the sphere.
plot3(x(1), x(2), x(3), 'h', 'MarkerSize', 15);
hold off;
pause;
close;


% Analysis of group2.dat.
data = load('group2.dat');

[m, n] = size(data);

% Create the A matrix, and b vector.

A = ones(n, m + 1);
b = zeros(n, 1);

for i = 1 : n

    % Fill b with -(Data(i)'*Data(i)).
    b(i) = -1 * data(:, i)' * data(:, i);
    
    for j = 1 : m  
        
        % Fill A with -2(Data(ji)).
        A(i, j) = -2 * data(j, i);
        
    end
end

% Perform the QR decomposition.
[Q, R] = qr(A, 0);
e = Q' * b;

% Perform the backsubstitution.
% This next step is equivalent to x = R \ (Q' * b).
x = bSub(R, e);

% Determine the radius using the new vector x.
radius = sqrt((dot(x(1 : 3), x(1 : 3))) - x(4));

% Use Euclidian Distances to find the RMSE. (Geometric Method)
RMSEsum = 0;

for i = 1 : n
    
    % Find the distance between the original data points
    % and the approximated centre.
    dist1 = (x(1) - data(1, i))^2;
    dist2 = (x(2) - data(2, i))^2;
    dist3 = (x(3) - data(3, i))^2;
    RMSEsum = RMSEsum + (sqrt(dist1 + dist2 + dist3) - radius)^2;

end

% Divide by the number of points and square-root it.
RMSEsum = sqrt(RMSEsum / n);

% Use SSE to find the RMSE. (Algebraic Method)
SSE = (b - (A * x))' * (b - (A * x));
RMSE = sqrt(SSE / n);

% Plot the original sphere data.
title(['Group 2 Data: RMSE Error (Geometric): ', num2str(RMSEsum), ...
    '-- RMSE Error (Algebraic): ', num2str(RMSE)]);
       
for i = 1 : n
    
    hold on;
    plot3(data(1, i), data(2, i), data(3, i),'m*', 'MarkerSize', 15)
    
end

% Plot the newly approximated centre of the sphere.
plot3(x(1), x(2), x(3), 'h', 'MarkerSize', 15);
hold off;
pause;
close;


% Analysis of group3.dat.
data = load('group3.dat');

[m, n] = size(data);

% Create the A matrix, and b vector.

A = ones(n, m + 1);
b = zeros(n, 1);

for i = 1 : n

    % Fill b with -(Data(i)'*Data(i)).
    b(i) = -1 * data(:, i)' * data(:, i);
    
    for j = 1 : m  
        
        % Fill A with -2(Data(ji)).
        A(i, j) = -2 * data(j, i);
        
    end
end

% Perform the QR decomposition.
[Q, R] = qr(A, 0);
e = Q' * b;

% Perform the backsubstitution.
% This next step is equivalent to x = R \ (Q' * b).
x = bSub(R, e);

% Determine the radius using the new vector x.
radius = sqrt((dot(x(1 : 3), x(1 : 3))) - x(4));

% Use Euclidian Distances to find the RMSE. (Geometric Method)
RMSEsum = 0;

for i = 1 : n
    
    % Find the distance between the original data points
    % and the approximated centre.
    dist1 = (x(1) - data(1, i))^2;
    dist2 = (x(2) - data(2, i))^2;
    dist3 = (x(3) - data(3, i))^2;
    RMSEsum = RMSEsum + (sqrt(dist1 + dist2 + dist3) - radius)^2;

end

% Divide by the number of points and square-root it.
RMSEsum = sqrt(RMSEsum / n);

% Use SSE to find the RMSE. (Algebraic Method)
SSE = (b - (A * x))' * (b - (A * x));
RMSE = sqrt(SSE / n);

% Plot the original sphere data.
title(['Group 3 Data: RMSE Error (Geometric): ', num2str(RMSEsum), ...
    '-- RMSE Error (Algebraic): ', num2str(RMSE)]);
       
for i = 1 : n
    
    hold on;
    plot3(data(1, i), data(2, i), data(3, i),'m*', 'MarkerSize', 15)
    
end

% Plot the newly approximated centre of the sphere.
plot3(x(1), x(2), x(3), 'h', 'MarkerSize', 15);
hold off;
pause;
close;


% Analysis of group4.dat.
data = load('group4.dat');

[m, n] = size(data);

% Create the A matrix, and b vector.

A = ones(n, m + 1);
b = zeros(n, 1);

for i = 1 : n

    % Fill b with -(Data(i)'*Data(i)).
    b(i) = -1 * data(:, i)' * data(:, i);
    
    for j = 1 : m  
        
        % Fill A with -2(Data(ji)).
        A(i, j) = -2 * data(j, i);
        
    end
end

% Perform the QR decomposition.
[Q, R] = qr(A, 0);
e = Q' * b;

% Perform the backsubstitution.
% This next step is equivalent to x = R \ (Q' * b).
x = bSub(R, e);

% Determine the radius using the new vector x.
radius = sqrt((dot(x(1 : 3), x(1 : 3))) - x(4));

% Use Euclidian Distances to find the RMSE. (Geometric Method)
RMSEsum = 0;

for i = 1 : n
    
    % Find the distance between the original data points
    % and the approximated centre.
    dist1 = (x(1) - data(1, i))^2;
    dist2 = (x(2) - data(2, i))^2;
    dist3 = (x(3) - data(3, i))^2;
    RMSEsum = RMSEsum + (sqrt(dist1 + dist2 + dist3) - radius)^2;

end

% Divide by the number of points and square-root it.
RMSEsum = sqrt(RMSEsum / n);

% Use SSE to find the RMSE. (Algebraic Method)
SSE = (b - (A * x))' * (b - (A * x));
RMSE = sqrt(SSE / n);

% Plot the original sphere data.
title(['Group 4 Data: RMSE Error (Geometric): ', num2str(RMSEsum), ...
    '-- RMSE Error (Algebraic): ', num2str(RMSE)]);
       
for i = 1 : n
    
    hold on;
    plot3(data(1, i), data(2, i), data(3, i),'m*', 'MarkerSize', 15)
    
end

% Plot the newly approximated centre of the sphere.
plot3(x(1), x(2), x(3), 'h', 'MarkerSize', 15);
hold off;
pause;
close;