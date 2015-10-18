function [w,bbb,V,simida] = smo2( sample1, sample2,C )
    %输出w为权向量
    %输出bbb为软间隔
    %输出V为支持向量
    %输出simida为0表示线性可分，1表示线性不可分。


    % 样本预处理
    [n1, m1] = size(sample1);
    [n2, m2] = size(sample2);
    
    if (m1 ~= m2)
        disp('E');
        return;
    end
    
    
    n = n1 + n2;
    target = [ones(n1,1);-ones(n2,1)];
    point = [sample1;sample2];
    

    
    
    % SVM描述
    w = zeros(1, m1);
    b = 0;
    
    % 拉格朗日乘子
    alpha = zeros(n, 1);
    E=zeros(n,1);
    for ek=1:n
        E(ek)=nonline(ek)-target(ek);
    end
    
    numChanged = 0;
    examineAll = 1;
    eps0=0.00001;
    tol=0.001;
    
    function lll=nonline(k)
        lll=0;
        for ik=1:n
            if (alpha(ik)>0)
                lll=lll+alpha(ik)*target(ik)*(point(ik,:)*point(k,:)');
            end
        end
        lll=lll-b;
    end
    
    function vv= SVM( index )
        vv = sign(w * point(index,:)' + b);
    end

    function result = takeStep( i1, i2 )
        result = 0;
        if (i1 == i2)
            return; 
        end
        
        alph1 = alpha(i1);
        y1 = target(i1);
        alph2 = alpha(i2);
        y2 = target(i2);
        s = y1 * y2;
        if (alph1>0)&&(alph1<C)
            E1=E(i1);
        else
            E1=nonline(i1)-y1;
        end
        if (alph2>0)&&(alph2<C)
            E2=E(i2);
        else
            E2=nonline(i2)-y2;
        end
        
        if s<0
            L = max(0, alph2 - alph1);
            H = min(C, C + alph2 - alph1);
        else
            L = max(0, alph2 + alph1 -C);
            H = min(C, alph2 + alph1);
        end
        if (L == H)
            return;
        end
        k11 = point(i1,:)*point(i1,:)';
        k12 = point(i1,:)*point(i2,:)';
        k22 = point(i2,:)*point(i2,:)';
        eta = k11 + k22 - 2 * k12;
        if (eta > 0)
            a2 = alph2 + y2 * (E1 - E2) / eta;
            if (a2 < L)
                a2 = L;
            elseif (a2 > H)
                a2 = H;
            end
        else
            
            %计算目标函数最小最大值
            c1=eta/2;
            c2=y2*(E1-E2)-eta*alph2;
            Lobj=c1*L*L+c2*L;
            Hobj=c1*H*H+c2*H;
            if (Lobj < Hobj - eps0)
                a2 = L;
            else
                if (Lobj > Hobj + eps0)
                    a2 = H;
                else
                    a2 = alph2;
                end
            end
        end
        if (abs(a2 - alph2) < eps0 * (a2 + alph2 + eps0))
            return;
        end
        a1 = alph1 + s * (alph2 - a2);
        % 更新b
        tempb=b;
        b1=E1+y1*(a1-alph1)*(point(i1,:)*point(i1,:)')+y2*(a2-alph2)*(point(i1,:)*point(i2,:)')+b;
        b2=E2+y1*(a1-alph1)*(point(i1,:)*point(i2,:)')+y2*(a2-alph2)*(point(i2,:)*point(i2,:)')+b;
        if (0<a1)&&(a1<C)
            b=b1;
        elseif (0<a2)&&(a2<C)
            b=b2;
        else
            b=(b1+b2)/2;
        end
        
        %更新w
        w = w + y1 * (a1 - alph1) * point(i1,:) + y2 * (a2 - alph2) * point(i2,:);
        
        %更新E
        t1=y1*(a1-alph1);
        t2=y2*(a2-alph2);
        for it=1:n
            if(0<alpha(it))&&(alpha(it)<C)
                E(it)=E(it)+t1 * (point(i1,:)*point(it,:)') + t2 *(point(i2,:)*point(it,:)')+tempb-b;
            end
        end
        E(i1)=0;
        E(i2)=0;
        
        % 更新alpha
        alpha(i1,:) = a1;
        alpha(i2,:) = a2;
        result = 1;
    end
    
    function changes = examineExample ( index )
        % 通过i2寻找i1，并对i1,i2进行优化
        y2 = target(index);
        alph2 = alpha(index);
        if (alph2>0)&&(alph2<C)
            E2=E(index);
        else
            E2=nonline(index)-target(index);
        end
        r2 = E2 * y2;
        if ((r2 < -tol && alph2 < C) || (r2 > tol && alph2 >0))
            % 第一步，启发式
            rec = index;
            for i1 = 1:1:n
                if (alpha(i1) ~= 0 && alpha(i1) ~= C)
                    if (abs(E(i1) - E(index)) > abs(E(rec) - E(index)))
                        rec = i1;
                    end
                end
            end
            if rec ~= index && takeStep(rec, index)
                changes = 1;
                return;
            end
            % 第二步，循环所有非0非C
            for ii = 1:n
                if alpha(ii) ~= 0 && alpha(ii) ~= C && takeStep(ii, index)
                    changes = 1;
                    return;
                end
            end
            % 第三步，循环所有
            for ii = 1:n
                if takeStep(ii, index)
                    changes = 1;
                    return;
                end
            end
        end
        changes = 0;
    end

    time=0;
    simida=0;
    while (numChanged >0 || examineAll == 1)
        time=time+1;
        if time>10000
            simida=1;
            disp('not line');
            return;
        end
        numChanged = 0;
        % 测试样本
        if (examineAll == 1)
            for iu = 1:n
                numChanged = numChanged + examineExample(iu);
            end
        else
            
        end
        % 更新标记变量
        if (examineAll == 1)
            examineAll = 0;
        else
            examineAll = 1;
        end
    end
    V=[];
    for vk=1:n
        if (alpha(vk)>0)&&(alpha(vk)<=C)
            V=[V ;point(vk,:)];
        end
    end
    bbb=-b;

end