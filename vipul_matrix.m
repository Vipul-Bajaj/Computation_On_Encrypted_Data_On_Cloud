%Author : Vipul Bajaj
%Project Title : Encryption of Matrices
%Here we will be encrypting two matrices namely DATA1 and DATA2
%and the product of both will be computed.
%The encryption of matrices is performed as follows:
%Encrypt ( Matrix DATA1 ) = X1*DATA1*X2 + Z
%Encrypt ( Matrix DATA2 ) = inv(X2)*DATA1*X3 + Z
%where X1,X2,X3,Z are random matrices of same order as of our DATA matrices.
%X is the column which is being geberated for Verification.

M= str2num(argv(){1});
%Generating all the random matrices.
R1 = randi([10,99])*rand(M,1);
R2 = randi([10,99])*rand(M,1);
X1 = circshift(R1.*eye(M),-2); 
X2 = circshift(R2.*eye(M),-4);
X3 = circshift(R1.*eye(M),-2);
Z = circshift(7*eye(M),-3);
INVX1 = 1./X1';
INVX1(~isfinite(INVX1))=0;  % Inverse of X1
INVX2 = 1./X2';
INVX2(~isfinite(INVX2))=0;  % Inverse of X2
INVX3 = 1./X3';
INVX3(~isfinite(INVX3))=0;  % Inverse of X3
X = randi([0,1],M,1); % Column Matrix for Verification


% Encypting DATA1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DATA1 =  ceil(12.56 * rand(M,M));
E1 = X1*DATA1*X2;
Result =  E1 + Z ; 
%Encyption complete 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Encypting A2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DATA2 =  ceil(12.56 * rand(M,M));
E2 = INVX2*DATA2*X3;
Result2 =  E2 + Z ; 
%Encyption complete
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Plain Multiplication for Verification
tic;
plain_Mul = DATA1*DATA2; 
t_original = toc;


% Multiplying encrypted matrices 
tic;
Encry_mul = Result*Result2;
t_encrypt = toc;


% Decryption of the Matrices
tic;
temp =  Encry_mul - Z*Z - E1*Z - Z*E2;
Decrypted_ANS = (INVX1*temp*INVX3);
t_decrypt = toc;
% End of Decryption


% Verification of the Results
tic;
int32(Decrypted_ANS * X) == plain_Mul * X;
t_verifiy = toc;
% End of Verification


if(int32(Decrypted_ANS * X) == plain_Mul * X)
  printf("\nSuccess\n");
else
  printf("\nUnsuccessful");
end

printf("For %dx%d Matrix the timing values are\n",M,M);
t_client = t_encrypt + t_decrypt + t_verifiy;
printf("T-Original = %.15f seconds\n",t_original);  %Time taken for plain multiplication. 
printf("T-Encryption = %.15f seconds\n",t_encrypt); %Time taken for encryption.
printf("T-Decryption = %.15f seconds\n",t_decrypt); %Time taken for decryption.
printf("T-Verification = %.15f seconds\n",t_verifiy); %Time taken for verification.
printf("T-Client = %.15f seconds\n",t_client); %Total time taken by Client. 
printf("Gain = %.15f\n",t_original/t_client);
clear;
