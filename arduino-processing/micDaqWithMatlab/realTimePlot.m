function dataMatrix=realTimePlot(duration)
%% This function plots realtime graph of the data available on serial port; 
%  "Duration" should be a number

    %Define the serial port to be used
    delete(instrfind({'Port'},{'COM14'}));
    serialPortThis=serial('COM14','BaudRate',1000000,'Terminator','CR/LF', 'InputBufferSize', 2048);           %115200 'Terminator','CR/LF'
    fopen(serialPortThis);

    %duration=1000;
    dataMatrix=zeros(1,duration);
    loopCount=1;

    %Define the plot area
    figure('Name','Real Time Plot of Serial Data');
    xlabel('Time'); ylabel('Amplitude');
    grid on; hold on;

    %Clear the buffer so that start of subsequent data acuisiotion dont get 
    %affected from previous sensor data which is actually being buffered 
    %from the creation of serial object until this point
    flushinput(serialPortThis);                         
    
    %send "start\n" to start the arduino ADC and sending data
    flag=1;
    while(flag~=0)
        fprintf(serialPortThis,'%s',char('s'));
        flag=fscanf(serialPortThis,'%d');
        %disp('flag')
        %disp(flag)
    end
    disp('out of while loop')
    %start async reading
    readasync(serialPortThis);
    tic;
    while loopCount<=duration
%         ylim([0 5.5]);
%         xlim([loopCount-50 loopCount+50]);

        %datanow = fscanf(serialPortThis,'%c');
        dataMatrix(:,loopCount) = str2double(fscanf(serialPortThis,'%c'))*5/255;
        
%         plot(loopCount,dataMatrix(1,loopCount),'X-k');
%         drawnow
        loopCount=loopCount+1;
    end
    toc
    
    dataMatrix=dataMatrix';
    ylim([0 5.5]);
    iteration=1:1:duration;
    plot(iteration,dataMatrix(:,1));
    stopasync(serialPortThis);fclose(serialPortThis); delete(serialPortThis); clear serialPortThis;
end

