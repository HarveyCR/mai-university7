quest = {'Вы действительно хотите покинуть мир','\bfMat^{rix} Lab^{oratory}?'};
Options.Default = 'Нет'; Options.Interpreter = 'tex'; l = false;
l = strcmp(questdlg(quest,'Выход','До свидания', 'Нет', Options),'До свидания');
if l ~= true, quit cancel, end