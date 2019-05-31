function [ combinedPL ] = genPL(linkType, stdShadow, dist, hgtTX, hgtRX, freq)
%genPL:�����߶�˥�������·��˥��+��ӰЧӦ��
%���룺linkType��ѡ��ģʽ����V2V�����ߡ�V2I��
%      stdShadow��������̬�ֲ�����Ӱ˥��ƽ���dB��
%      dist��TX��RX֮��ľ��루m��
%      heightTX�����߷��Ͷ˵ĸ߶ȣ�m��
%      heightRX�����߽��ն˵ĸ߶ȣ�m��
%      freq���ز�Ƶ�ʣ�Ghz��
%
%�����combinedPL�����ϴ�߶�˥��ֵ��·��˥��+��ӰЧӦ��


if strcmp(upper(linkType), 'V2V')
    d_bp = 4*(hgtTX-1)*(hgtRX-1)*freq*10^9/(3*10^8);
    A = 22.7; B = 41.0; C = 20;
    if dist <= 3
        PL = A*log10(3) + B + C*log10(freq/5);
    elseif dist <= d_bp
        PL = A*log10(dist) + B + C*log10(freq/5);
    else
        PL = 40*log10(dist)+9.45-17.3*log10((hgtTX-1)*(hgtRX-1))+2.7*log10(freq/5);
    end
else
    PL = 128.1 + 37.6*log10(sqrt((hgtTX-hgtRX)^2+dist^2)/1000);
end

combinedPL = - (randn(1)*stdShadow + PL);

end