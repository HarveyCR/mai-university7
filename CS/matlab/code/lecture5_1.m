createMode.WindowStyle = 'modal';
createMode.Interpreter = 'tex';
message = 'Mat Sdohla';
msgbox(message, "Caption", createMode);

sphere(40)
peaks(20);
hSurf = findobj('Type', "Surface");
set(hSurf, 'FaceColor', 'green');
set(hSurf, 'FaceColor', 'none', "EdgeColor", 'none', "Marker", '.', 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red');
hAx = findobj('Type', 'Axes');
[imageData, imageCmap] = imread('firePath', 'jpg');