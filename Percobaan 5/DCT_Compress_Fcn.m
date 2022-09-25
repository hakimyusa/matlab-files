function Cimage = DCT_Compress_Fcn(P,Quan)
    % Size of DCT matrix
    S = 8;

    % Import Image
    M = imread(P);
        M1 = M(:,:,1);
        M2 = M(:,:,2);
        M3 = M(:,:,3);
        
        [m,n] = size(M1);
        w = floor(m/8).*8;
        u = floor(n/8).*8;
        M1 = M(1:w,1:u,1);
        M2 = M(1:w,1:u,2);
        M3 = M(1:w,1:u,3);
            
        M1 = cast(M1,'double');
        M2 = cast(M2,'double');
        M3 = cast(M3,'double');
        
        M1 = M1 - 128;
        M2 = M2 - 128;
        M3 = M3 - 128;

    [m,n] = size(M1);

    % Discrete Cosine Transform Matrix Creation
    T = zeros(S);

        for i = 1:S
            if (i == 1)
                T(1,:) = 1 ./ sqrt(S);

            else
                for j = 1:S
                    T(i,j) = sqrt(2/S) .* cos(((2*(j - 1)+1).*(i - 1)*pi) / (2*S));
                end
            end
        end
    
    %Quantization
    QA = Quant(Quan);

    % Compression Process
    % D=T*M*T'   then   Q=D./F
    p = 1;
    q = 1;

    while q < n
        while p < m
            D1 = T*M1(p:p+(S-1),q:q+(S-1))*T';
            D2 = T*M2(p:p+(S-1),q:q+(S-1))*T';
            D3 = T*M3(p:p+(S-1),q:q+(S-1))*T';
            Q1a(p:p+(S-1),q:q+(S-1)) = round(D1./QA);
            Q2a(p:p+(S-1),q:q+(S-1)) = round(D2./QA);
            Q3a(p:p+(S-1),q:q+(S-1)) = round(D3./QA);

            p = p+S;
        end
        p = 1;
        [~,n2] = size(D1);
        if n2 < n
            q = q+S;
        else 
            break
        end
    end

    % Compressed Images
%    RGBa = cat(3, Q1a, Q2a, Q3a);

    % Decompression / Reconstruction Process
    % R=F.*Q   then   R=T'*R*T
    p = 1;
    q = 1;

    while q  <n
        while p < m
            Da1 = QA.*Q1a(p:p+(S-1),q:q+(S-1));
            Db1 = QA.*Q2a(p:p+(S-1),q:q+(S-1));
            Dc1 = QA.*Q3a(p:p+(S-1),q:q+(S-1));
            R1a(p:p+(S-1),q:q+(S-1)) = round(T'*Da1*T)+128;
            R2a(p:p+(S-1),q:q+(S-1)) = round(T'*Db1*T)+128;
            R3a(p:p+(S-1),q:q+(S-1)) = round(T'*Dc1*T)+128;
            p = p+S;
        end
        p = 1;
        [~,n2] = size(Da1);
        if n2 < n
            q = q+S;
        else 
            break
        end
    end

    % Show Images in Color
    RGB1 = cat(3, R1a, R2a, R3a);
%    images=[M(1:w,1:u,:),RGBa,RGB1];
%    orim=M(1:w,1:u,:);
%    imshow(images,[0 255])
    Cimage = cast(RGB1,'uint8');
end