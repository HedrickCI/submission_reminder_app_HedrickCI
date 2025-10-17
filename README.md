The README was unironically the hardest part of the assignment. Not because i have any problem explaining any of my workings, but because the whole idea of writing can be pretty ... ehh

In this repo we have two shell scripts. create_environment.sh and copilot_shell_script.sh. 
Which work hand in hand to initialize Remindr, a submission reminder app styled after Grindr, that helps students keep up with their academic tasks.

To initialize our app you will need to have access to a Linux terminal, or Git on your Windows computer, in case you cant access a virtual box.

You will clone my repo (https://github.com/HedrickCI/submission_reminder_app_HedrickCI) by using the git clone command

After that you will move into the directory submission_reminder_app_HedrickCI and your terminal will look like this 

![terminal1](https://github.com/user-attachments/assets/e56bb4c9-d812-436b-b660-dbf31e256d72)
And after you get into my directory you will have to give access to both scripts by usage of "chmod +x *"
Then you will "bash create_environment.sh" this command initializes the app and asks you to add your "name"
After you add your name the files are populated on their own and the app is ready to be run
something you do by running ./submission_reminder_"name"/startup.sh (the "./"  at the front is interchangeable with bash btw)
THIS step is what opens up the app Remindr. And now you can log in YOUR personal assignemnt and all that by 
running copilot_shell_script.sh where you configure which assignemt YOU have missing. I might be slow because i 
just realized i didnt work out a way to change the number of days 
but yeah after youre done with that. you just push back to the repo and everything is up to date

This was a fun exercise, i enjoyed doing it and by now i think i should really move to the linux ecosystem

Thank you for an awesome course. And thank you for reading my readme HAHA
