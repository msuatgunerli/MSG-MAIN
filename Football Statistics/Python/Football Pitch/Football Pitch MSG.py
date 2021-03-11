import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Arc
from matplotlib import contour

def drawpitch_v():
    fig = plt.figure()
    fig.set_size_inches(68, 105)
    ax = fig.add_subplot(1, 1, 1)

    #Guardiola sections dikey
    plt.plot([-20.15, -20.15], [-36, 36], color="red")
    plt.plot([-9.15, -9.15], [-36, 36], color="red")
    #plt.plot([0, 0], [-32.35, 32.35], color="blue")
    plt.plot([9.15, 9.15], [-36, 36], color="red")
    plt.plot([20.15, 20.15], [-36, 36], color="red")

    #Guardiola sections yatay
    plt.plot([-34, 34], [-36, -36], color="red")
    plt.plot([-34, -20.15], [-19.5, -19.5], color="red")
    plt.plot([20.15, 34], [-19.5, -19.5], color="red")
    #plt.plot([-34, 34], [0, 0], color="blue")
    plt.plot([-34, -20.15], [19.5, 19.5], color="red")
    plt.plot([20.15, 34], [19.5, 19.5], color="red")
    plt.plot([-34, 34], [36, 36], color="red")

    plt.plot([-34, 34], [52.5, 52.5], color="black") #üst yatay
    plt.plot([34, 34], [-52.5, 52.5], color="black") #sağ dik
    plt.plot([-34, 34], [-52.5, -52.5], color="black") #alt yatay
    plt.plot([-34, -34], [-52.5, 52.5], color="black") #sol dik
    plt.plot([-34, 34], [0, 0], color="black") #orta yatay
    
    #alt ceza sahası
    plt.plot([-20.15, 20.15], [-36, -36], color="black")
    plt.plot([20.15, 20.15], [-52.5, -36], color="black")
    plt.plot([-20.15, -20.15], [-52.5, -36], color="black")
    
    #alt iç
    plt.plot([-9.15, 9.15], [-47, -47], color="black")
    plt.plot([9.15, 9.15], [-52.5, -47], color="black")
    plt.plot([-9.15, -9.15], [-52.5, -47], color="black")

    #üst ceza sahası
    plt.plot([-20.15, 20.15], [36, 36], color="black")
    plt.plot([20.15, 20.15], [36, 52.5], color="black")
    plt.plot([-20.15, -20.15], [36, 52.5], color="black")
    
    #üst iç
    plt.plot([-9.15, 9.15], [47, 47], color="black")
    plt.plot([9.15, 9.15], [52.5, 47], color="black")
    plt.plot([-9.15, -9.15], [52.5, 47], color="black")
    
    #Prepare Circles
    centreCircle = plt.Circle((0, 0), 9.15, color="black", fill=False)
    centreSpot = plt.Circle((0, 0), 0.5, color="black")
    downPenSpot = plt.Circle((0, -41.5), 0.5, color="black")
    upPenSpot = plt.Circle((0, 41.5), 0.5, color="black")
    
    #Draw Circles
    ax.add_patch(centreCircle)
    ax.add_patch(centreSpot)
    ax.add_patch(downPenSpot)
    ax.add_patch(upPenSpot)
    
    #Prepare Arcs
    leftArc = Arc((0, -41.5), height=18.3, width=18.3, angle=0,
                theta1=36.95, theta2=143.05, color="black")
    rightArc = Arc((0, 41.5), height=18.3, width=18.3, angle=0,
                theta1=216.95, theta2=323.05, color="black")

    #Draw Arcs
    ax.add_patch(leftArc)
    ax.add_patch(rightArc)

    plt.axis('equal')
    plt.show()

plot_v = drawpitch_v()
