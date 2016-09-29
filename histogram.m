function out=histogram(clique,theta1)
H=zeros(1,8);
for i=1:8
    if clique{i}(1)==clique{i}(2)
       H(i)= theta1(i)*1;
    else
        H(i)=theta1(i)*(-1);
    end
Ht1=H(1)+H(2);
Ht2=H(3)+H(4);
Ht3=H(5)+H(6);
Ht4=H(7)+H(8);
Histt=[Ht1,Ht2,Ht3,Ht4];
out=sum(H);
end