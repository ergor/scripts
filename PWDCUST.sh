pwd_length=10
pwd_symbol="..."
#newPWD="${PWD/#$HOME/~}"
oldPWD="$(dirs)"
newPWD="$(dirs)"
if [ $(echo -n $newPWD | wc -c | tr -d " ") -gt $pwd_length ]
then
   newPWD=$(echo -n $newPWD | awk -F '/' '{
   print $1 "/" $2 "/.../" $(NF-1) "/" $(NF)}')
fi
#PS1='${newPWD}$ '

# check to see if it actually is shorter and revert if not 

if [ $(echo -n "$newPWD" | wc -c | tr -d " ") -ge $(echo -n "$oldPWD" | wc -c | tr -d " ") ]
then
   newPWD="$(dirs)"
fi

# also check if more than 3 dirs deep. revert if 3 or less 

needle="/"
number_of_occurrences=$(grep -o "$needle" <<< "$oldPWD" | wc -l)

if [ $number_of_occurrences -le 3 ]
then
   newPWD="$(dirs)"
fi

echo $newPWD
