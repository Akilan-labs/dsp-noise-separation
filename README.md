# 🎵 Separation of Noises from a Song using MATLAB

> A DSP project that adds noise to an audio signal, separates it using Butterworth low-pass filtering and STFT-domain Wiener filtering, and analyzes the results through time-domain plots and frequency spectra.

---

## 📌 Overview

This project implements two approaches to audio noise separation in MATLAB:

**Part 1 — Butterworth Low-Pass Filter**
White Gaussian noise is artificially added to a `.wav` audio file. A 6th-order Butterworth low-pass filter (cutoff: 3000 Hz) is applied to recover the clean signal. Both signals are analyzed in the time and frequency domains using FFT.

**Part 2 — STFT-Domain Wiener Filter**
A real noise recording is mixed with a song. STFT-based Wiener filtering is applied to estimate and remove the noise component. The filtered song and extracted residual noise are saved separately and analyzed using FFT and power spectral density plots.

---

## 🛠️ Tools & Requirements

| Tool | Purpose |
|---|---|
| MATLAB Online | Development and execution environment |
| Signal Processing Toolbox | `butter`, `filtfilt`, `stft`, `istft` functions |
| Audio Toolbox | `audioread`, `audiowrite`, `sound` |

---

## ▶️ How to Run

### Part 1
1. Upload `ponni_nadhi_ringtone.wav` to your MATLAB Online working directory.
2. Open and run `src/part1_butterworth_filter.m`.
3. Output: `filtered_output.wav` + 4 figure plots.

### Part 2
1. Upload `song.wav` and `noise_signal.wav` to your MATLAB Online working directory.
2. Open and run `src/part2_wiener_stft_filter.m`.
3. Output: `noisy_song.wav`, `filtered_song_wiener_stft.wav`, `extracted_noise_stft.wav` + 8 figure plots.

---

## 📊 Results Summary

### Part 1 — Butterworth Filter
| Plot | Observation |
|---|---|
| Original Audio (Time) | Clean waveform with clear dynamic range |
| Noisy Signal (Time) | Slight amplitude spread due to added Gaussian noise |
| Filtered Signal (Time) | Closely resembles original after high-frequency removal |
| Frequency Domain | High-frequency noise components eliminated above 3000 Hz |

### Part 2 — Wiener STFT Filter
| Plot | Observation |
|---|---|
| Original Song vs Noise | Distinct waveform characteristics in time domain |
| Mixed Noisy Signal | Increased amplitude variability |
| Filtered Song (Wiener) | Noise significantly attenuated; song structure preserved |
| Residual Noise | Resembles the original noise waveform |
| Power Spectrum | Clear separation between signal and noise energy bands |

---

## 🔬 Concepts Used

- **FFT (Fast Fourier Transform)** — frequency domain analysis
- **Butterworth Filter** — maximally flat magnitude IIR low-pass filter
- **STFT (Short-Time Fourier Transform)** — time-frequency representation
- **Wiener Filter** — optimal linear filter for noise estimation and suppression
- **Power Spectral Density** — energy distribution across frequencies

---

## 📄 Report

Full  report with output plots

---


## 📜 License

Submitted as an academic project. All rights reserved by the author.
