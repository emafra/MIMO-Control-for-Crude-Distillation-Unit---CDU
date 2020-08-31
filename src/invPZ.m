function invPZ = invPZ(D)

    sizeD1 = size(D,1);
    sizeD2 = size(D,2);
    Df = tf(0,1)*zeros(sizeD1,sizeD2);
    for j = 1:sizeD2
        for h = 1:sizeD1
            n = 0;
            if isempty(zero(D(h,j))) == 1
                Df(h,j) = D(h,j);
            else
                %% Zero analysis
                [zD,gainD] = zero(D(h,j));
                sizeZ = size(zD,1);
                for i = 1:sizeZ   
                    if real(zD(i))>0
                        zD(i) = -1*zD(i);
                        n = n+1;
                    end
                end
                %% Pole analysis
                pD = pole(D(h,j));
                sizeD = size(pD,1);
                for i = 1:sizeD   
                    if real(pD(i))>0
                        pD(i) = -1*pD(i);
                        n = n+1;
                    end
                end
                aux = (-1)^n;
                aux2 = gainD*aux;
    %             Df(h,j) = zpk(zero(D(h,j))',pD',gainD(h,j));
                Df(h,j) = zpk(zD',pD',aux2);            
            end
        end
    end
    
    invPZ = Df;

end