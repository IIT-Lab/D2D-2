function [ output_args ] = computeCapacity( a, b )
%����CUE�û������������������еĶ���2
%a/((a-b)*log2)*(exp(1/a)*expint(1/a) - exp(1/b)*expint(1/b))


if a>=(1/700) && b>=(1/700)
    output_args = a/((a-b)*log(2))*(exp(1/a)*expint(1/a) - exp(1/b)*expint(1/b));%expint��ָ�����֡�
elseif a<(1/700) && b<(1/700)
    output_args = a/((a-b)*log(2))*(a - b);
elseif b < (1/700)
    output_args = a/((a-b)*log(2))*(exp(1/a)*expint(1/a) - b); % ���֣�exp(x)*expint(x)= 1/x��x�����ʱ����
elseif a < (1/700)
    output_args = a/((a-b)*log(2))*(a - exp(1/b)*expint(1/b));
end

end

