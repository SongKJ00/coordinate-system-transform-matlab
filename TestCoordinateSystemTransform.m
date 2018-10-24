clear all;
clc;

% delete all connected com port now
delete(instrfindall)
% Use your own com port
ser = Init('COM10', 9600);

% Declare data matrix
euler = zeros(3, 1);
accBody = zeros(3, 1);
accNED = zeros(3, 1);

while(1)
    % Get euler, acceleration data from serial port
    [isOK, euler, accBody] = PharseData(ser);
    
    % if data pharsing is completed, do DCM
    if isOK == 1
        accNED = DCMBodytoNed(euler, accBody);
        UpdateFigure(accNED(3, :));
        fprintf('%.2f %.2f %.2f\n', accNED(1), accNED(2), accNED(3));
    end
    
    pause(0.01);
end