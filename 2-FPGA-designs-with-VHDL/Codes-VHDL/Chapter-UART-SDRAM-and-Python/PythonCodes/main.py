import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig = plt.figure()
ax1 = fig.add_subplot(2,1,1)
ax2 = fig.add_subplot(2,1,2)

def animate(i):
    readData = open("sineData.txt","r").read()
    data = readData.split('\n')
    sin_array = []
    cos_array = []
    for d in data:
        if len(d)>1:
            sin, cos = d.split(',')
            sin_array.append(sin)
            cos_array.append(cos)
    ax1.clear()
    ax1.plot(sin_array)

    ax2.clear()
    ax2.plot(cos_array)

def main():
    ani = animation.FuncAnimation(fig, animate)
    plt.show()

if __name__ == '__main__':
    main()