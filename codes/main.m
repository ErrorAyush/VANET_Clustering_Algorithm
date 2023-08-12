clear all 
clc


SearchAgents_no=100; % Number of search agents
display(['Total Number of Search Agents are : ', num2str(SearchAgents_no)]);
Function_name='F1';

Max_iteration=1000; % Maximum number of iterations
Tx=400;
display(['Transmission Range is : ', num2str(Tx),'m']);

[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

[Best_score,Best_pos]=MFO1(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,Tx);

% display(['The best solution obtained by MFO is : ', num2str(Best_pos)]);

        



