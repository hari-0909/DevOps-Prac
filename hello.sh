#!/bin/bash
echo "hello I'm freed now"
<<comment
Anything can be written here 
no matter how long
name="babitaji"
echo "name is $name, and date is $(date)"
echo "enter the name:"
read username
echo "you entered $username"
read -p "enter yes/no:" var1
read -p "enter the %:" var2
if [[ $var1=="yes" ]];
then
	echo "yes"
elif [[ $var2 -ge 100 ]];
then
	echo "yes"
else
	echo "no"
fi
comment

#for loop
<<comment
for (( num=1;num<=5;num++ ));
do
	mkdir "demo$num"
done
comment
#while 
num=0
while [[ $num -le 10 ]]
do
	echo $num
	num=$((num+2))
done

