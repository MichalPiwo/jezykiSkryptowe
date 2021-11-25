#!/bin/bash

PLANSZA=("-" "-" "-" "-" "-" "-" "-" "-" "-")
GRACZ="O"
WYGRANA=0
SLOT=""
RYWAL="player"

function wyswietlPlansze
{
    clear
    echo "${PLANSZA[0]} ${PLANSZA[1]} ${PLANSZA[2]}"
    echo "${PLANSZA[3]} ${PLANSZA[4]} ${PLANSZA[5]}"  
    echo "${PLANSZA[6]} ${PLANSZA[7]} ${PLANSZA[8]}"
}

function sprawdzWygrana
{
    for i in 0 1 2; #poziomo
    do
        if [ ${PLANSZA[0+3*$i]} = $1 ] && [ ${PLANSZA[1+3*$i]} = $1 ] && [ ${PLANSZA[2+3*$i]} = $1 ];
        then
            WYGRANA=1
            return
        fi
    done
    
    for i in 0 1 2; #pionowo
    do
        if [ ${PLANSZA[$i]} = $1 ] && [ ${PLANSZA[3+$i]} = $1 ] && [ ${PLANSZA[6+$i]} = $1 ];
        then
            WYGRANA=1
            return
        fi
    done
    
    if [ ${PLANSZA[0]} = $1 ] && [ ${PLANSZA[4]} = $1 ] && [ ${PLANSZA[8]} = $1 ]; #jedna przekatna
    then
        WYGRANA=1
        return
    fi

    if [ ${PLANSZA[2]} = $1 ] && [ ${PLANSZA[4]} = $1 ] && [ ${PLANSZA[6]} = $1 ]; #druga przekatna
    then
        WYGRANA=1
        return
    fi

    return 0
}

function zapiszGre
{
    echo ${PLANSZA[*]} > ".$1.txt"
    echo $GRACZ >> ".$1.txt"
}

function ruch
{
    USER_INPUT=-1
    echo "Pora na ruch $GRACZ"
   
    while [ $USER_INPUT -eq -1 ];
    do
        while [ $USER_INPUT -gt 9 ] || [ $USER_INPUT -lt 1 ];
        do    
            if [[ $GRACZ == "X" && $RYWAL!="player" ]]
            then
                USER_INPUT=$((1 + $RANDOM % 9))
            else
                echo "Podaj numer pola od 1 do 9"
                echo "Podaj s i numer slotu od 1 do 9 aby zapisac gre (np. s1)"
                read USER_INPUT
            fi

            if [[ "$USER_INPUT" =~ ([s])([1-9])$ ]];
            then
                echo "zapisuje gre w slocie $USER_INPUT"
                zapiszGre $USER_INPUT
                USER_INPUT=-1
                continue
            fi
            if [[ ! "$USER_INPUT" =~ ^[1-9]+$ ]];
            then
                echo "bledne dane"
                USER_INPUT=-1
                continue
            fi
        done
        USER_INPUT=$((USER_INPUT-1))
        if [ "${PLANSZA[$USER_INPUT]}" != "-" ];
        then
            echo "To pole jest juz zajete"
            USER_INPUT=-1
        fi
    done
   
    PLANSZA[USER_INPUT]=$GRACZ
}

function odpalGre
{
    NR_RUCHU=0

    if [ "$#" -ge 1 ]
    then
        if [[ $1 =~ ([s])([1-9])$ ]];
        then
            if [ -e ".$1.txt" ]
            then
                echo "wczytuje gre ze slotu $1"
                PIERWSZ_LINIA=$(sed -n '1p' .$1.txt)
                PLANSZA=($PIERWSZ_LINIA)
                GRACZ=$(sed -n '2p' .$1.txt)
                for i in ${PLANSZA[@]}
                do
                    if [ "$i" != "-" ]
                    then
                        NR_RUCHU=$((NR_RUCHU+1))
                    fi
                done
            fi
        fi
    fi
    
    sleep 1
    wyswietlPlansze
    while [ $NR_RUCHU -lt 9 ];
    do
        ruch
        wyswietlPlansze

        sprawdzWygrana $GRACZ
        if [ $WYGRANA -eq 1 ];
        then
            echo "wygrywa $GRACZ"
            return
        fi

        if [ $GRACZ = "X" ];
        then
            GRACZ="O"
        else
            GRACZ="X"
        fi
        NR_RUCHU=$((NR_RUCHU+1))
    done
    echo "remis"
}


while getopts :s:b: option;
do
  case "${option}" in
    s) SLOT="$OPTARG";;
    b) RYWAL="bot";;
  esac
done

odpalGre $SLOT
