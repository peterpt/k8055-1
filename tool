 #!/bin/bash
# check if any of the existent bins for K8055 exist

which k8055cmd > /dev/null 2>&1
      if [ "$?" -eq "0" ]; then
k80="k8055cmd"
else
which k8055 > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
k80="k8055"
else
echo "Make sure you build k8055 module command from this git"
exit 1
fi
fi

# Quick check to see if K8055 is connected to computer
chk=$($k80 2>&1 | grep "Could not open")
if [[ ! -z "$chk" ]]
then
echo "K8055 board disconnected"
exit 1
fi

#Setting analog & digital output values to nothing so script knows that just started
dlv=""
anv1=""
anv2=""
$k80 -d:0 -a1:0 -a2:0
# CTRÇ+C used to manually activate outputs
trap ctrl_c INT
function ctrl_c () {
clear
echo "Select which outputs you want to activate."
echo "------------------------------------------"
echo " 0 - Create a Rule                        "
echo " 1 - Activate Digital Output/s            "
echo " 2 - Activate Analog Outputs              "
echo " 3 - Exit                                 "
echo "------------------------------------------"
echo -ne "Select 1,2 or 3 : "
read -r inp
if [[ "$inp" == "0" ]]
then
echo ""
echo "Select:"
echo "-----------------------"
echo "|    IF  INPUT PORT   | "
echo "----------------------|"
echo "| 1 - Analogic port 1 |"
echo "| 2 - Analogic port 2 |"
echo "| 3 - Digital port/s  |"
echo "-----------------------"
echo "     ACTIVATED         "
echo "-----------------------"
echo -ne "Choose Port : "
read -r iport
case $iport in
1)
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r ipvanl1

if [[ -z $ipvan1 ]]
then
trap -2 ctrl_c
fi

echo ""
echo "Select :"
echo "-------------------------"
echo "| THEN  ACTIVATE OUTPUT |"
echo "-------------------------"
echo "| 1 - Analogic port 1   |"
echo "| 2 - Analogic port 2   |"
echo "| 3 - Digital port/s    |"
echo "-------------------------"
echo -ne "Choose Port : "
read -r oport

if [[ "$oport" == "1" ]]
then
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r opvan1
if [[ -z $opvan1 ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "ia1 $ipvan1 oa1 $opvan1" >> rules.txt
else
echo "ia1 $ipvan1 oa1 $opvan1" > rules.txt
fi
fi
if [[ "$oport" == "2" ]]
then
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r opvan2
if [[ -z $opvan2 ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "ia1 $ipvan1 oa1 $opvan2" >> rules.txt
else
echo "ia1 $ipvan1 oa1 $opvan2" > rules.txt
fi
fi
if [[ "$oport" == "3" ]]
then
echo ""
echo "Choose 1 or more outputs ports from 1 to 8"
echo "example : 147 - to activate ports 1 ,4 & 7"
echo -ne "Input ports numbers : "
read -r opvdg
if [[ -z $opvdg ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "ia1 $ipvan1 od $opvdg" >> rules.txt
else
echo "ia1 $ipvan1 od $opvdg" > rules.txt
fi
fi
echo ""
sleep 5
trap -2 ctrl_c
;;
2)
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r ipvanl2
if [[ -z $ipvan2 ]]
then
trap -2 ctrl_c
fi
echo ""
echo "Select :"
echo "-------------------------"
echo "| THEN  ACTIVATE OUTPUT |"
echo "-------------------------"
echo "| 1 - Analogic port 1   |"
echo "| 2 - Analogic port 2   |"
echo "| 3 - Digital port/s    |"
echo "-------------------------"
echo -ne "Choose Port : "
read -r oport
if [[ "$oport" == "1" ]]
then
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r opvan1
if [[ -z $opvan1 ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "ia2 $ipvan2 oa1 $opvan1" >> rules.txt
else
echo "ia2 $ipvan2 oa1 $opvan1" > rules.txt
fi
fi
if [[ "$oport" == "2" ]]
then
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r opvan2
if [[ -z $opvan2 ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "ia2 $ipvan2 oa1 $opvan2" >> rules.txt
else
echo "ia2 $ipvan2 oa1 $opvan2" > rules.txt
fi
fi
if [[ "$oport" == "3" ]]
then
echo ""
echo "Choose 1 or more outputs ports from 1 to 8"
echo "example : 147 - to activate ports 1 ,4 & 7"
echo -ne "Input port/s number/r : "
read -r opvdg
if [[ -z $opvdg ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "ia2 $ipvan2 od $opvdg" >> rules.txt
else
echo "ia2 $ipvan2 od $opvdg" > rules.txt
fi
fi
echo ""
sleep 5
trap -2 ctrl_c
;;
3)
echo ""
echo "Choose a Digital input port 1 & 5"
echo ""
echo -ne "Port Input : "
read -r ipvdg
if [[ -z $ipvdg ]]
then
trap -2 ctrl_c
fi
echo ""
echo "Select :"
echo "-------------------------"
echo "| THEN  ACTIVATE OUTPUT |"
echo "-------------------------"
echo "| 1 - Analogic port 1   |"
echo "| 2 - Analogic port 2   |"
echo "| 3 - Digital port/s    |"
echo "-------------------------"
echo -ne "Choose Port : "
read -r oport
if [[ "$oport" == "1" ]]
then
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r opvan1
if [[ -z $opvan1 ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "id $ipvdg oa1 $opvan1" >> rules.txt
else
echo "id $ipvdg oa1 $opvan1" > rules.txt
fi
fi
if [[ "$oport" == "2" ]]
then
echo ""
echo "Choose value considering 0=off & 255=on"
echo ""
echo -ne "Input a value between 0 & 255 : "
read -r opvan2
if [[ -z $opvan2 ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "id $ipvdg oa1 $opvan2" >> rules.txt
else
echo "id $ipvdg oa1 $opvan2" > rules.txt
fi
fi
if [[ "$oport" == "3" ]]
then
echo ""
echo "Choose 1 or more outputs ports from 1 to 8"
echo "example : 147 - to activate ports 1 ,4 & 7"
echo -ne "Input port/s number/r : "
read -r opvdg
if [[ -z $opvdg ]]
then
trap -2 ctrl_c
fi
if [[ -f rules.txt ]]
then
echo "id $ipvdg od $opvdg" >> rules.txt
else
echo "id $ipvdg od $opvdg" > rules.txt
fi
fi
echo ""
sleep 5
trap -2 ctrl_c
;;
*)
trap -2 ctrl_c
;;
esac
elif [[ "$inp" == "1" ]]
then
echo ""
echo "----------------------------------------------------------------------"
echo "From 8 digital output ports select which port/s you want to activate ."
echo "Example 1 : 4  - to activate port 4"
echo "Example 2 : 1478 - to activate ports 1,4,7 & 8"
echo "Example 3 : 12345678 - to activate all ports"
echo ""
echo -ne "Activate Port/s : "
read -r dport
sport=$(cat out.txt | grep "\<$dport\>" | awk '{print$1}' | sed 's#do##g' )
if [[ -z $sport ]]
then
echo "unable to apply that specific port entry"
sleep 4
trap -2 ctrl_c
else
$k80 -d:$sport
dlv="$dport"
trap -2 ctrl_c
fi
elif [[ "$inp" == "2" ]]
then
echo ""
echo "-------------------------------------------------------------------------"
echo "From 2 analog output ports select which port/s you want to change value ."
echo " 1 - to change analog port 1 value"
echo " 2 - to change analog port 1 value"
echo ""
echo "Value must be between 0 and 255 where 0= off and 255= on"
echo ""
echo -ne "Choose Analog Port (1,2) : "
read -r aport
if [[ "$aport" == "1" ]]
then
echo ""
echo -ne "Write a value between 0 & 255 : "
read -r ap1v
$k80 -a1:$ap1v
anv1="$ap1v"
trap -2 ctrl_c
fi

if [[ "$aport" == "2" ]]
then
echo ""
echo -ne "Write a value between 0 & 255 : "
read -r ap2v
$k80 -a2:$ap2v
anv2="$ap2v"
trap -2 ctrl_c
else
trap -2 ctrl_c
fi


elif [[ "$inp" == "3" ]]
then
sleep 4
trap -2 ctrl_c
else
sleep 4
trap -2 ctrl_c
fi
}

execrules() {
nrules=$(cat rules.txt | wc -l)

for i in $(seq "$nrules")
do
rruleid=$(cat rules.txt | awk '{print$1}' | sed -n "${i}p")
rrulein=$(cat rules.txt | awk '{print$2}' | sed -n "${i}p")
rruleoi=$(cat rules.txt | awk '{print$3}' | sed -n "${i}p")
rruleon=$(cat rules.txt | awk '{print$4}' | sed -n "${i}p")
if [[ "$rruleid" == "id" ]]
then
varinp=$(cat inp.txt | grep "\<$rrulein\>" | awk '{print$1}' | sed 's#di##g')
if [[ "$rruleoi" == "od" ]]
then
varout=$(cat out.txt | grep "\<$rruleon\>" | awk '{print$1}' | sed 's#do##g')
di=$($k80 | sed -e 's/;/ /g' | awk '{print$2}')
a1=$($k80 | sed -e 's/;/ /g' | awk '{print$3}')
a2=$($k80 | sed -e 's/;/ /g' | awk '{print$4}')
if [[ "$di" == "$varinp" ]]
then
$k80 -d:$varout
fi
fi
fi

done

}
start () {
if [[ -f rules.txt ]]
then
execrules
fi
# run 8055 bin and check current values
di=$($k80 | sed -e 's/;/ /g' | awk '{print$2}')
dinp=$di
a1=$($k80 | sed -e 's/;/ /g' | awk '{print$3}')
a2=$($k80 | sed -e 's/;/ /g' | awk '{print$4}')
a=$(cat inp.txt | grep "\<di$dinp\>" | awk '{print$2}')
echo "-----------------------------------------------"
echo "| PRESS CTRL+C to activate outputs            |"
echo "----------------------------------------------|"
echo "| PRESS CTRL+Z to exit                        |"
echo "-----------------------------------------------"
echo ""
echo "Digital Input activated : $a"
echo "Analog Input 1 Value = $a1"
echo "Analog Input 2 Value = $a2"

# if a digital output is activated then show current ports
if [[ -z $dlv ]]
then
echo "Digital output ports activated : None"
else
echo "Digital output ports activated : $dlv "
fi

# Code for analog output ports
if [[ -z $anv1 ]]
then
echo "Analog output port 1 value : None"
else
echo "Analog output port 1 value : $anv1 "
fi
if [[ -z $anv2 ]]
then
echo "Analog output port 2 value : None"
else
echo "Analog output port 1 value : $anv2 "
fi
sleep 1
clear

# start again
start
}
# start loop
start
