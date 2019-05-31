function [Flag,vehPos,indCUE,indDUE,indDUE2] = genCUEandDUE(d0, laneWidth, numLane, disBstoHwy, d_avg, numCUE,numDUE)
%���ȣ����ݲ��ɷֲ������ɷֲ��Ĳ����ǳ���֮���ƽ�����룩�ڸ��ٹ�·������������
%Ȼ������DUE��CUE���û�λ��

%���룺d0:���ٹ�·�ĳ���
%      d_avg:�������ƽ�����룬d_avg = 2.5*v
%      �����Ĳ������Դ��������Ƴ�
%�����Flag��0/1��������ɵ���������������flag=1
%     vehPos,N*2�ľ��󣬴洢��������
%     indCUE, numCUE*1�ľ���,�洢CUE�û�����
%     indDUE, numDUEx1�ľ��󣬴洢DUE�û�����˵�����
%     indDUE2, numDUEx1�ľ��󣬴洢DUE�û����ն˵����꣨��ӽ�DUE����˵��û���
vehPos = []; % ���������û�������
indCUE = [];
indDUE = [];
indDUE2 = [];
Flag = 0;
%% �������������û������겢����vehPos����
for ilane = 1:numLane
    npoints = poissrnd(2*d0/d_avg);
    pproc = (rand(npoints,1)*2-1)*d0; % ˮƽ����
    pproc2 = [pproc, (disBstoHwy+ilane*laneWidth)*ones(length(pproc), 1)]; % ��ƽ�ߴ�ֱ����
    vehPos = [vehPos; pproc2];
end
numVeh = size(vehPos, 1);
if numVeh < numCUE+2*numDUE
    Flag = 1; % ���ɵ������û�������
    return; 
end
%% ����CUE��DUE�û�����
indPerm = randperm(numVeh);
indDUE = indPerm(1:numDUE); % randomly pick numDUE DUEs
indDUE2 = zeros(1,numDUE); % corresponding DUE receiver
for ii = 1 : numDUE
    %Ϊÿһ��indDUE�û������Ԫ�ط���һ��������û�����indDUE2����
    minDist = 2*d0;
    tmpInd = 0;
    for iii = 1:numVeh
        if any(abs(iii-indDUE)<1e-6) || any(abs(iii-indDUE2)<1e-6) % iii��indDUE�������indDUE2����
            continue;
        end
        newDist = sqrt((vehPos(indDUE(ii), 1)-vehPos(iii,1))^2 + (vehPos(indDUE(ii), 2)-vehPos(iii,2))^2);
        if newDist < minDist
            tmpInd = iii;
            minDist = newDist;
        end
    end
    indDUE2(ii) = tmpInd; % �����DUE�û���
end

cntCUE = numDUE+1; % �ų���indDUE������û�
while cntCUE <= numVeh
    if any(abs(indPerm(cntCUE)-indDUE2)<1e-6) % ��indDUE2�����Ԫ��ʲôҲ����
    else
        indCUE = [indCUE indPerm(cntCUE)];
    end
    cntCUE = cntCUE + 1;
    if length(indCUE) >= numCUE
        break
    end
end
indCUE = indCUE(:);
indDUE = indDUE(:);
indDUE2 = indDUE2(:);


%��ͼ����
x0=0;                          %����Բ������ı߿�
y0=0;
r=d0;
theta=0:pi/50:2*pi;
x1=x0+r*cos(theta);
y1=y0+r*sin(theta);
x=vehPos(indCUE,1);
y=vehPos(indCUE,2);
plot(x0,y0,'sk',x,y,'v');
hold on;
x2=vehPos(indDUE,1);
y2=vehPos(indDUE,2);
x3=vehPos(indDUE2,1);
y3=vehPos(indDUE2,2);
plot(x2,y2,'r*',x3,y3,'b*');
plot(x1,y1,'-k')
hold on
hold off
legend('BS','CU','DTx','DRx');
axis equal

end

