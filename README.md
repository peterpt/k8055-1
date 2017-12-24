
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
- read script allows you to know the state of digital & analog inputs
- after installing succefully the k8055 module , run ./read in terminal to read input values

<img src="https://s7.postimg.org/41tivg9rf/k8055.jpg"></img> 

- i am still mapping the inputs 
