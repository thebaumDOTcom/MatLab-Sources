% Zachary Baum ~~ 10090150 ~~ 12zmcb
% CISC 271 Winter 2015 ~~ Assignment 2
%
% In the following script, the instructor's PCAPRELIM and PCAAPRPOX
% functions are used.
%
% The rsquare function provided for the Week 7 Homework is also used.


% Testing module for the first dataset, z1.
%
% Prompts the user for the number of signals that they would like to use to
% do the testing with, and carries this number over into the testing for
% the second dataset. Assumes that an integer will be supplied (the script
% does no error handling). Recommended input values are between 3 and 5.
%
% Preforms PCA Preliminary Calculations on the data, and then plots the 
% eigenvalues.
%
% Preforms PCA Approximation on the data, and plots the original signal
% against its reconstruction, using one eigenvalue at a time to show the
% user the progress of the PCA.
%
% Lastly, it outputs the mean RMSE value for the number of signals tested,
% and for all the signals in the dataset.

% Load in the first dataset.
Z = load('z1.dat');

% Have the user select the number of random signals to test on.
sigsToPick = input('Enter the number of signals to test z1 and z2 with: ');
toTake = randi([1, 30], [sigsToPick, 1]);

% Perform the preliminary PCA calculations on z1.
[evals, means, evecs] = pcaprelim(Z);

% Plot the eigenvalues.
figure;
plot(evals, 'r', 'LineWidth', 2);

% Add title and axes labels.
title('Eigenvalues of Dataset z1');
xlabel('Eigenvalue #');
ylabel('Numerical Value');

% Make axes tight.
axis tight;

% After the user has seen the graph, close the figure window.
pause;
close;

% Determine the percent captured given the current eiganvalues and data.
captured = cumsum(evals) / sum(flipud(evals));

% Used to keep track of the RMSE so we can find the mean RMSE value for the
% current signals after the testing has finished.
rmseSum = 0;

for i = 1 : sigsToPick
    
    % Used to keep track of the current number of eigenvalues being used.
    numUsed = 1;
    
    % Select the randomly chosen signal and run the PCA Approximation on
    % it.
    toTest = Z(:, toTake(i));
    [~, toPlot] = pcaapprox(toTest, numUsed, means, evecs);
    
    % Keep plotting the approximation while the percent captured is less
    % than 93%.
    while captured(numUsed) < 0.93
        
        % Plot the mean, the original signal and its reconstruction.
        figure;
        plot(0:100, Z(:,toTake(i)), 'r--', ...
            0:100, toPlot, 'g', 'LineWidth', 1.5 );
        
        % Add title and axes labels and a legend.
        title(['PCA Approximation of Signal ', num2str(toTake(i)), ...
            ' from z1 using ', num2str(numUsed), ... 
            ' eigenvalue(s) to cover ', num2str(100 * captured(numUsed)), ...
            '% of the components']);
        
        xlabel('Time');
        ylabel('Knee Motion Angle');
        
        legend('Original Signal', 'Reconstruction', 'Location', ... 
            'southoutside', 'Orientation', 'horizontal');
        
        % Make axes tight.
        axis tight;
                
        % After the user has seen the graph, close the figure window.
        pause;
        close;
        
        % Increase the number of eigenvalues used for the next iteration.
        numUsed = numUsed + 1;
        
        % Select the next randomly chosen signal and run the PCA
        % Approximation on it.
        toTest = Z(:, toTake(i));
        [~, toPlot] = pcaapprox(toTest, numUsed, means, evecs);
        
    end
    
    % Take the RMSE for the "best fitted" signal reconstruction (the one
    % where we stopped approximations) and add that to the sum of RMSE's so
    % far.
    [~, rmse] = rsquare(Z(:,toTake(i)), toPlot);
    rmseSum = rmseSum + rmse;
    
end

% Find the mean RMSE value from the signals used and display it.
rmseMean = rmseSum / sigsToPick;
disp(['The mean RMSE value after testing select signals for dataset z1 is: ', ...
    num2str(rmseMean)]);

% Find the mean RMSE value of all the signals and display it.
rmseSum = 0;

for i = 1 : 30
    
    % Uses the "best fitted" signal reconstruction for each case.
    [~, toPlot] = pcaapprox((Z(:, i)), (numUsed - 1), means, evecs);
    [~, rmse] = rsquare(Z(:, i), toPlot);
    rmseSum = rmseSum + rmse;
    
end
   
rmseMean = rmseSum / 30;
disp(['The mean RMSE value for all signals in dataset z1 is: ', ...
    num2str(rmseMean)]);

pause;

% Testing module for the second dataset, z2.
%
% Does the same procedure are above, but with new data.
%
% Does not prompt for input of number of signals to use, instead it uses
% the same number of signals as above, but randomly generates a new set of
% signals to select.

% Load in the second dataset.
Z = load('z2.dat');

toTake = randi([1, 30], [sigsToPick, 1]);

% Perform the preliminary PCA calculations on z2.
[evals, means, evecs] = pcaprelim(Z);

% Plot the eigenvalues.
figure;
plot(evals, 'r', 'LineWidth', 2);

% Add title and axes labels.
title('Eigenvalues of Dataset z2');
xlabel('Eigenvalue #');
ylabel('Numerical Value');

% Make axes tight.
axis tight;

% After the user has seen the graph, close the figure window.
pause;
close;

% Determine the percent captured given the current eiganvalues and data.
captured = cumsum(evals) / sum(flipud(evals));

% Used to keep track of the RMSE so we can find the mean RMSE value for the
% current signals after the testing has finished.
rmseSum = 0;

for i = 1 : sigsToPick
    
    % Used to keep track of the current number of eigenvalues being used.
    numUsed = 1;
    
    % Select the randomly chosen signal and run the PCA Approximation on
    % it.
    toTest = Z(:, toTake(i));
    [~, toPlot] = pcaapprox(toTest, numUsed, means, evecs);
    
    % Keep plotting the approximation while the percent captured is less
    % than 93%.
    while captured(numUsed) < 0.93
        
         % Plot the mean, the original signal and its reconstruction.
        figure;
        plot(0:100, Z(:,toTake(i)), 'r--', ...
            0:100, toPlot, 'g', 'LineWidth', 1.5 );
        
        % Add title and axes labels and a legend.
        title(['PCA Approximation of Signal ', num2str(toTake(i)), ...
            ' from z2 using ', num2str(numUsed), ... 
            ' eigenvalue(s) to cover ', num2str(100 * captured(numUsed)), ...
            '% of the components']);
        
        xlabel('Time');
        ylabel('Knee Motion Angle');
        
        legend('Original Signal', 'Reconstruction', 'Location', ... 
            'southoutside', 'Orientation', 'horizontal');
        
        % Make axes tight.
        axis tight;
        
        % After the user has seen the graph, close the figure window.
        pause;
        close;
        
        % Increase the number of eigenvalues used for the next iteration.
        numUsed = numUsed + 1;
        
        % Select the next randomly chosen signal and run the PCA
        % Approximation on it.
        toTest = Z(:, toTake(i));
        [~, toPlot] = pcaapprox(toTest, numUsed, means, evecs);
        
    end
    
    % Take the RMSE for the "best fitted" signal reconstruction (the one
    % where we stopped approximations) and add that to the sum of RMSE's so
    % far.
    [~, rmse] = rsquare(Z(:,toTake(i)), toPlot);
    rmseSum = rmseSum + rmse;
    
end

% Find the mean RMSE value from the signals used and display it.
rmseMean = rmseSum / sigsToPick;
disp(['The mean RMSE value after testing select signals for dataset z2 is: ', ...
    num2str(rmseMean)]);

% Find the mean RMSE value of all the signals and display it.
rmseSum = 0;

for i = 1 : 30
    
    % Uses the "best fitted" signal reconstruction for each case.
    [~, toPlot] = pcaapprox((Z(:, i)), (numUsed - 1), means, evecs);
    [~, rmse] = rsquare(Z(:, i), toPlot);
    rmseSum = rmseSum + rmse;
    
end
   
rmseMean = rmseSum / 30;
disp(['The mean RMSE value for all signals in dataset z2 is: ', ...
    num2str(rmseMean)]);