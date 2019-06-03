__Hurobot__


*__About__*

This project is a attempt in struggling for automation of keeping and controlling friendly  climate environment during all the growing  period (lifecycle of plants) inside box, including software and hardware that serves for telemetry/telecommand system.


*__What__*

The main goal is to try to achieve as much as possible autonomous indoor growing decision.

Includes for now:
- Sodium-vapor lamp, 250 W
- 2 LED lamps, 12 V
- 4 Computer coolers
- Termostat
- Mechanical timer
- AC/DC adapter 12V
- 2 Surge protectors
- Raspberry Pi 3B+
- Relay module
- Camera module
- Servo motor
- Slack bot

![alt text](images/1.jpg?raw=True "Inner View")
![alt text](images/5.jpg?raw=True "Controls block")


*__RPI periferals__*

Among modules for  Raspberry Pi circuit were used 5V Relay module with 2 contacts, Servo motor and Camera module.

![alt text](images/4.jpg?raw=True "RPI periferals modules")

Following functions are being performed with the help of RPI:
- Scheduling states of devices
- Extra lights switching
- Fans switching
- Taking snapshots of inside view
- Remote controlling

![alt text](images/3.jpg?raw=True "Devices managed by RPI")


*__Slack Bot description__*

As tool for remote monitoring and influencing the state inside box Slack platform with Hubot were used.

Implemented bot has the next list of skills:
- Switch/check the state of devices
- Grab photo
- Edit switching schedule of attached devices


*__TODO__*

* Control main electricity with RPI circuit
* Add termostat as Raspberry Pi module
* Switch to using LED lights 


*__Resources__*
- rpi and docker basics
- raspberry pi modules
- relay module
- camera module
- pigpio
- hubot
