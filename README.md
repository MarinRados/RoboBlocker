# RoboBlocker

An iOS application that processes incoming phone calls and messages.

## Extensions

This app uses two extensions to process incoming calls and messages: CallDirectoryHandler and MessageFilterExtension. For these extensions to work, a user must enable them in settings.

### CallDirectoryHandler

To enable RoboBlocker incoming call blocking a user has to go to Settings -> Phone -> Call Blocking & Identification -> Enable RoboBlocker.
Once that option is enabled the extension will:

1. Block all incoming calls from numbers in the block list found in the app, number 253-950-1212 is added by default
2. Mark number 425-950-1212 as a suspicious call
3. Let all other numbers through

### MessageFilterExtension

To enable RoboBlocker incoming call blocking a user has to go to Settings -> Messages -> Unknown & Spam (Message Filtering) -> Enable RoboBlocker. Also, SMS guard switch has to be turned on in the app.
Once that option is enabled the extension will filter all the SMS messages received by the filter words found in the filter word list in the app and by numbers in your block list. 
Those messages will go to a "SMS Junk" folder in your messages.
Please note that this extension only filters and does not block incoming messages.
Default filter words are "free" and "won".

## Screens

### Info screen

Info screen contains mocked count of blocked calls, suspicious calls and filtered messages.

### Block List screen

This screen contains a switch which allows users to turn on blocking of the calls for all numbers except for the contact list (not implemented, for more info please see below).
Also contains a list of numbers added to the block list and an input field to add additional numbers. Delete option is also enabled in the list.

### SMS Guard screen

SMS Guard screen contains a switch which allows users to turn on SMS message filter.
Also contains a list of words added to the filter list and an input field to add additional words. Delete option is also enabled in the list.

## Block all numbers except the contact list

Since CallDirectoryHandler does not have an option of creating a whitelist of contacts and only takes the block list, this option is not completely implemented. The option is prepared both on UI end with a switch on the Block List screen and fetching the contacts from the user's contact list in case the permission is given.

## Architecture

Although MVC is usually recommended for smaller apps the MVVM is used to make the app easy to test, maintain and scale at later updates. Use of the coordinators makes the architecture MVVM+C to also add better dependency injection and easier navigation. 

## Data storage and sharing

Data that is used between the app and extensions is saved locally in the UserDefaults storage. An App Group entitlement is created that shares the data between the containing app and extension targets. 
This is necessary because [extensions](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/ExtensionOverview.html#//apple_ref/doc/uid/TP40014214-CH2-SW2) are not apps and are separate processes in the system. SharedData file contains the shared UserDefaults logic. 
To see more about App Groups refer to [official documentation](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_security_application-groups) .

## Tests

Both BlockListViewModel and GuardViewModel are covered by unit tests. GuardViewModel coverage is 100%, while BlockListViewModel is covered 80% because the contacts implementation is not complete.
