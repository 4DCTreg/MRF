load('data1.mat');

[r,c]=size(img);
thetat=unifrnd(-5,5,[1,4]);
T=1;
for k=1:500
Hc=zeros(r,c);
Ht=zeros(r,c);
thetac=zeros(1,4);
theta1=reshape([thetat',thetat']',[1,8]);
thetac(1)=normrnd(thetat(1),0.5);
thetac(2)=normrnd(thetat(2),0.5);
thetac(3)=normrnd(thetat(3),0.5);
thetac(4)=normrnd(thetat(4),0.5);
thetac1=reshape([thetac',thetac']',[1,8]);
P=zeros(r,c);
for i=2:r-1
    for j=2:c-1

        
        neighbor=[img(i-1,j-1) img(i-1,j) img(i-1,j+1);
                  img(i,j-1)   img(i,j)   img(i,j+1);
                  img(i+1,j-1) img(i+1,j) img(i+1,j+1)];
        clique=updateclique(neighbor);
        Ht(i,j)=histogram(clique,theta1);
        Hc(i,j)=histogram(clique,thetac1);
       
       
        
        Hzcr=zeros(1,4);
        Hztr=zeros(1,4);
        for m=0:3
           
            neighborz=[img(i-1,j-1) img(i-1,j) img(i-1,j+1);
                       img(i,j-1)   m          img(i,j+1);
                       img(i+1,j-1) img(i+1,j) img(i+1,j+1)];
            clique1=updateclique(neighborz);
            Hzcr(m+1)=histogram(clique1,thetac1);
            
            Hztr(m+1)=histogram(clique1,theta1);
            
        end
       sumc=exp(Hzcr(1))+exp(Hzcr(2))+exp(Hzcr(3))+exp(Hzcr(4));
       sumt=exp(Hztr(1))+exp(Hztr(2))+exp(Hztr(3))+exp(Hztr(4));
        P(i,j)=Hc(i,j)-Ht(i,j)-log(sumc)+log(sumt);
        
    end
end
Po=exp(sum(sum(P)));
if  Po > 1
    thetat = thetac;
elseif Po > (1-T)
    thetat = thetac;
            
end
T = T /log((100+k))*log(100);

end

