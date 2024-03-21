import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Reading data from CSV file about bank Pekao
data = pd.read_csv('peo_d.csv')  
#
y = data['Zamkniecie'].to_numpy()
x = np.arange(1, 1001)

#EMA
def exponential_moving_average(data, N):
    alpha = 2 / (N + 1)
    base = 1 - alpha
    
    ema_values = []
    for i in range(len(data)):
        numerator = sum(pow(base, j) * data[i - j] for j in range(min(N + 1, i + 1)))
        denominator = sum(pow(base, j) for j in range(min(N + 1, i + 1)))
        ema = numerator / denominator if denominator != 0 else 0.0
        ema_values.append(ema)
    
    return ema_values


EMA_12 = exponential_moving_average(data['Zamkniecie'],12)
EMA_26 = exponential_moving_average(data['Zamkniecie'],26)

# MACD
MACD = np.array(EMA_12) - np.array(EMA_26)

# SIGNAL (9 periods from MACD)
SIGNAL = exponential_moving_average(MACD,9)

# Initialize capital and shares
initial_capital = 1000
shares_owned = 1000

# Transaction statistics
transaction_stats = {'Date': [], 'Type': [], 'Price': [], 'Shares': [], 'Profit/Loss': []}

# Buy/sell logic
for i in range(1, len(MACD)):
    if MACD[i] > SIGNAL[i] and MACD[i - 1] <= SIGNAL[i - 1]:
        # Buy shares
        price = y[i - 1]  # Assuming buying at the closing price of the previous day
        shares_bought = 0.01  # Buying 0.01 part of the share
        shares_owned += shares_bought
        transaction_stats['Date'].append(data['Data'][i - 1])
        transaction_stats['Type'].append('Buy')
        transaction_stats['Price'].append(price)
        transaction_stats['Shares'].append(shares_bought)
        transaction_stats['Profit/Loss'].append(0)  # No profit/loss for buying
    elif MACD[i] < SIGNAL[i] and MACD[i - 1] >= SIGNAL[i - 1]:
        # Sell shares
        price = y[i - 1]  # Assuming selling at the closing price of the previous day
        shares_sold = shares_owned * 0.01  # Selling 0.01 part of the owned shares
        shares_owned -= shares_sold
        transaction_stats['Date'].append(data['Data'][i - 1])
        transaction_stats['Type'].append('Sell')
        transaction_stats['Price'].append(price)
        transaction_stats['Shares'].append(shares_sold)
        transaction_stats['Profit/Loss'].append((price - y[i - 2]) * shares_sold)  # Profit/Loss calculation

# Calculate total profit/loss
total_profit_loss = sum(transaction_stats['Profit/Loss'])

# Draw conclusions about the usefulness of MASD
if total_profit_loss > 0:
    print("MACD strategy is profitable.")
else:
    print("MACD strategy is not profitable.")

# Print transaction statistics

pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
transaction_df = pd.DataFrame(transaction_stats)
print("\nTransaction Statistics:")
print(transaction_df)
print("\nTotal cash capital :")
print(1000 + total_profit_loss)
print("\nProfit/loss :")
print(total_profit_loss)



# Plots generating
plt.figure(figsize=(10, 6))

# Plotting Financial Instrument's Closing Prices
plt.subplot(2, 1, 1)
plt.plot(x, y, label='Ceny zamknięcia', color='blue')
plt.title('Instrumentu finansowy cen zamknięcia')
plt.xlabel('Dni')
plt.ylabel('Cena')
plt.legend()


# Plotting MACD and SIGNAL with buy/sell points
plt.subplot(2, 1, 2)
plt.plot(x, MACD, label='MACD', color='red')
plt.plot(x, SIGNAL, label='SIGNAL', color='green')
plt.title('MACD and SIGNAL')
plt.xlabel('Dni')
plt.ylabel('Wartość')
  
buy_signals = []
sell_signals = []
intersection_points = []

for i in range(1, len(MACD)):
    if MACD[i] > SIGNAL[i] and MACD[i - 1] <= SIGNAL[i - 1]:
        buy_signals.append(i)
        intersection_points.append((x[i], MACD[i]))
    elif MACD[i] < SIGNAL[i] and MACD[i - 1] >= SIGNAL[i - 1]:
        sell_signals.append(i)
        intersection_points.append((x[i], MACD[i]))

buy_x, buy_y = zip(*intersection_points)
plt.scatter(buy_x, buy_y, color='blue', marker='o', label='Punkty przecięcia')

plt.scatter(buy_signals, MACD[buy_signals], color='green', marker='^', label='Kupno')
plt.scatter(sell_signals, MACD[sell_signals], color='red', marker='v', label='Sprzedaż')

plt.legend()
plt.grid(True)

plt.tight_layout()
plt.show()

plt.figure(figsize=(12, 4))

# Plotting Financial Instrument's Closing Prices
plt.plot(x, y, label='Ceny zamknięcia', color='blue')
plt.title('Instrument finansowy cen zamknięcia wraz z punktami kupna/sprzedaży')
plt.xlabel('Dni')
plt.ylabel('Cena')
plt.legend()

# Plotting Buy/Sell Points on Financial Instrument's Closing Prices
plt.scatter(buy_signals, y[buy_signals], color='green', marker='^', label='Punkt kupna')
plt.scatter(sell_signals, y[sell_signals], color='red', marker='v', label='Punkt sprzedaży')

plt.legend()
plt.grid(True)

plt.show()

