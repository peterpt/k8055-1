
# K8055 screening

<img src="https://www.velleman.eu/images/products/0/k8055.jpg"></img> 

# Requirements
- bash
- libk8055 require libusb-1.0.0 or newer

# Install Requirements
apt-get install git python-dev libusb-dev swig libusb-1.0-0-dev libwxgtk3.0-dev

build test and install libk8055, k8055 and k8055gui:
    ./build.sh r m t i

user access to the k8055 device:
    read comments in velleman.rules

special thanks to:
    * Sven Lindberg
    * Pjetur G. Hjaltason
    * Martin Pischky
    * Etienne Mouragnon

2013.26.11: added support for PVM110N cards

# Notes
- "start" script allows you to know the state of digital & analog inputs
- after installing succefully the k8055 module , run ./start in terminal to read input values

<img src="https://s14.postimg.cc/5mkb5pai9/start.jpg" width="55%"></img> 
<img src="https://s14.postimg.cc/jt0210le9/create.png" width="55%"></img> 

- Scripts are currently been building , the "create" script will allow user to build rules on inputs to activate the outputs of k8055
