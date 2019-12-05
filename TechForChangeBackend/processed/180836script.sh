#!/bin/bash

sudo apt-get update;
# sudo apt-get upgrade;
sudo apt install -y software-properties-common apt-transport-https wget;

pip(){
    sudo apt install -y python3-pip;
    sudo yes | python3 -m pip install --upgrade pip;
}
arduino(){
    sudo apt install -y arduino*;
    sudo usermod -a -G uucp $USER;
}
chrome(){
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -;
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list';
    sudo apt-get install -y google-chrome-stable;
}
slack(){
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb --directory-prefix=/;
    sudo apt install -y ./slack-desktop-*.deb;
}
vscode(){
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code
}
processing(){
    sudo apt-get install -y oracle-java8-installer;
    wget -q  http://download.processing.org/processing-3.3.6-linux64.tgz --directory-prefix=/ | sudo apt-key add -;
    tar xvfz processing-3.3.6-linux64.tgz;
}
atom(){
    sudo snap install -y atom;
}
pyserial(){
    sudo yes | python3 -m pip install pyserial;
}
sklearn(){
    sudo yes | python3 -m pip install sklearn;
}
keras(){
    sudo yes | python3 -m pip install keras;
}
tf(){
    sudo yes | python3 -m pip install tensorflow;
}
cv(){
    sudo yes | python3 -m pip install opencv-python;
}
jupyter(){
    sudo snap install jupyter;
}

zenx=$(zenity --width=600 --height=400 --list --title "Installer" \
--text "Select the Softwares you want to INSTALL" \
--column 'Check' --column "Software Name" TRUE "Visual Studio Code" TRUE "Python 3 : PIP" TRUE "Arduino IDE" TRUE "Chrome" TRUE "Processing" TRUE "Slack" FALSE "Atom" --checklist)
IFS='|';
zenx=($zenx);
unset IFS;
pyx=$(zenity --width=600 --height=400 --list --title "Installer" \
--text "Select the Python Libraries you want to INSTALL" \
--column 'Check' --column "Library Name" TRUE "PySerial" TRUE "SKLEARN" TRUE "Tensorflow" TRUE "Keras" TRUE "OpenCV" TRUE "Jupyter Notebook" --checklist)
IFS='|';
pyx=($pyx);
unset IFS;

for (( z = 0 ; z < ${#zenx[@]}; z++ ));
do
    if [ ${zenx[$z]} == "Visual Studio Code" ]; then 
        vscode
    elif [ ${zenx[$z]} == "Python 3 : PIP" ]; then
        pip
    elif [ ${zenx[$z]} == "Arduino IDE" ]; then
        arduino
    elif [ ${zenx[$z]} == "Chrome" ]; then
        chrome
    elif [ ${zenx[$z]} == "Processing" ]; then
        processing
    elif [ ${zenx[$z]} == "Slack" ]; then
        slack
    elif [ ${zenx[$z]} == "Atom" ]; then
        atom
    fi
done

for (( z = 0 ; z < ${#pyx[@]}; z++ ));
do
    if [ ${pyx[$z]} == "PySerial" ]; then 
        pyserial
    elif [ ${pyx[$z]} == "SKLEARN" ]; then
        sklearn
    elif [ ${pyx[$z]} == "Tensorflow" ]; then
        tf
    elif [ ${pyx[$z]} == "Keras" ]; then
        keras
    elif [ ${pyx[$z]} == "OpenCV" ]; then
        cv
    elif [ ${pyx[$z]} == "Jupyter Notebook" ]; then
        jupyter
    fi
done