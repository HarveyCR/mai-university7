[iconData, iconCmap] = imread('grfwnd','ico');
createMode.WindowStyle = 'modal';
createMode.Interpreter = 'tex';
message = {'Вы вошли в Мир';'\bfMat^{rix} Lab^{oratory}'};
msgbox(message,'Привет!','custom', iconData, iconCmap, createMode);
clear message iconData iconCmap createMode

quest = {'Вы действительно хотите покинуть мир','\bfMat^{rix} Lab^{oratory}?'};
Options.Default = 'Нет'; Options.Interpreter = 'tex'; l = false;
l = strcmp(questdlg(quest,'Выход','До свидания', 'Нет', Options),'До свидания');
if l ~= true, quit cancel, end