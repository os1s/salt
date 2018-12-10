#!/usr/bin/python3

from tkinter import *
import webbrowser as w

class Window(Frame):

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.init_window()

    def open_url(self):
        w.open('http://terokarvinen.com/2018/aikataulu--palvelinten-hallinta-ict4tn022-3004-ti-ja-3002-to--loppukevat-2018-5p')

    def init_window(self):

        self.master.title('bing bing wahoo')
        self.pack(fill=BOTH, expand=1)

        butt = Button(self, text='kurssisivut', width=10, height=2, command=self.open_url)
        butt.place(x=50, y=50)

top = Tk()
top.geometry('200x300')
app = Window(top)
top.mainloop()
