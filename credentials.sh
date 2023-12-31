#!/bin/bash

### Make sure you run this script from the bootcamp-iam directory

### This script will process terraform output and decrypt it when needed,
### and then output a file with all the credentials.

### It creates temporary folders/files for an organized approach only;
### can be optimized with loops.

echo Please wait while the credentials file is being prepared...
echo If this is your first time running the script,
echo you will soon be prompted to enter your keybase password.

mkdir -p ./credentials/{raw,clean,decrypted}

###############################
##### ENCRYPTED PASSWORDS #####
###############################

terraform output trainer_passwords > ./credentials/raw/trainer_encrypted_passwords

sed '1d' < ./credentials/raw/trainer_encrypted_passwords | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/trainer_encrypted_passwords_adjusted

terraform output student_passwords > ./credentials/raw/student_encrypted_passwords

sed '1d' < ./credentials/raw/student_encrypted_passwords | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/student_encrypted_passwords_adjusted

#################################
##### ENCRYPTED KEY SECRETS #####
#################################

terraform output trainer_key_secrets > ./credentials/raw/trainer_encrypted_key_secrets

sed '1d' < ./credentials/raw/trainer_encrypted_key_secrets | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/trainer_encrypted_key_secrets_adjusted

terraform output student_key_secrets > ./credentials/raw/student_encrypted_key_secrets

sed '1d' < ./credentials/raw/student_encrypted_key_secrets | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/student_encrypted_key_secrets_adjusted

##########################
##### ACCESS KEY IDS #####
##########################

terraform output trainer_key_ids > ./credentials/raw/trainer_key_ids

sed '1d' < ./credentials/raw/trainer_key_ids | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/trainer_key_ids_adjusted

terraform output student_key_ids > ./credentials/raw/student_key_ids

sed '1d' < ./credentials/raw/student_key_ids | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/student_key_ids_adjusted

######################
##### USER NAMES #####
######################

terraform output trainer_users > ./credentials/raw/trainer_users

sed '1d' < ./credentials/raw/trainer_users | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/trainer_users_adjusted

terraform output student_users > ./credentials/raw/student_users

sed '1d' < ./credentials/raw/student_users | sed '$d' | sed -r 's/.{3}//' | sed -r 's/.{2}$//' > ./credentials/clean/student_users_adjusted

############################################
##### PASSWORDS AND SECRETS DECRYPTION #####
############################################

### Looping over the files containing encrypted passwords and secrets
### one at a time to create the appropriate files containing
### the decrypted credentials.

echo > ./credentials/decrypted/trainer_passwords
sed -i '1d' ./credentials/decrypted/trainer_passwords

while IFS= read -r line
do
	head -n 4 keybase_pgp_template > password.txt
	echo $line >> password.txt
	tail -n 1 keybase_pgp_template >> password.txt
	keybase pgp decrypt -i password.txt >> ./credentials/decrypted/trainer_passwords
	echo >> ./credentials/decrypted/trainer_passwords
done < "./credentials/clean/trainer_encrypted_passwords_adjusted"

##################

echo > ./credentials/decrypted/student_passwords
sed -i '1d' ./credentials/decrypted/student_passwords

while IFS= read -r line
do
        head -n 4 keybase_pgp_template > password.txt
        echo $line >> password.txt
        tail -n 1 keybase_pgp_template >> password.txt
        keybase pgp decrypt -i password.txt >> ./credentials/decrypted/student_passwords
        echo >> ./credentials/decrypted/student_passwords
done < "./credentials/clean/student_encrypted_passwords_adjusted"

##################

echo > ./credentials/decrypted/trainer_key_secrets
sed -i '1d' ./credentials/decrypted/trainer_key_secrets

while IFS= read -r line
do
        head -n 4 keybase_pgp_template > password.txt
        echo $line >> password.txt
        tail -n 1 keybase_pgp_template >> password.txt
        keybase pgp decrypt -i password.txt >> ./credentials/decrypted/trainer_key_secrets
        echo >> ./credentials/decrypted/trainer_key_secrets
done < "./credentials/clean/trainer_encrypted_key_secrets_adjusted"

##################

echo > ./credentials/decrypted/student_key_secrets
sed -i '1d' ./credentials/decrypted/student_key_secrets

while IFS= read -r line
do
        head -n 4 keybase_pgp_template > password.txt
        echo $line >> password.txt
        tail -n 1 keybase_pgp_template >> password.txt
        keybase pgp decrypt -i password.txt >> ./credentials/decrypted/student_key_secrets
        echo >> ./credentials/decrypted/student_key_secrets
done < "./credentials/clean/student_encrypted_key_secrets_adjusted"

rm password.txt

##################################################
##### ASSEMBLING THE GLOBAL CREDENTIALS FILE #####
##################################################

f0="all_credentials.txt"
f1="./credentials/clean/trainer_users_adjusted"
f2="./credentials/decrypted/trainer_passwords"
f3="./credentials/clean/trainer_key_ids_adjusted"
f4="./credentials/decrypted/trainer_key_secrets"

echo -e "TRAINERS\tINITIAL_PASSWORDS\tACCESS_KEY_IDS\t\tACCESS_KEY_SECRETS\n" > $f0

paste $f1 $f2 $f3 $f4 >> $f0

f1="./credentials/clean/student_users_adjusted"
f2="./credentials/decrypted/student_passwords"
f3="./credentials/clean/student_key_ids_adjusted"
f4="./credentials/decrypted/student_key_secrets"

echo -e "\n\nSTUDENTS\tINITIAL_PASSWORDS\tACCESS_KEY_IDS\t\tACCESS_KEY_SECRETS\n" >> $f0

paste $f1 $f2 $f3 $f4 >> $f0

##########################################
##### CLEANING UP CREDENTIAL FOLDERS #####
##########################################

rm -rf ./credentials/{raw,clean,decrypted}

