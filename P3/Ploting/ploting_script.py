import pandas as pd
import matplotlib.pyplot as plt

headers = ['Month', 'Babies']
df = pd.read_csv('results.csv', names=headers)

df.plot.bar('Month')
plt.show()