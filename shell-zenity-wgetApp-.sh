#!/bin/sh

zenity   --info --width 500  --height 250  --text  '<span foreground="orange" font="24">Hello,\nWelcome to Wget parameter system.</span>\n\n<i>(It was developed by  SEFA ENES ERGİN on 10.01.2022.)</i>'
#define the height in px of the top system-bar:
TOPMARGIN=100
#sum in px of all horizontal borders:
RIGHTMARGIN=100
# get width of screen and height of screen
SCREEN_WIDTH=$(xwininfo -root | awk '$1=="Width:" {print $2}')
SCREEN_HEIGHT=$(xwininfo -root | awk '$1=="Height:" {print $2}')
# new width and height
W=$(( $SCREEN_WIDTH / 2 - $RIGHTMARGIN ))
H=$(( $SCREEN_HEIGHT - 2 * $TOPMARGIN ))


zenity --warning \
       --title "Attention Message" \
       --width 500 \
       --height 100 \
       --text "wget and zenity will be installed soon. If you want this press 'YES'."
zenity --timeout 15  --question "."
#check 'yes' and 'no' decision
case $? in 
  0)
 sudo apt install wget
 sudo apt install -y zenity 
 ;; 
  1)
  ;; 
  *) echo "Time Out..."
  ;;

esac

#assign variables
opt1="i parametresi"
opt2="limit-rate paramtresi"
opt3="c parametresi"
opt4="b parametresi"
opt5="m parametresi"
#choose panel
int=`zenity --height=$W --list --radiolist --text 'Which parameters do you choose:' --column 'Choose...' --column 'Parametre ' FALSE "$opt1" FALSE "$opt2" FALSE "$opt3" FALSE "$opt4" FALSE "$opt5"` 
zenity --info --title "Information Page " --width 300 --height 100  --text "Choosen parameter: "$int



#progress steps...
echo "Processes are being prepared."
(
echo "10" ; sleep 1
echo "System Update..." ; sleep 1
echo "50" ; sleep 1
echo "Interface update..." ; sleep 1
echo "90" ; sleep 1
echo "System is ready." ; sleep 1
echo "100" ; sleep 1
) |
zenity --progress \
  --title="Choose Panel." \
  --text="System getting ready." \
  --percentage=0
#if user press to cancel
if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Canceled.."
fi


#URL input screen
URL=$(zenity --entry \
       --width 500 \
	--height 100\
       --title "URL Input Screen" \
       --text "Enter URL..."); echo $URL

#switch case for choosen parameters.
if [ "$int" = "i parametresi" ]
then
wget -i $URL

elif [ "$int" = "limit-rate parametresi" ]
then
wget --limit-rate=128k  $URL

elif [ "$int" = "c parametresi" ]
then
wget - c $URL

elif [ "$int" = "b parametresi" ]
then
wget -b $URL
elif [ "$int" = "m parametresi" ]
then
wget -m $URL

else
    echo "Invalid process...."
fi
#final info screen for choosen URL.
zenity --info --title "Information Page " --width 500 --height 100  --text \
"<span color=\"blue\"><b>That </b></span> \
<span color=\"red\"><b>$URL</b></span> \
<span color=\"blue\"><b> operations on this URL have been successfully performed..</b></span>
 "
