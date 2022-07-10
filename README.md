# flutter_windows

flutter_windows is a current project under development for building an escape room's SCADA system.

Currently, all programming logic is built in Raspberry Pi's using Java codebase (used as a PLC). No SCADA/HMI system currently exists.

Our future vision is to deploy a scalable technology stack that will allow us to:
1 - Build PLCs that can interface to any codebase with ModbusRTU/ModbusTCP communication capabilities for SCADA/HMI
2 - Build peripheral industrial PCs which can directly to PLCs via Modbus or Ethernet/IP
3 - Build SCADA/HMI systems that can interface to any PLC

These goals have resulted to the following technology stack:
1 - PLC: Raspberry Pi built with CodeSys PLC codebase
2 - Peripheral industrial PCs: Raspberry Pi built with Python for miscellaneous tasks/events
3 - SCADA/HMI: Flutter Framework (Dart codebase) deployable to Android, iOS/MacOS, Windows

This project is focused on the first prototype SCADA/HMI system built with the Flutter framework.
Main reasons for using Flutter:
1 - Cross Platform Deployment with one codebase as I am currently the only developer in our team - no HTML, CSS, Javascript required for now
2 - Ease of learning for fast development of prototype to determine feasibility and scalability of the framework for future expansion
3 - UI is beautiful, smooth, and renders fast
4 - Great open-source packages and widely available learning resources

Note: The current state of the program requires:
1 - A Modbus Server accepting ModbusTCP connection with local IP address 10.0.0.23
2 - This Modbus Server shall allow connection to the following registers:
    > Coils             : 0-1000
    > Discrete Inputs   : 0-1000
    > Holding Registers : 0-1 (Not Implemented Yet)
    > Input Registers   : 0-50 
    Note: Addresses listed above is dependent on the start address of registers allocated in the Modbus Server
As long as these registers are available for Modbus communication, the program will run - but status monitoring will not update unless the Modbus Server has been setup to update the exact registers.

Future Plans:
1 - Capability to setup rooms without fiddling with back-end configuration files
2 - Paint a relatively accurate top-down 2D representation of the rooms with live feedback (instead of tables) for ease of visualisation for operators
3 - Capability to see live trends/graphs of equipment status, progressions, sensor readings, and export into data files
4 - Create a cloud-based server to store any relevant data such as alert history, trends (point 2), etc.
5 - Allow ability to write handover notes for employees to utilise (a nice to have but not necessary)

For any questions/discussions, please reach out at: https://www.linkedin.com/in/joshuapocsidio/
