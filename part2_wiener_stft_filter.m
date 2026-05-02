% ============================================================
%  DSP Mini Project - Part 2
%  Real-Time Song and Noise Separation using Wiener STFT Filter
%  Subject : Digital Signal Processing Lab (KEC R2022)
%  Tool    : MATLAB Online
% ============================================================
%
%  AIM:
%  To separate noise from a real audio recording by applying
%  STFT-domain Wiener filtering and analyze the results using
%  FFT magnitude plots and power spectral comparisons.
%
%  INPUT FILES REQUIRED:
%  Place 'song.wav' and 'noise_signal.wav' in working directory.
%
%  OUTPUT FILES GENERATED:
%  - noisy_song.wav
%  - filtered_song_wiener_stft.wav
%  - extracted_noise_stft.wav
% ============================================================

clc; clear; close all;

%% Step 1: Load Song and Noise
[song, Fs1]   = audioread('song.wav');
[noise, Fs2]  = audioread('noise_signal.wav');

% Convert stereo to mono
if size(song,  2) > 1, song  = mean(song,  2); end
if size(noise, 2) > 1, noise = mean(noise, 2); end

% Resample noise to match song sample rate if needed
if Fs1 ~= Fs2
    noise = resample(noise, Fs1, Fs2);
end

% Match lengths
min_len = min(length(song), length(noise));
song    = song(1:min_len);
noise   = noise(1:min_len);

%% Step 2: Create and Save Noisy Signal
noisy_signal = song + 0.4 * noise;
noisy_signal = noisy_signal / max(abs(noisy_signal));
audiowrite('noisy_song.wav', noisy_signal, Fs1);
disp('Noisy song saved.');

%% Step 3: STFT-Domain Wiener Filtering
window  = hamming(512);
nfft    = 1024;
overlap = 256;

% Compute STFT
[S_noisy, F, T] = stft(noisy_signal, Fs1, 'Window', window, ...
                        'OverlapLength', overlap, 'FFTLength', nfft);
[S_noise, ~, ~] = stft(noise,        Fs1, 'Window', window, ...
                        'OverlapLength', overlap, 'FFTLength', nfft);

% Power Spectral Density
P_noisy = abs(S_noisy).^2;
P_noise = abs(S_noise).^2;

% Wiener Gain (spectral subtraction)
G       = max((P_noisy - P_noise), 0) ./ (P_noisy + eps);
S_clean = G .* S_noisy;

% Inverse STFT — reconstruct filtered signal
filtered_song = istft(S_clean, Fs1, 'Window', window, ...
                      'OverlapLength', overlap, 'FFTLength', nfft);
filtered_song = filtered_song / max(abs(filtered_song));
audiowrite('filtered_song_wiener_stft.wav', filtered_song, Fs1);
disp('Wiener filtered song saved.');

% Extract Residual Noise
residual_noise = noisy_signal(1:length(filtered_song)) - filtered_song;
audiowrite('extracted_noise_stft.wav', residual_noise, Fs1);
disp('Extracted residual noise saved.');

%% Step 4: FFT Analysis and Plots
N      = length(filtered_song);
f_axis = (0:N-1) * (Fs1/N);
fft_filtered = fft(filtered_song, N);
fft_residual = fft(residual_noise, N);

% Plot 1: Original Song
figure;
plot((0:length(song)-1)/Fs1, song);
title('Original Song'); xlabel('Time (s)'); ylabel('Amplitude');

% Plot 2: Original Noise
figure;
plot((0:length(noise)-1)/Fs1, noise);
title('Original Noise'); xlabel('Time (s)'); ylabel('Amplitude');

% Plot 3: Mixed Noisy Signal
figure;
plot((0:length(noisy_signal)-1)/Fs1, noisy_signal);
title('Mixed Noisy Signal'); xlabel('Time (s)'); ylabel('Amplitude');

% Plot 4: Wiener Filtered Song
figure;
plot((0:length(filtered_song)-1)/Fs1, filtered_song);
title('Filtered Song (Wiener)'); xlabel('Time (s)'); ylabel('Amplitude');

% Plot 5: Extracted Residual Noise
figure;
plot((0:length(residual_noise)-1)/Fs1, residual_noise);
title('Extracted Residual Noise'); xlabel('Time (s)'); ylabel('Amplitude');

% Plot 6: FFT of Filtered Song
figure;
plot(f_axis(1:N/2), abs(fft_filtered(1:N/2)));
title('FFT of Filtered Song'); xlabel('Frequency (Hz)'); ylabel('Magnitude');

% Plot 7: FFT of Residual Noise
figure;
plot(f_axis(1:N/2), abs(fft_residual(1:N/2)));
title('FFT of Residual Noise'); xlabel('Frequency (Hz)'); ylabel('Magnitude');

% Plot 8: Power Spectrum Comparison
figure; hold on;
plot(f_axis(1:N/2), P_noisy(1:N/2), 'b', 'LineWidth', 1.5);
plot(f_axis(1:N/2), P_noise(1:N/2), 'r', 'LineWidth', 1.5);
title('Power Spectrum: Noisy Signal vs Noise');
xlabel('Frequency (Hz)'); ylabel('Power');
legend('Noisy Signal', 'Noise'); hold off;

disp('All processing and plotting done!');
