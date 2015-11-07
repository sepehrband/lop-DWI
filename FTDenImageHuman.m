% Image level denoising using FT with fixed cut off frequency (Human data)
% Farshid Sepehrband - fsepehrband@gmail.com
% June 2014

% Here we assumed that there is 2 b0

function DENOISED = FTDenImage(Noisy,MASK,cut_off)

% num_b0 = 2;

%% Normalized data based on b0

% DW_1    = DW.img;
Noisy_1 = Noisy.img;
vlength = 82;

% Normer = ( double(Noisy_1(:,:,:,1)) + double(Noisy_1(:,:,:,2)) )./2;
for i = 1:vlength
%     dw(:,:,:,i)    = double(DW_1(:,:,:,i+2))./doubl111e(DW_1(:,:,:,1));
    noisy(:,:,:,i) = double(Noisy_1(:,:,:,i+3)); %./Normer;
end

%% Order them in voxel domain and Denoising
% 3D nifti size
n = size(noisy,1);
m = size(noisy,2);
l = size(noisy,3);
voxel_length = size(noisy,4);
% Den_QS     = zeros(n,m,l,voxel_length);

% --------- Faster implementation of FT denoising ---------------------
numVox    = n * m * l;
noisyReshaped = reshape(noisy,numVox,voxel_length);
DenReshaped   = zeros(size(noisyReshaped));
Mas = reshape(MASK,numVox,1);
for i = 1:numVox
    if Mas(i) == 1
        DenReshaped(i,:) = FT_fix_win82(noisyReshaped(i,:)',cut_off);
    end
end
Den = reshape(DenReshaped,n,m,l,voxel_length);
% ---------------------------------------------------------------------

DENOISED = Noisy;
for i = 1:vlength
%     dw(:,:,:,i)    = double(DW_1(:,:,:,i+2))./doubl111e(DW_1(:,:,:,1));
    DENOISED.img(:,:,:,i+3) = double(Den(:,:,:,i)); %.*Normer;
end



% for i = 1:n
%     for j = 1:m
%         for k = 1:l
%             
%             if MASK.img(i,j,k) == 0     % Consider the MASK
%                 Den(i,j,k,:) = 0;
%                 continue
%             else
%             noise_voxel = squeeze(noisy(i,j,k,:));
%             
%             DenTmp  = FT_fix_win82(noise_voxel,cut_off);
% %             den_QS      = Quad_Smooth(noise_voxel,1);
%             
%             Den(i,j,k,:) = DenTmp;
% %             Den_QS(i,j,k,:)     = den_QS;
% 
%             end
%         end
%         
%     end
%     
% end

