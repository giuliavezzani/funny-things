#!/bin/bash
#######################################################################################
# FLATWOKEN ICON THEME CONFIGURATION SCRIPT
# Copyright: (C) 2014 FlatWoken icons
# Authors:  Giulia Vezzani
# email:   giulia.vezzani@iit.it
# Permission is granted to copy, distribute, and/or modify this program
# under the terms of the GNU General Public License, version 2 or any
# later version published by the Free Software Foundation.
#  *
# A copy of the license can be found at
# http://www.robotcub.org/icub/license/gpl.txt
#  *
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details
#######################################################################################


#######################################################################################
# USEFUL FUNCTIONS:                                                                  #
#######################################################################################
usage() {
cat << EOF
***************************************************************************************
PC SCRIPTING
Author:  Giulia Vezzani   <giulia.vezzani@iit.it>

This script scripts through the commands available for the Parametric Design demo.

USAGE:
        $0 options

***************************************************************************************
OPTIONS:

***************************************************************************************
EXAMPLE USAGE:

***************************************************************************************
EOF
}

#######################################################################################
# FUNCTIONS:                                                                         #
#######################################################################################
gaze() {
    echo "$1" | yarp write ... /gaze
}

breathers() {
    # echo "$1"  | yarp rpc /iCubBlinker/rpc
    echo "$1" | yarp rpc /iCubBreatherH/rpc:i
    echo "$1" | yarp rpc /iCubBreatherRA/rpc:i
    sleep 0.4
    echo "$1" | yarp rpc /iCubBreatherLA/rpc:i
}

breathersL() {
    echo "$1" | yarp rpc /iCubBreatherLA/rpc:i
}

breathersR() {
    echo "$1" | yarp rpc /iCubBreatherRA/rpc:i
}

head() {
    echo "$1" | yarp rpc /iCubBreatherH/rpc:i
}

stop_breathers() {
    breathers "stop"
}

start_breathers() {
    breathers "start"
}


speak() {
    echo "\"$1\"" | yarp write ... /iSpeak
}


go_home_helper() {
    # This is with the arms close to the legs
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
    # echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
    # This is with the arms over the table
    go_home_helperR $1
    go_home_helperL $1
    # echo "ctpq time 1.0 off 0 pos (0.0 0.0 10.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
    go_home_helperH $1
}

go_home_helperL()
{
    # echo "ctpq time $1 off 0 pos (-30.0 36.0 0.0 60.0 0.0 0.0 0.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/left_arm/rpc
}

go_home_helperR()
{
    # echo "ctpq time $1 off 0 pos (-30.0 36.0 0.0 60.0 0.0 0.0 0.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time $1 off 0 pos (-6.0 23.0 25.0 29.0 -24.0 -3.0 -3.0 19.0 29.0 8.0 30.0 32.0 42.0 50.0 50.0 114.0)" | yarp rpc /ctpservice/right_arm/rpc
}

go_home_helperH()
{
    echo "ctpq time $1 off 0 pos (0.0 0.0 0.0 0.0 0.0 5.0)" | yarp rpc /ctpservice/head/rpc
}

go_homeH() {
    head "stop"
    go_home_helperH 1.5
    sleep 2.0
    head "start"
}

go_home() {
    breathers "stop"
    go_home_helper 2.0
    sleep 2.5
    breathers "start"
}

greet_with_left_thumb_up() {
    echo "ctpq time 2.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helperL 1.5
}

greet_with_right_thumb_up() {
    echo "ctpq time 2.0 off 0 pos (-44.0 36.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 1.5 && smile && sleep 1.5
    go_home_helperR 1.5
}

greet_with_two_thumbs() {

  echo "ctpq time 2.0 off 0 pos (-44.0 50.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/left_arm/rpc
  echo "ctpq time 2.0 off 0 pos (-44.0 50.0 54.0 91.0 -45.0 0.0 12.0 21.0 14.0 0.0 0.0 59.0 140.0 80.0 125.0 210.0)" | yarp rpc /ctpservice/right_arm/rpc
  sleep 1.5 && smile && sleep 1.5
  go_home_helperL 0.5
  go_home_helperR 1.5
}

greet_like_god() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0 20.0 29.0 3.0 11.0 3.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 1.0
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 50.0 -30.0 80.0 40.0 -5.0 10.0)" | yarp rpc /ctpservice/left_arm/rpc
    speak "Bentornato. capo!"
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 0.7 off 0 pos (-70.0 40.0 -7.0 100.0 60.0 -20.0 2.0)" | yarp rpc /ctpservice/left_arm/rpc

    sleep 1.0 && smile

    go_home_helper 2.0
    breathers "start"
}

mostra_muscoli() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.5 off 0 pos (-27.0 78.0 -37.0 33.0 -79.0 0.0 -4.0 26.0 27.0 0.0 29.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/right_arm/rpc
    echo "ctpq time 1.0 off 0 pos (-27.0 78.0 -37.0 93.0 -79.0 0.0 -4.0 26.0 67.0 0.0 99.0 59.0 117.0 87.0 176.0 250.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 5.5
    go_home_helper 2.0
    sleep 2.5
}

smile() {
    echo "set all hap" | yarp rpc /icub/face/emotions/in
}

surprised() {
    echo "set mou sur" | yarp rpc /icub/face/emotions/in
    echo "set leb sur" | yarp rpc /icub/face/emotions/in
    echo "set reb sur" | yarp rpc /icub/face/emotions/in
}

sad() {
    echo "set mou sad" | yarp rpc /icub/face/emotions/in
    echo "set leb sad" | yarp rpc /icub/face/emotions/in
    echo "set reb sad" | yarp rpc /icub/face/emotions/in
}

cun() {
    echo "set reb cun" | yarp rpc /icub/face/emotions/in
    echo "set leb cun" | yarp rpc /icub/face/emotions/in
}

angry() {
    echo "set all ang" | yarp rpc /icub/face/emotions/in
}


#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################

ciaoFabrizio() {
    speak "Ciao Fabrizio."
    sleep 1.0
    speak "Sono contento di essere qui con voi oggi."
    sleep 1.0 && gaze "look-around 15.0 0.0 5.0"
    speak "Perche` non ci divertiamo un po`?"
    go_home
}

stretta_destra() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-7.0 24.0 24.0 80.0 -23.0 0.0 -4.0 56.0 27.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/right_arm/rpc
    sleep 10.0
    go_home
    breathers "start"
}

stretta_sinistra() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-7.0 24.0 24.0 80.0 -23.0 0.0 -4.0 56.0 27.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 10.0
    go_home
    breathers "start"
}

sentireSensori() {
    speak "Non mi era mai successo di vedere cosa sentono i miei sensori!"
    sleep 1.0
    speak "E’ molto interessante, ma mi sembra di capire che anche da molto lontano qualcuno potrebbe vedere cosa rilevano i miei sensori."
    go_home
}

certamente() {
    speak "Certamente!" #14.514.700 - 14 514 700
    go_home
}

iPad() {
    speak "Sicuro!"
    sleep 2.0
    speak "Prova a guardare sul tavolo qui di fianco."
    sleep 2.0 && gaze "look 15.0 0.0 5.0"
    speak "Troverai un iPad e un mio braccio non ancora completamente assemblato."
    sleep 3.0
    speak "Credo che riuscirai facilmente a capire qualcosa di più!"
    go_home
}

giramentoTesta() {
    speak "Fabrizio, mi gira un po' la testa!"
}

svenimento() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-25.0 0.0 50.0)" | yarp rpc /ctpservice/torso/rpc
}

sollevamento() {
    echo "ctpq time 1.5 off 0 pos (0.0 0.0 0.0)" | yarp rpc /ctpservice/torso/rpc
    breathers "start"
    smile
}

grazieRagazzi() {
    speak "Grazie ragazzi!"
}

stoMeglio() {
    speak "Adesso mi sento veramente meglio!"
    go_home
}

salutiFinali(){
    speak "Grazie, anche per me e stato divertente"
    sleep 1.0
    speak "Dopo di noi vedrete molte altre cose interessanti."
    sleep 1.0 && gaze "look-around 15.0 0.0 5.0"
    speak "Auguro a tutti una buona giornata qui con noi all’IIT"
    gaze "look-around 15.0 0.0 5.0"
    go_home
}




#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################





saluta() {
    breathers "stop"
    echo "ctpq time 1.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    sleep 2.0 && speak "Salve colleghi."
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0  25.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    echo "ctpq time 0.5 off 0 pos (-60.0 44.0 -2.0 96.0 53.0 -17.0 -11.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)" | yarp rpc /ctpservice/left_arm/rpc
    smile
    go_home
    smile
}


#######################################################################################
# Story board                                                                       #
#######################################################################################

scene_pause()
{
    read -p "waiting for enter"
    ciaoClaudio
    read -p "waiting for enter"
    cosaComune
    read -p "waiting for enter"
    laTesta
    read -p "waiting for enter"
    rispostaCalcolo
    read -p "waiting for enter"
    nostreParti
    read -p "waiting for enter"
    ufo
    read -p "waiting for enter"
    intuito
    read -p "waiting for enter"
    rispostaAnni
    read -p "waiting for enter"
    rispostaNome
    read -p "waiting for enter"
    rispostaTalento
    read -p "waiting for enter"
    rispostaTaiChi
    read -p "waiting for enter"
    nonSoloTaiChi
    read -p "waiting for enter"
    salite
}


scene_all()
{
    scene_0
    scene_1
    sleep 5.0 && scene_2
    scene_3
    sleep 5.0 && scene_4
    sleep 2.0 && scene_5
    sleep 4.0 && scene_6
}



scene_0() {
    breathers "stop"
    ##movimento testa?
    ciaoFabrizio
    smile
    sleep 4.0 && breathers "start"
}

scene_1() {
    breathers "stop"
    stretta_destra && smile
    go_home_helper 2.0
    surprised
    breathers "start"
}

scene_2() {
    breathers "stop"
    certamente
    smile
    breathers "start"
    go_home
}

scene_3() {
    breather "stop"
    iPad
    breather "start"
}

scene_4() {
    breather "stop"
    giramentoTesta
    svenimento
}

scene_5() {
    sollevamento
    smile
    grazieRagazzi
    greet_with_left_thumb_up && greet_with_right_thumb_up
    breather "start"
    go_home
}

scene_6() {
    breather "stop"
    salutiFinali
    sleep1.0 && smile
    saluta
    breather "start"
    smile
}


#######################################################################################
# "MAIN" FUNCTION:                                                                    #
#######################################################################################
echo "********************************************************************************"
echo ""

$1 "$2"

if [[ $# -eq 0 ]] ; then
    echo "No options were passed!"
    echo ""
    usage
    exit 1
fi
