clc
clear
close all

load('MLPtrain')

% stained glass 150
path1='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\test\9_altar\';
file1=dir(path1);

% vault 163
path2='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\test\2_dome(inner)\';
file2=dir(path2);

% column 210
path3='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\test\6_bell_tower\';
file3=dir(path3);
rsimg=24;
dataTest1=[];
for i =3:length(file1)
    img = file1(i).name;
    imgpath= [path1, img];
    imagd=im2double(imread(imgpath));
    resized_image = imresize(imagd, [rsimg, rsimg]);
    dataTest1(:,i-2)=resized_image(:);
end

dataTest2=[];
for i =3:length(file2)
    img = file2(i).name;
    imgpath= [path2, img];
    imagd=im2double(imread(imgpath));
    resized_image = imresize(imagd, [rsimg, rsimg]);
    dataTest2(:,i-2)=resized_image(:);
end

dataTest3=[];
for i =3:length(file3)
    img = file3(i).name;
    imgpath= [path3, img];
    imagd=im2double(imread(imgpath));
    resized_image = imresize(imagd, [rsimg, rsimg]);
    dataTest3(:,i-2)=resized_image(:);
end

dataTestall=[dataTest1,dataTest2,dataTest3];

O = MLPnet(dataTestall);

D1=[ones(1,size(dataTest1,2));zeros(1,size(dataTest1,2));zeros(1,size(dataTest1,2))];
D2=[zeros(1,size(dataTest2,2));ones(1,size(dataTest2,2));zeros(1,size(dataTest2,2))];
D3=[zeros(1,size(dataTest3,2));zeros(1,size(dataTest3,2));ones(1,size(dataTest3,2))];
Dtest=[D1,D2,D3];

[val, realoutput] = max(O);

[~,col1] = size(D1);
[~,col2] = size(D2);
[~,col3] = size(D3);

desireoutput=[ones(1,col1),2*ones(1,col2),3*ones(1,col3)];
C=confusionmat(realoutput,desireoutput);
confusionchart(C);
A=sum(diag(C))/sum(sum(C))*100;
path='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\wrongclf\';

for x = 1:col1
    if realoutput(x) ~= desireoutput(x)
        if realoutput(x) == 2
            pathB = [path, '1 as 2\'];
            img_path = [file1(x).folder,'\',file1(x+2).name]
            copyfile(img_path,pathB)
        else
            pathC=[path,'1 as 3\'];
            img_path = [file1(x).folder,'\',file1(x+2).name]
            copyfile(img_path,pathC)
        end
    end
end

for y = 1:col2
    if realoutput(y+col1) ~= desireoutput(y+col1)
        if realoutput(y+col1) == 1
            pathB = [path, '2 as 1\'];
            img_path = [file2(1).folder,'\',file2(y+2).name]
            copyfile(img_path,pathB)
        else 
            pathC=[path,'2 as 3\'];
            img_path = [file2(1).folder,'\',file2(y+2).name]
            copyfile(img_path,pathC)
        end 
    end
end

for z = 1:col3
    if realoutput(z+col1+col2) ~= desireoutput(z+col1+col2)
        if realoutput(z+col1+col2) == 1
            pathB = [path, '3 as 1\'];
            img_path = [file3(1).folder,'\',file3(z+2).name]
            copyfile(img_path,pathB)
        else
            pathC=[path,'3 as 2\'];
            img_path = [file3(1).folder,'\',file3(z+2).name]
            copyfile(img_path,pathC)
        end
    end
end
