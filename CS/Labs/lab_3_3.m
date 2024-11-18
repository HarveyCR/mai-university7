screen = get(0,'Screensize');
width = 450; height = 350;
position=[fix((screen(3)-width)/2),...
  fix((screen(4)-height)/2),width,height];
set(0,'DefaultFigurePosition', position);
clear screen position width height
