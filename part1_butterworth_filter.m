% ============================================================
%  DSP Mini Project - Part 1
%  Noise Addition and Butterworth Low-Pass Filtering
%  Subject : Digital Signal Processing Lab (KEC R2022)
%  Tool    : MATLAB Online
% ============================================================
%
%  AIM:
%  To add white Gaussian noise to an audio signal, filter it
%  using a 6th-order Butterworth low-pass filter, and analyze
%  the original, noisy, and filtered signals in both time and
%  frequency domains.
%
%  INPUT FILE REQUIRED:
%  Place 'ponni_nadhi_ringtone.wav' in the same working directory.
% ============================================================

clc; clear; close all;

%% Step 1: Load Audio File
[audio, Fs] = audioread('ponni_nadhi_ringtone.wav');
audio = audio(:,1);          % Use mono channel
N = length(audio);
t = (0:N-1)/Fs;

%% Step 2: Generate White Gaussian Noise
noise_level = 0.02;
noise = noise_level * randn(size(audio));

%% Step 3: Plot Original Audio and Noise - Time Domain
figure;
subplot(2,1,1);
plot(t, audio);
title('Original Audio - Time Domain');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(t, noise);
title('Generated Noise - Time Domain');
xlabel('Time (s)'); ylabel('Amplitude');

%% Step 4: Frequency Domain (FFT)
f = Fs*(0:(N/2))/N;
audio_fft = fft(audio);
noise_fft = fft(noise);

figure;
subplot(2,1,1);
plot(f, abs(audio_fft(1:N/2+1)));
title('Original Audio - Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('|Amplitude|');

subplot(2,1,2);
plot(f, abs(noise_fft(1:N/2+1)));
title('Noise - Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('|Amplitude|');

%% Step 5: Add Noise to Audio
noisy_signal = audio + noise;

%% Step 6: Plot Noisy Signal
noisy_fft = fft(noisy_signal);

figure;
subplot(2,1,1);
plot(t, noisy_signal);
title('Noisy Signal - Time Domain');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(f, abs(noisy_fft(1:N/2+1)));
title('Noisy Signal - Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('|Amplitude|');

%% Step 7: Butterworth Low-Pass Filter (6th order, cutoff = 3000 Hz)
cutoff = 3000;
[b, a] = butter(6, cutoff/(Fs/2), 'low');
filtered_signal = filtfilt(b, a, noisy_signal);

%% Step 8: Plot Filtered Signal
filtered_fft = fft(filtered_signal);

figure;
subplot(2,1,1);
plot(t, filtered_signal);
title('Filtered Signal - Time Domain');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(f, abs(filtered_fft(1:N/2+1)));
title('Filtered Signal - Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('|Amplitude|');

%% Step 9: Listen (optional)
disp('Playing original audio...');
sound(audio, Fs); pause(N/Fs + 1);

disp('Playing noisy audio...');
sound(noisy_signal, Fs); pause(N/Fs + 1);

disp('Playing filtered audio...');
sound(filtered_signal, Fs); pause(N/Fs + 1);

%% Step 10: Save Filtered Output
filtered_signal = filtered_signal / max(abs(filtered_signal));
audiowrite('filtered_output.wav', filtered_signal, Fs);
disp('Filtered audio saved as "filtered_output.wav".');
