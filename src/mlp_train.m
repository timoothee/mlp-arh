clc
clear
close all
%%
% stained glass 1033
path1='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\train\stained_glass\';
file1=dir(path1);

% vault 1110
path2='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\train\vault\';
file2=dir(path2);

% column 1919
path3='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\train\column\';
file3=dir(path3);

dataTrain1=[];
for i =3:length(file1)
    img = file1(i).name;
    imgpath= [path1, img];
    imagd=im2double(imread(imgpath));
    dataTrain1(:,i-2)=imagd(:);
end

dataTrain2=[];
for i =3:length(file2)
    img = file2(i).name;
    imgpath= [path2, img];
    imagd=im2double(imread(imgpath));
    dataTrain2(:,i-2)=imagd(:);
end

dataTrain3=[];
for i =3:length(file3)
    img = file3(i).name;
    imgpath= [path3, img];
    imagd=im2double(imread(imgpath));
    dataTrain3(:,i-2)=imagd(:);
end

dataTrainall=[dataTrain1,dataTrain2,dataTrain3];

D1=[ones(1,size(dataTrain1,2));zeros(1,size(dataTrain1,2));zeros(1,size(dataTrain1,2))];
D2=[zeros(1,size(dataTrain2,2));ones(1,size(dataTrain2,2));zeros(1,size(dataTrain2,2))];
D3=[zeros(1,size(dataTrain3,2));zeros(1,size(dataTrain3,2));ones(1,size(dataTrain3,2))];
Dtrain=[D1,D2,D3];

N=10;
MLPnet = patternnet(N);

MLPnet.divideParam.trainRatio=0.70;
MLPnet.divideParam.valRatio=0.30;
MLPnet.divideParam.testRatio=0.00;

MLPnet=train(MLPnet,dataTrainall,Dtrain);
save('MLPtrain','MLPnet');
%%
O = MLPnet(dataTrainall)

[val, realoutput] = max(O);

desireoutput=[ones(1,1033),2*ones(1,1110),3*ones(1,1919)];
C=confusionmat(realoutput,desireoutput);

confusionchart(C);
A=sum(diag(C))/sum(sum(C))*100;