% This functions generates Markov Randon Fields
% 《Markov Random Field Modeling in Image Analysis》 Chapter 2 
%  MRF texture Modeling
% 运用的是 Metropolis sampler
% Input:
%		image size as an array (ex [32 32]);
%		nb_levels: Number of levels of the random field
% Examples:
%		generate_MRF([32,32],2);
%		generate_MRF([32,32],5);


function a = generate_MRF_MCMC(size,nb_levels)

a = fix(nb_levels*rand(size(1),size(2)));
imshow(a,[0,nb_levelss-1]);

energ = 10*ones(size(1),size(2));
pause;

%for i = 1 : 3
  %for j = 1 : 3
  %  mask(i,j) = 1/3;
 % end
%end
mask = [0 1 0; 1 0 1;0 1 0];
T = 1;
cnt = 0;
alpha = 2;
for  i = 1 : 100
   for j = 2 : size(1)-1
      for k = 2 : size(2)-1
        diff1=((a(j-1:j+1,k-1:k+1)-a(j,k))~=0).*mask;
        eq1=((a(j-1:j+1,k-1:k+1)-a(j,k))==0).*mask;
        energ(j,k)=sum(sum(diff1-eq1));
          newenerg = 0;
        %new = fix(mean(mean(a(j-1:j+1,k-1:k+1)))/2+nb_levels/2*rand(1,1));
        finish =0;
        while ~finish 
            new = fix(nb_levels*rand(1,1));
            if (new ~= a(j,k))
               finish = 1;
            end
         end
         %new
         %a(j-1:j+1,k-1:k+1)
         diff = ((a(j-1:j+1,k-1:k+1)-new)~=0).*mask;
         eq = ((a(j-1:j+1,k-1:k+1)-new)==0).*mask;
         newenerg = sum(sum(diff-eq));
         %newenerg = sum(sum(((a(j-1:j+1,k-1:k+1)-new).^alpha.*mask)));
         r = exp(-newenerg)/exp(-energ(j,k));
         if  (r > 1)
            a(j,k) = new;
            energ(j,k) = newenerg;
         elseif r > (1-T);
            a(j,k) = new;
            energ(j,k) = newenerg;
         end
      end
   end	
   i
   T = T /log((100+i))*log(100) 
   if (mod(i,10) == 0)
      imshow(a(2:size(1)-1,2:size(2)-1),[0,nb_levels-1])
      pause;
   end	
end	
