
""" epsilon greedy method"""
""" kianfarooghi@gmail.com """

# generate random Gaussian values
from numpy import random
import numpy as np
import matplotlib.pyplot as plt
import numpy.matlib

k = 10;
N = 1000;
Episode_num = 1500
eps = 0.1;
""" """
selected_action=np.zeros((N,Episode_num));
reward = np.zeros((N,Episode_num));
Optimal_action =np.zeros((1,Episode_num))
for n in range(0,Episode_num):
    
    Q_star = random.normal(size=(1, k))    
    maximum_val = Q_star.max()
    temp = np.where(Q_star==maximum_val)
    Optimal_action[0,n] = temp[1]; 
   
 
    Q = np.zeros(k)
    counter = np.zeros(k)
    for t in range(0,N):
      
        
        maximum_Q = Q.max()
        action = np.where(Q==maximum_Q)
        action = action[0]; 
        if len(action)-1>0 :
         action=action[random.randint(0,len(action)-1)];
        
        
        if random.uniform(0,1)<eps:
            action =random.randint(0,k)
        
        
        selected_action[t,n] = action;
        counter[action]+=1
        reward[t,n]=Q_star[0,action] +random.normal(0, 1, 1)[0]
       
    
        Q[action]=Q[action] + 1/counter[action]*( reward[t,n] - Q[action] );
    np.disp("episode :" +np.str_(n+1) + "/" + np.str_(Episode_num))
     
average_reward=np.mean(reward,axis=1)
np.disp("")
Optimal_action_percent=np.zeros((Episode_num,Episode_num))

Optimal_action_percent = (selected_action == np.matlib.repmat(Optimal_action ,len(selected_action) ,1))*1
Optimal_action_percent1 = np.mean(Optimal_action_percent,axis=1)

x= np.arange(0, t, 1)
plt.plot(range(0,N),average_reward )
plt.title('e-Greegy Average Rewards')
plt.show();

"""plt.plot(range(0,N), selected_action)
 plt.title('selected action')
 plt.show()"""
x= np.arange(0, t, 1)
plt.plot(range(0,N),Optimal_action_percent1*100 )
plt.title('e-Greegy Optimal Selected Actions')
plt.show();
