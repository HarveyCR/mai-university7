function img = elli(varargin)

%построим поверхность 

a=1; b=2; c=0.5;
phi=[0:pi/128:2*pi]';
theta = [0:pi/16:2*pi];
x = a*cos (phi)*cos(theta); 
y = b*cos(phi)*sin(theta);
z = c*sin(phi)*ones(1,size(theta,2));
f=pi/4; g=pi/6;
Y=-1/4+y;
Z=1/4+z;
X=1/2+x;
figure(varargin{:});
colormap(copper)

xlabel('X'); ylabel('Y'); zlabel('Z');
hold on, grid on

Rx=[1 0 0; 0 cos(f) -sin(f); 0 sin(f) cos(f)];
     XYZ(:,:,1)=X; XYZ(:,:,2)=Y; XYZ(:,:,3)=Z;
     XYZ=permute(XYZ,[3 2 1]);
     for page=1:size(XYZ,3)
         XYZ(:,:,page)=Rx*XYZ(:,:,page);
     end
     XYZ=ipermute(XYZ,[3 2 1]);
     X1=XYZ(:,:,1); Y1=XYZ(:,:,2); Z1=XYZ(:,:,3); 

Ry=[cos(g) 0 sin(g); 0 1 0; -sin(g) 0 cos(g)];
     XYZ(:,:,1)=X1; XYZ(:,:,2)=Y1; XYZ(:,:,3)=Z1;
     XYZ=permute(XYZ,[3 2 1]);
     for page=1:size(XYZ,3)
         XYZ(:,:,page)=Ry*XYZ(:,:,page);
     end
     XYZ=ipermute(XYZ,[3 2 1]);
     X=XYZ(:,:,1); Y=XYZ(:,:,2); Z=XYZ(:,:,3);      
    
surface(X,Y,Z)

% Обращение: img('Name', 'Эллипсоид', 'NumberTitle', 'off')
