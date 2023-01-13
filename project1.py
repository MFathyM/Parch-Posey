# -*- coding: utf-8 -*-
"""
Created on Thu Dec 22 19:05:10 2022

@author: MFATHY
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.colors as colors

q1 = pd.read_csv('q1.csv')
q1.info()
ax = q1.iloc[:,0:-1].plot.bar(rot=15, 
                         title='Average quantity sold by top-five sales reps for each product',
                         x = 'sales_rep', 
                         stacked=True)
ax.set_ylabel('Average quantity sold')

q2 = pd.read_csv('q2.csv')
q2.info()
ax = q2.plot.bar(rot=15, 
            title='  Sales percentage of each product at each region',
            x = 'region', 
            stacked=True)
ax.set_ylabel('Sales percantage')

q3 = pd.read_csv('q3.csv')
q3.info()
fig, ax = plt.subplots(figsize=(8, 8))
colormap = plt.cm.viridis
colorlist = [colors.rgb2hex(colormap(i)) for i in np.linspace(0, 0.9, len(q3['channel']))]
for i,c in enumerate(colorlist):
    x = q3['month_difference'][i]
    y = q3['total_usd'][i]
    l = q3['channel'][i]
    ax.scatter(x, y, label=l, s=100, linewidth=0.1, c=c)
ax.legend()
ax.set_title('Time difference between marketing event date and top-sales peak')
ax.set_xlabel('Time difference (Months)')
ax.set_ylabel('Top sales (USD)')
plt.show()

q4 = pd.read_csv('q4.csv')
q4.info()
q4.index = q4['month'].astype(str) + ': ' + q4['sales_rep']
q4 = q4.iloc[:,-1]
q4.plot(kind='barh')
plt.title("Top seller for each month in 2015")
plt.xlabel("Total sales (USD)")

