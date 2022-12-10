# OpenActing

This github repo is the codebase for the OpenActing project. This was made by Alec Varma and Brandon Hampstead as the final project for our CS3200: Database Design class. The project is built using Flask REST APIs in a Docker container, with a frontend implemented on our professor's AppSmith server (https://appsmith.cs3200.net/app/openacting/open-roles-638baa9d5bc9880dbcb1dd33). If the link is not responsive, it means that the AppSmith server has been turned off.

## Overview

Our project, OpenActing, serves as an application where actors or directors can find projects to work on together. 

Actors can view and apply to open projects. Actors can also look at their profile, and see their reviews and outgoing applications.

Directors can view applications made to their projects, as well as be able to create new projects, write new reviews, or make new roles for their projects.

Finally, System admins can create and update actor's accounts.

## AppSmith Walk-through 

[Open Acting Part 1](https://youtu.be/z-4z2cItEbs)

[Open Acting Part 2](https://youtu.be/Gqt3OgO1GW4)

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 






