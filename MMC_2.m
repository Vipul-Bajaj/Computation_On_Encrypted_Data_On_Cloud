% Author : Harsh Pathak & Vipul Bajaj
% 15 sept 2017
% All the Sparse Matrices are Diagonal in nature or its permutations
% Inverse of only Diagonal Sparse matrices is guranteed to be sparse
% Platform : Octave
% All rights reserved to the Authors 

M= str2num(argv(){1});;


%Generating all the random matrices.

DATA1 =  ceil(12 * rand(M,M));
DATA2 =  ceil(13 * rand(M,M));

% ***  Plain Matrix Multiplication  *** 
tic 
plain_Mul = DATA1*DATA2;
t_original = toc; 

%Sparse Matrices Generation;
tic;
Zsparse = circshift(speye(M),-5);
CM = randi([0,1],M,1); % coloum matrix
t_sparse = toc;

% ENCRYPTION 
tic 
EncDATA1 = DATA1 + Zsparse;
EncDATA2 = DATA2 + Zsparse;
t_encrypt=toc;

% CLOUD SIDE 
tic;
Result = EncDATA1*EncDATA2;
t_cloud = toc;

% Decryption
tic
T = Zsparse*Zsparse + DATA1*Zsparse + Zsparse*DATA2;
Decry_Ans = ((Result - T));
t_decrypt=toc;

% Verification
tic;
int32 (round(Decry_Ans) * CM) == plain_Mul*CM;
t_verifiy = toc;

if(int32 (round(Decry_Ans) * CM) == plain_Mul*CM)
  printf("\nSuccess\n");
else
  printf("\nUnsuccessful\n");
end

t_client = t_encrypt + t_decrypt + t_verifiy + t_sparse;
printf("For %dx%d Matrix the timing values are\n",M,M);
printf("T-Original = %.15f seconds\n",t_original);  %Time taken for plain multiplication. 
%printf("T-Cloud = %.15f seconds\n",t_cloud); Time taken for encrypted matrices multiplication. 
%printf("Efficiency = %.2f %%\n",(t_original/t_cloud)*100);  Caluculating the efficiency.

%For Client uncomment the below lines and comment the above 2 lines
printf("T-Encryption = %.15f seconds\n",t_encrypt+t_sparse); %Time taken for encryption.
printf("T-Decryption = %.15f seconds\n",t_decrypt); %Time taken for decryption.
printf("T-Verification = %.15f seconds\n",t_verifiy); %Time taken for verification.
printf("T-Client = %.15f seconds\n",t_client); %Total time taken by Client. 
printf("Gain %% = %.2f %%\n",(t_original/t_client)*100); % Calculating Gain.
clear;
