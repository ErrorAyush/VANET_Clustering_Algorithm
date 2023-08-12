function [Best_flame_score,Best_flame_pos]=MFO1(N,Max_iteration,lb,ub,dim,fobj,Tx)

disp('Optimizing Your Problem...');

%Initialize the positions of moths
Moth=initialization(N,dim,ub,lb);

Scores=zeros(1,Max_iteration);

Iteration=1;
stall_iteration=0;

% Main loop
while ((Iteration<=Max_iteration) && stall_iteration<=15)
    
    % Number of flames
    Flame_no=round(N-Iteration*((N-1)/Max_iteration));

    %formation of dist and velocity matrix
    for i=(1:N)
        count = 0;
        for j=(1:N)
            dist(i,j)=abs(sqrt((Moth(i,1)-Moth(j,1)).^2 + (Moth(i,2)-Moth(j,2)).^2));
            vel(i,j)=abs(Moth(i,3)-Moth(j,3));
            if dist(i,j)>2*Tx
                dist(i,j)=0;
                vel(i,j)=0;
                count=count+1;
            end
        end
        Moth(i,4)=N-count; % Connected Nodes/ Nodes in Range
    end
    
    for i=(1:N)
        % Calculate the fitness of moths
        Moth_fitness(1,i)=fobj(Moth(i,:));  % Generating OM Matrix
        
    end
       
    if Iteration==1
        % Sort the first population of moths
        [fitness_sorted, I]=sort(Moth_fitness);
        sorted_population=Moth(I,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    else
        
        % Sort the moths
        double_population=[previous_population;best_flames];
        double_fitness=[previous_fitness best_flame_fitness];
        
        [double_fitness_sorted, I]=sort(double_fitness);
        double_sorted_population=double_population(I,:);
        
        fitness_sorted=double_fitness_sorted(1:N);
        sorted_population=double_sorted_population(1:N,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    end
    
    % Update the position best flame obtained so far
    Best_flame_score=fitness_sorted(1);
    Best_flame_pos=sorted_population(1,:);
      
    previous_population=Moth;
    previous_fitness=Moth_fitness;
    
    % a linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a=-1+Iteration*((-1)/Max_iteration);
    
    for i=1:N
        
        for j=1:dim
            if i<=Flame_no % Update the position of the moth with respect to its corresponding flame
                
                % Dist. to flame
                distance_to_flame=abs(sorted_population(i,j)-Moth(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                Moth(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j);
            end
            
            if i>Flame_no % Update the position of the moth with respct to one flame
                
                distance_to_flame=abs(sorted_population(i,j)-Moth(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                Moth(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j);
            end
            
        end
        
    end
    
    Scores(Iteration)=Best_flame_score;
    if(Iteration>1 && (Scores(Iteration) == Scores(Iteration-1)))
        stall_iteration = stall_iteration+1;
    else
        stall_iteration = 0;
    end
    
    % Display the iteration and best optimum obtained so far
    if mod(Iteration,50)==0
        display(['At iteration ', num2str(Iteration), ' the best fitness is ', num2str(Best_flame_score)]);
    end
    Iteration=Iteration+1; 
end

total_nodes=0;
Total_no_of_cluster=0;
for i=1:N
    if(total_nodes<N)
        total_nodes=total_nodes+best_flames(i,4);
        Total_no_of_cluster=Total_no_of_cluster+1;
    end
end
display(['Total No. of Optimum cluster is ', num2str(Total_no_of_cluster)]);
