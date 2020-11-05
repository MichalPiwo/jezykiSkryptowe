#!/bin/bash

PLANSZA=("-" "-" "-" "-" "-" "-" "-" "-" "-")
GRACZ="X"
WYGRANA=0

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

function ruch
{
    NR_POLA=-1
    echo "Pora na ruch $GRACZ"
   
    while [ $NR_POLA -eq -1 ];
    do
	while [ $NR_POLA -gt 9 ] || [ $NR_POLA -lt 1 ];
        do	
            echo "Podaj numer pola od 1 do 9"     
	    read NR_POLA
	    if [[ ! "$NR_POLA" =~ ^[0-9]+$ ]];
            then
		echo "bledne dane"
	        NR_POLA=-1
            fi
        done
	NR_POLA=$((NR_POLA-1))
        if [ "${PLANSZA[$NR_POLA]}" != "-" ];
	then
            echo "To pole jest juz zajete"
	    NR_POLA=-1
	fi
    done
   
    PLANSZA[NR_POLA]=$GRACZ
}

function odpalGre
{
    NR_RUCHU=0
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

odpalGre
