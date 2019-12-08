function [testdata] = readtest(nclass,nexample,W)
% read test data from the given examples in class
% Input:
%    - nclass: 2 or 3, to read for the 2-class or 3-class examples
%    - nexample: 1 or 2, to read for the first or second example in each case
% following the order presented in the lecture note
% output:
%    - testdata: matrix, each column is one test data and the number
%    of columns is the number of data in the set

if nclass ==2
    if nexample == 1
        fid = fopen('testdata2C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 20]);
        fclose(fid);
        oneMat=ones(1,20);

        
        X=[oneMat;testdata];
        
        Y=W*X;
        Y=Y';
        disp(Y)

        ansY=zeros(length(Y),1);
        for i=1:length(Y)
            [val,idx]=max(Y(i,:));
            disp(idx)
             ansY(i)=idx;
        end
        disp(ansY)
        
    elseif nexample == 2
        fid = fopen('testdata_ESL_2C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 20]);
        fclose(fid);
%     else
%         fid = fopen('testdata2C_uv.txt','r');
%         testdata = fscanf(fid,'%f %f \n',[2, 20]);
%         fclose(fid);
        oneMat=ones(1,20);

        
        X=[oneMat;testdata];
        
        Y=W*X;
        Y=Y';
        disp(Y)

        ansY=zeros(length(Y),1);
        for i=1:length(Y)
            [val,idx]=max(Y(i,:));
            disp(idx)
             ansY(i)=idx;
        end
        disp(ansY)
    end
elseif nclass == 3
    if nexample == 2
        fid = fopen('testdata3C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 30]);
        fclose(fid);
        oneMat=ones(1,30);

        
        X=[oneMat;testdata];
        
        Y=W*X;
        Y=Y';
        disp(Y)

        ansY=zeros(length(Y),1);
        for i=1:length(Y)
            [val,idx]=max(Y(i,:));
            disp(idx)
             ansY(i)=idx;
        end
        fid = fopen('testlabel3C.txt','r');
        testlabel = fscanf(fid,'%d \n',[1, 300]);
        fclose(fid);
        disp(ansY-testlabel');
    else
        fid = fopen('testdata_ESL_3C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 30]);
        fclose(fid);
    end
elseif nclass == 10
       [img, lbl] = read_hw("eigen");
       testdata = img(:,16001:20000);
       oneMat=ones(1,4000);

       trainlabel = lbl(16001:20000)+1;
       YReal=trainlabel;
       
       X=[oneMat;testdata];
       combos = nchoosek(1:30,3)
       for i=1:length(combos)
           X=[X;X(combos(i,1),:).*X(combos(i,2),:).*X(combos(i,3),:)];
       end
        
        Y=W*X;
        writematrix(Y,"Y_tab.txt",'Delimiter','tab');
        type 'Y_tab.txt';
        Y=Y';
        newY=zeros(length(Y),1);
        for i=1:length(Y)
            [val,idx]=max(Y(i,:));
            disp(idx)
            newY(i)=idx;
        end
        Ans=YReal-newY;
        fid = fopen('new.txt','w');
        fprintf(fid,"percentage of correct ans: %f\n ",(length(Ans)-nnz(Ans))/length(Ans));
        fclose(fid);
        writematrix([YReal newY],"Ans_tab.txt",'Delimiter','tab');
       type 'Ans_tab.txt';
       
% else
%         fid = fopen('testdata.txt','r');
%         testdata = fscanf(fid,'%f %f \n',[2, 20]);
%         fclose(fid);
end
end
    
