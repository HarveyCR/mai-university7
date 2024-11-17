[iconData, iconCmap] = imread('grfwnd','ico');
createMode.WindowStyle = 'modal';
createMode.Interpreter = 'tex';
message = {' Вы вошли в мир';'\bfMat^{rix} Lab^{oratory}'};
msgbox(message,'Привет!','custom',iconData,iconCmap,createMode);
screen= get(0,'screensize');
width=450; height=350;
position=[fix((screen(3)-width)/2), fix((screen(4)-height)/2), width, height];
set(0,'DefaultFigurePosition', position);
clear screen position width height
clear message iconData iconCmap createMode