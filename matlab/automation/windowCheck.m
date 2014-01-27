function [window_status]=windowCheck(raw_buf,pow_buf,sPeriod)
% [maxP,maxI]=max(pow_buf);
% [minP,minI]=min(pow_buf);
% [maxPowRatio,maxPowCh]=max(maxP./minP);
% if (maxPowRatio >= 100) && ...
%    (maxP(1,maxPowCh) >= 0.01) && ...
%    (maxI(1,maxPowCh)> minI(1,maxPowCh))% <=50)
%     window_status = 'start';
% else
%     window_status = 'null';
% end

% Check the slope of the signal
 powSlope=[[0 0];diff(pow_buf)]/sPeriod;
 if max(max(abs(raw_buf))) > 0.04 && ...      %amplitude crosses Thr
         max(max(pow_buf)) > 0.01 && ...      %cummulative power crosses Thr
         ~isempty(find(powSlope)<0) &&...     %power slope is strictly positive 
         max(max(powSlope))>0.2
     window_status = 'start';
 else
     window_status = 'null';
 end

% window_status='false';

%% Find the most appropriate window
%  powSlope=[[0 0];diff(pow_buf)]/sPeriod;
%  if max(max(pow_buf)) > 0.01 && ...      %cummulative power crosses Thr
%          ~isempty(find(powSlope)<0)      %power slope is strictly positive
%      % valid window where signal has started
%      window_status = 'start';
%      % now find the window limits
%      for i=70:-1:1
%          if max(abs(raw_buf(i)))<0.005 && max(pow_buf(i))<0.0002
%              winStartOffset=70-i; break;  %this is the offset 
%          else
%              winStartOffset=nan;
%          end
%      end
%  else
%      window_status = 'null';
%      winStartOffset=nan;
%  end

