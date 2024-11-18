[iconData, iconCmap] = imread('grfwnd','ico');
createMode.WindowStyle = 'modal';
createMode.Interpreter = 'tex';
message = {'Вы вошли в Мир';'\bfMat^{rix} Lab^{oratory}'};
msgbox(message,'Привет!','custom', iconData, iconCmap, createMode);
clear message iconData iconCmap createMode
