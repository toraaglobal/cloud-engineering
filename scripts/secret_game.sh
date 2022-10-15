#!/bin/bash

function secretGame(){
    echo Welcome to the secret game!
    echo  Enter the secret number
    read  secret

    if [[ ($secret -eq 42  ||  $secret -eq 23) ]]
    then
        echo  Congratulation! you win

    else 
        echo  Wrong secret! you loose

    fi 
}

# prompt user to enter username & password
echo Enter username: 
read username

echo  Enter password: 
read password

# function to play the secret game 
# promt user to enter a number.
# if number is 42 or 23 then user win otherwisw user loose

# check if username and password is correct
if [[ ($username == 'admin'  &&  $password == 'admin') ]] 
then
    echo Valid credentials. Please enjoy the secret game
    secretGame
else 
    echo  Invalid credentials. User not allowed to play the game
    exit 1
fi 
