function [Den] = FT_fix_win82(noisy,n)

% nn = 45;
% cvx_begin quiet
%     variable x(nn)
%     minimize(norm(x-noisy(1:nn))+norm(x(2:nn)-x(1:nn-1)))
%     subject to
%         norm(x-noisy(1:nn)) <= 1.5;
% cvx_end
% noisy(1:nn) = x;

% noisy(1:45) = medfilt1(noisy(1:45),25);

x = 1:length(noisy);
A = [x' ones(length(x),1)];
b = noisy;
X = A\b;

y = X(1).*x + X(2);
% figure;plot(noisy_new); hold on; plot(y,'r')

Flat_dw = noisy - y' + mean(y);
F = fftshift(fft(Flat_dw));

% Low_pass filter window
window = zeros(1,length(F)); % [82 146]
window(42-n:42+n) = 1;
F_low_passed = F.*window';
denoised_FT = ifft(fftshift(F_low_passed));

% Magnified version (Just an idea to be tested) - May 14
% DiffwMean = denoised_FT-mean(denoised_FT);
% Magnified = DiffwMean + denoised_FT;
% denoised_FT = Magnified;

Den = denoised_FT + y' - mean(y);


