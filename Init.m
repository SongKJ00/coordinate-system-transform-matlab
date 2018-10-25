function ser = Init(port, baudrate)
% Open Com Port
%
ser = serial(port, 'Baudrate', baudrate);
fopen(ser);

figure;
grid on;
title('DCM Accelerometer Data Body to NED')
xlabel('Time [10ms]');
ylabel('Acceleration [m/s^2]');
xlim([0 1000]);
hold on;