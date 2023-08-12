% lb is the lower bound: lb=[lb_1,lb_2,...,lb_d]
% up is the upper bound: ub=[ub_1,ub_2,...,ub_d]
% dim is the number of variables (dimension of the problem)

function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
 
    case 'F1'
        fobj = @F1;
        lb=[-2000, -2000, -80, 0, 0, 0];
        ub=[ 2000,  2000,  80, 0, 0, 0];
        grid_size_x=ub(1)-lb(1);
        grid_size_y=ub(2)-lb(2);
        disp(['The Grid size is : ',num2str(grid_size_x),' m x ',num2str(grid_size_y), ' m']);
        dim=6; %predefined
end

end

% F1

function o = F1(x)

w1=0.5;
w2=0.5;
o=(x(5).*w1 + x(6).*w2)/x(4);
end