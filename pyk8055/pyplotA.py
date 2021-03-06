#!/usr/bin/env python
# $Id: pyplotA.py,v 1.2 2007/03/15 14:55:38 pjetur Exp $
#
# Simple plotting of analog input data from the K8055 board
#
# based on the running plot sample from pyQwt
# The Python version of qwt-*/examples/data_plot/data_plot.cpp

import sys
from Numeric import *
from PyQt4.Qt import *
from PyQt4.Qwt5 import *
from pyk8055 import k8055

class DataPlot(QwtPlot):

    def __init__(self, *args):
        QwtPlot.__init__(self, *args)

        # Initialize data
        self.x = arrayrange(0.0, 100.1, 0.5)
        self.a1 = zeros(len(self.x), Float)
        self.a2 = zeros(len(self.x), Float)

        self.setTitle("Simple K8055 datascope")
        self.insertLegend(Qwt.QwtLegend(), Qwt.QwtPlot.BottomLegend);

        self.curve1 = QwtPlotCurve("Input 1")
        self.curve2 = QwtPlotCurve("Input 2")

        self.curve1.attach(self)
        self.curve2.attach(self)

        self.curve1.setPen(QPen(Qt.red))
        self.curve2.setPen(QPen(Qt.green))

        # No automatic scaling, set y-scale 0-255
        self.setAxisScale(QwtPlot.yLeft,0,255,50)

        mY = Qwt.QwtPlotMarker()
        mY.setLineStyle(Qwt.QwtPlotMarker.HLine)
        mY.setYValue(128.0)
        mY.attach(self)

        self.setAxisTitle(QwtPlot.xBottom, "Time (seconds)")
        self.setAxisTitle(QwtPlot.yLeft, "Values")

        self.startTimer(50)

        self.k = k8055(0)
    # __init__()

    def timerEvent(self, e):

        # data moves from left to right:
        # shift data array right and assign new value data[0]

        self.a1 = concatenate((self.a1[:1], self.a1[:-1]), 1)
        self.a1[0] = self.k.ReadAnalogChannel(1)

        self.a2 = concatenate((self.a2[:1], self.a2[:-1]), 1)
        self.a2[0] = self.k.ReadAnalogChannel(2)

        self.curve1.setData(self.x, self.a1)
        self.curve2.setData(self.x, self.a2)

        self.replot()
    # timerEvent()

# class DataPlot

def make():
    demo = DataPlot()
    demo.resize(500, 300)
    demo.show()
    return demo
# make()


def main(args):
    app = QApplication(args)
    demo = make()
    sys.exit(app.exec_())
# main()

if __name__ == '__main__':
    main(sys.argv)
