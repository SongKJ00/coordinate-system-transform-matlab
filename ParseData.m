function [check, euler, accBody] = PharseData(ser)
% Get euler, accelertaion data from com port
% Data Packet Structure is "roll pitch yaw accX accY accZ\n"
persistent firstRun

if isempty(firstRun)
    euler = zeros(3, 1);
    accBody = zeros(3, 1);
    
    %trash_data = fscanf(ser);
    firstRun = 1;
end

data = fscanf(ser);
dataLen = size(data, 2);
dataSliceIndex = strfind(data, ' ');

if length(dataSliceIndex) >= 5
    euler(1, :) = deg2rad(str2double(data(1:dataSliceIndex(1)-1)));
    euler(2, :) = deg2rad(str2double(data(dataSliceIndex(1):dataSliceIndex(2)-1)));
    euler(3, :) = deg2rad(str2double(data(dataSliceIndex(2):dataSliceIndex(3)-1)));

    accBody(1, :) = str2double(data(dataSliceIndex(3):dataSliceIndex(4)-1));
    accBody(2, :) = str2double(data(dataSliceIndex(4):dataSliceIndex(5)-1));
    accBody(3, :) = str2double(data(dataSliceIndex(5):dataLen-1));
    
    check = 1;
else
    euler(:, :) = 0;
    accBody(:, :) = 0;
    
    check = 0;
end