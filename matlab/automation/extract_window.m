function [window_status, current_raw_buffer, current_power_buffer] = ...
    extract_window(input_sample, current_raw_buffer, current_power_buffer)
 
    % Assume that the period of one sample is .01 seconds
    sample_period = .01;
    
    % Assume that the required lag time for recognizing a good window is
    % 10 samples
    lag_period = 10 * sample_period;
    
    % Assume that the period of a good window is 60 samples
    window_period = 60 * sample_period;
    
    % Assume that we need a buffer large enough to hold one good window
    % plus lag
    buffer_length_in_seconds = lag_period + window_period;
    buffer_size = buffer_length_in_seconds / sample_period;
    assert(length(current_raw_buffer) == buffer_size, 'current_raw_buffer is not the correct length.');
    assert(length(current_power_buffer) == buffer_size, 'current_power_buffer is not the correct length.');
    
    % Add raw input sample to queue
    current_raw_buffer = [current_raw_buffer(2:end,:);input_sample];
    
    % Sum last 600ms of power values and add this to power sample queue
    current_power_buffer = [current_power_buffer(2:end,:);sum(current_raw_buffer(11:end,:).^ 2)];
 
    % If this power sample passes the start test, return true in
    % good_window
    % The logic to extract the good slice from current_raw_buffer can exist
    % outside this function, or can be here and simply returned as another
    % output
    [window_status] = windowCheck(current_raw_buffer,current_power_buffer,sample_period);
