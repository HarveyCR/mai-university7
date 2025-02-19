noteFreqs = struct('C4', 261.63, 'D4', 293.66, 'E4', 329.63, 'F4', 349.23, ...
                   'G4', 392.00, 'A4', 440.00, 'B4', 493.88, ...
                   'C5', 523.25, 'D5', 587.33, 'E5', 659.25, 'F5', 698.46);

song = { ...
    'E4', 0.5; 'E4', 0.5; 'E4', 1.0; ...
    'E4', 0.5; 'E4', 0.5; 'E4', 1.0; ...
    'E4', 0.5; 'G4', 0.5; 'C4', 0.5; 'D4', 0.5; 'E4', 2.0; ...
    'F4', 0.5; 'F4', 0.5; 'F4', 0.5; 'F4', 0.5; 'F4', 0.5; 'E4', 0.5; 'E4', 0.5; 'E4', 0.5; ...
    'E4', 0.5; 'E4', 0.5; 'D4', 0.5; 'D4', 0.5; 'E4', 0.5; 'D4', 0.5; 'G4', 2.0; ...
};

fs = 44100; 
songWave = []; 

for i = 1:size(song, 1)
    note = song{i, 1};
    duration = song{i, 2};
    
    if strcmp(note, 'pause')
        t = 0:1/fs:duration;
        wave = zeros(size(t));
    else
        freq = noteFreqs.(note);
        t = 0:1/fs:duration - 1/fs;
        wave = sin(2 * pi * freq * t);
    end
    
    songWave = [songWave, wave];
end

while true
    sound(songWave, fs);
    pause(length(songWave) / fs);
end
