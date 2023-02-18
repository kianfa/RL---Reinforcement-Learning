clc;
clear;
close all;
%%
k = 10 ;    %% 1-0.1+0.1/10 = 0.91

N = 2000 ; %% time steps
nEpisode = 2000 ;

SelectedActions = zeros(N , nEpisode);
Reward = zeros(N , nEpisode);
OptimalAction = zeros(1 , nEpisode);

epsilon = 0.1 ;   %% 1-0.2+0.2/10 = 0.82


for e = 1:nEpisode
    qs = randn(1,k) ;
    [~ , OptimalAction(e)] = max(qs) ;
    
    Q = zeros(1 , k); 
    Counter = zeros(1 , k);

    for t = 1:N
       
        maxQ = max(Q) ;
        A = find(Q == maxQ) ;
        A = A(randi(numel(A) , 1));
        
        % Exploration
        if rand < epsilon  %% [0 1]  epsilon = 0.1
            A =  randi(k , 1);
        end
        
        SelectedActions(t , e) = A ;
        Counter(A) = Counter(A)+1 ;
        
        Reward(t , e) = qs(A) + randn(1) ;
        
        Q(A) = Q(A) + 1/Counter(A)*(Reward(t , e) - Q(A)) ;
    end
    disp(['Episode ('  num2str(e) '/' num2str(nEpisode) ')']);
end

AverageReward = mean(Reward , 2);

OAP = zeros(N , nEpisode) ;

for e = 1:nEpisode
    OAP(: , e) = SelectedActions(: , e) == OptimalAction(e) ;
end
OAP = mean(OAP , 2);


% disp(['Optimal Action Percent = ' num2str(OAP*100) '%']);


Fig = figure(1) ;
Fig.Color = [1 1 1];
subplot(211);
plot(AverageReward , 'linewidth' , 3) ;
grid on
xlabel('Time Step' , 'fontsize' , 14 , 'fontweight' , 'bold') ;
ylabel('Reward' , 'fontsize' , 14 , 'fontweight' , 'bold') ;
title('e-Greegy Average Rewards' , 'fontsize' , 14 , 'fontweight' , 'bold') ;


Fig = figure(1) ;
Fig.Color = [1 1 1];
subplot(212);
plot(OAP*100 , 'linewidth' , 3) ;
grid on
xlabel('Time Step' , 'fontsize' , 14 , 'fontweight' , 'bold') ;
ylabel('OAP' , 'fontsize' , 14 , 'fontweight' , 'bold') ;
title('e-Greegy Optimal Selected Actions, Optimal Action' , 'fontsize' , 14 , 'fontweight' , 'bold') ;
