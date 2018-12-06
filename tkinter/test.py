from tkinter import *

class Window(Frame):

    def __init__(self, master=None):
        Frame.__init__(self, master)
        self.master = master
        self.init_window()

    def init_window(self):

        self.master.title('bing bing wahoo')
        self.pack(fill=BOTH, expand=1)

        yy = 0
        for x in range(5):
            buttontext = 'testbutton'+str(x+1)
            butt = Button(self, text=buttontext, width=10, height=2)
            butt.place(x=50, y=yy)
            yy += 50
top = Tk()
top.geometry('200x300')
app = Window(top)
top.mainloop()
