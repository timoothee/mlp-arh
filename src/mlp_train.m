clc
clear
close all
%%
% stained glass 1033
path1='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\train\altar\';
file1=dir(path1);

% vault 1110
path2='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\train\dome(inner)\';
file2=dir(path2);

% column 1919
path3='C:\Users\uie99388\ULBS an IV\Sem 2\Retele\mlp-arh\architecture\train\bell_tower\';
file3=dir(path3);

rsimg=24;
dataTrain1=[];
for i =3:length(file1)
    img = file1(i).name;
    imgpath= [path1, img];
    imagd=im2double(imread(imgpath));
    resized_image = imresize(imagd, [rsimg, rsimg]);
    dataTrain1(:,i-2)=resized_image(:);
end

dataTrain2=[];
for i =3:length(file2)
    img = file2(i).name;
    imgpath= [path2, img];
    imagd=im2double(imread(imgpath));
    resized_image = imresize(imagd, [rsimg, rsimg]);
    dataTrain2(:,i-2)=resized_image(:);
end

dataTrain3=[];
for i =3:length(file3)
    img = file3(i).name;
    imgpath= [path3, img];
    imagd=im2double(imread(imgpath));
    resized_image = imresize(imagd, [rsimg, rsimg]);
    dataTrain3(:,i-2)=resized_image(:);
end

dataTrainall=[dataTrain1,dataTrain2,dataTrain3];

D1=[ones(1,size(dataTrain1,2));zeros(1,size(dataTrain1,2));zeros(1,size(dataTrain1,2))];
D2=[zeros(1,size(dataTrain2,2));ones(1,size(dataTrain2,2));zeros(1,size(dataTrain2,2))];
D3=[zeros(1,size(dataTrain3,2));zeros(1,size(dataTrain3,2));ones(1,size(dataTrain3,2))];
Dtrain=[D1,D2,D3];

%hiddenActivationFunction = 'tansig'; % Specify activation function for hidden layers
%outputActivationFunction = 'softmax'; % Specify activation function for output layer
% maxValidationFailures = 15; % Specify maximum number of validation failures
hiddenLayerSizes = [10, 10, 20];
% N=50;
MLPnet = patternnet(5);

MLPnet.trainParam.epochs = 50;
%MLPnet.layers{1}.transferFcn = hiddenActivationFunction;
%MLPnet.layers{2}.transferFcn = outputActivationFunction;
% MLPnet.trainParam.max_fail = maxValidationFailures;
% MLPnet.divideParam.trainRatio=0.70;
% MLPnet.divideParam.valRatio=0.30;
% MLPnet.divideParam.testRatio=0.00;

MLPnet=train(MLPnet,dataTrainall,Dtrain);
save('MLPtrain','MLPnet');
%%
[~,col1] = size(D1);
[~,col2] = size(D2);
[~,col3] = size(D3);

O = MLPnet(dataTrainall);

[val, realoutput] = max(O);

desireoutput=[ones(1,col1),2*ones(1,col2),3*ones(1,col3)];
C=confusionmat(realoutput,desireoutput);

confusionchart(C);
A=sum(diag(C))/sum(sum(C))*100;