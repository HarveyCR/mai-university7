 student=struct('last_name','Трофименко','first_name','Роман',...
'patronymic','Владимирович','culture','5','physics',' 4', 'history',' 5');
 student.last_name=char(student.last_name, 'Иванов');
 student.last_name=char(student.last_name, 'Князева');
 student.first_name=char(student.first_name, 'Дмитрий');
 student.first_name=char(student.first_name, 'Надежда');
 student.patronymic=char(student.patronymic, 'Алексеевич');
 student.patronymic=char(student.patronymic, 'Викторовна');
 student.culture=char(student.culture, '5');
 student.culture=char(student.culture, '5');
 student.physics=char(student.physics, '3');
 student.physics=char(student.physics, '4');
 student.history=char(student.history, '3');
 student.history=char(student.history, '5');
 student=orderfields(student);
 stud.student1.last_name='Трофименко';
 stud.student2.last_name='Иванов';
 stud.student3.last_name='Князева';
 stud.student1.first_name='Роман';
 stud.student2.first_name='Дмитрий';
 stud.student3.first_name='Надежда';
 stud.student1.patronymic='Владимирович';
 stud.student2.patronymic='Алексеевич';
 stud.student3.patronymic='Викторовна';
 stud.student1.culture=5;
 stud.student2.culture=5;
 stud.student3.culture=5;
 stud.student1.physics=4;
 stud.student2.physics=3;
 stud.student3.physics=4;
 stud.student1.history=5;
 stud.student2.history=3;
 stud.student3.history=5;
 stud=orderfields(stud);
 str=[stud.student1.last_name, ' ', num2str((stud.student1.culture + stud.student1.physics + stud.student1.history)/3)]
 str=[stud.student2.last_name, ' ', num2str((stud.student2.culture + stud.student2.physics + stud.student2.history)/3)]
 str=[stud.student3.last_name, ' ', num2str((stud.student3.culture + stud.student3.physics + stud.student3.history)/3)]
