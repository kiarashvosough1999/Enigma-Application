# Enigma Application

## Introduction

You are assigned to a cryptographic project called Enigma. The goal is to create an app that has custom encryption and decryption abilities. The keys are supplied to you for the whole week, from Monday till Sunday. Depending on what day of the week, the app is running on the keys required for loading the appropriate ciphering keys from the corresponding files. For example if it is a Tuesday the app should load the `Tuesday.txt` keys and load them into the crypto dictionary. You will be required to create the encrypting and decrypting functions that should return a String with either the encrypted or the decrypted message. The space between the words should be encrypted using the '-' key from the encryption keys.

## Task definition

**Note:** Please do NOT modify any tests unless specifically told to do so.
**Note:** Please do NOT modify the function declarations and return types. 

Your task is to implement the following features of the app:

1. Get the current day name in the form of the enumeration declared in Enigma.swift. For example: "Tuesday" would be Day.Tuesday

    `func getCurrentDay() -> Day`

2. Load the corresponding encryption keys for the current day from the "DAY_NAME.TXT" file. For example:
for Wednesday you will have to load the Wednesday.txt.
Once loaded, parse the keys and fill in the 'crypto' dictionary with alphabet letters as the keys and their encrypted representations as the values.

    `mutating func loadEncryptionKeys(for day: Day)`

3. Fill in the encryption function below that accepts a String and returns an encrypted version of that
String. Each letter of the String should be encrypted using the encryption keys. For example, letter 'a' could be encrypted as 'de4' depending on todays Day and the keys loaded. Example if the method gets the word 'Hello' passed in it should return the encrypted version which could be 'lzxpasbvcbvcgf3' depending on todays Day and the keys loaded.
**Remember** that letters need to be lowercased before encrypting.
**Remember** that the space character needs to be encrypted using the '-' key from the crypto keys dictionary.
Please **note** that the characters that are allowed to be encrypted are only:
'abcdefghijklmnopqrstuvwxyz0123456789 ' (alphanumeric and space) you should ignore any other characters that are passed in.
Example Devsk..iller should only encrypt 'devskiller' and ignore the .. in the middle.

    `mutating func encrypt(message: String) -> String`

4. Fill in the decryption function below that accepts a String which is already encrypted using today’s keys. Every three characters of the String can be one letter in the decrypted String. For example, 'de4' could be 
the letter 'a' depending on today's Day and the keys loaded.
Remember that the space character needs to be changed from '-' to ' '.

    `func decrypt(message: String) -> String`

# Hints

In order to pass tests please do not modify the encryption keys

Think of invalid input calls for your app. 
