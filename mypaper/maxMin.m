function [ assignment, minCapacity ] = maxMin( capacityMat )
%��С��������㷨������Է������⣬ʵ������󻯷�������С��Ԫ�أ��Ƕ��������㷨��ƽ�Է�����иĽ�



[M, K] = size(capacityMat);
costMat1D = reshape(capacityMat, M*K, 1);
[sortVal] = sort(costMat1D, 'ascend');
minInd = 1;
maxInd = K*M;
assignment = ones(1,M);
while (maxInd - minInd) > 1
    mid = floor((minInd + maxInd)/2);
    tmpMat = capacityMat;
    for in = 1 : M
        for ik = 1 : K
            if tmpMat(in,ik) < sortVal(mid)
                tmpMat(in,ik) = 1;
            else tmpMat(in,ik) = 0;
            end
        end
    end
    [asgn, cost] = munkres(tmpMat);
    if cost > 0 
        maxInd = mid;
    else
        minInd = mid;
        assignment = asgn;
    end
end
minCapacity = sortVal(minInd);

end

