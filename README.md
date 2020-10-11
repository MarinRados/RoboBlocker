# RoboBlocker
An iOS application that processes incoming phone calls and messages.

## Extensions

This app uses two extensions to process incoming calls and messages: CallDirectoryHandler and MessageFilterExtension. For these extensions to work, a user must enable them in settings.

### CallDirectoryHandler

To enable RoboBlocker incoming call blocking a user has to go to Settings -> Phone -> Call Blocking & Identification -> Enable RoboBlocker.
Once that option is enabled the extension will:

1. Block all incoming calls from numbers in the block list found in the app
2. Mark number 425-950-1212 as a suspicious call
3. Let all other number through

### MessageFilterExtension

To enable RoboBlocker incoming call blocking a user has to go to Settings -> Messages -> Unknown & Spam (Message Filtering) -> Enable RoboBlocker.
Once that option is enabled the extension will filter all the SMS messages received by the filter words found in the filter word list in the app. Those messages will go to a "SMS Junk" folder in your messages.
Please note that this extension only filters and does not block incoming messages.

## Architecture

There is no "best" architecture, only best for specific projects. For really small projects it's ok to use MVC, for larger one MVVM and for really large VIPER, but I choose MVVM+C because it offers application to be scalable, maintainable and testable. Its powerful but easy to use. 

## Important part of the application
*Please note: they are not arranged in importance order*

### MainCoordinator
Holds UITabBarController and is responsible for main navigation throught application.

### StorageProviderProtocol
This protocol enables us to test storage and if we want to change storage provider (like Realm, CoreData) in some point of time we just need to conform it to. At this point, I used UserDefaults storage because models are not complete and big.

### Info
This screen show information that is currently hardcoded, but the general idea is to be fetched from some service. It is done with way how I usually work. With ViewController, StoryBoard and ViewModel as part of one screen.

### SMSBlocking
This screen is made programmatically without a storyboard, just to show you that I am not dependent on storyboards. Also feature nice CoreAnimations.

### BlockList
This screen probably looks familiar because I made it to look like RoboKiller block list screen. It is also made with storyboard with custom UiTableViewCells that are defined in separate XIB's . User need to add number with country code for example in Croatia is 38599123123 (from 099123123).

### Localizable
Helper enum for managing translations. Also, this app default language is English, but it's also localized to Croatian (Nikola can confirm :D)


### Styling

Helper structure for making, managing and simpler using of styles in the application. Example:

defining new style:
```swift
static let bigTitle = base.composing { label in
        label.textColor = UIColor.black
        label.font = Font.medium(size: 32)
        label.textAlignment = .left
    }
```
usage on one label
```swift
 UILabelStyle.bigTitle.apply(to: infoBigTitleLabel)
```

or multiple
```swift
 UILabelStyle.mediumGray.apply(to: spammersOnListLabel, myBlockedCallsLabel)
```     
### CallDirectoryHandler
This is CallDirectoryExtension for call blocking/identification. More informatios are available in [official documentation](https://developer.apple.com/documentation/callkit).

### MessageFillterExtension

This extension allow us to identify and handle incoming messages. [More information](https://developer.apple.com/documentation/sms_and_call_reporting/sms_and_mms_message_filtering/creating_a_message_filter_app_extension)
Currently blocked words are:
* lottery
* you won
* prince

Also, keep in mind, blocked numbers for calls also block SMS from that number.

### SharedStorage

Extension on UserDefaults that with support of GroupID's enable us to share data between main app and extensions, because extension are separate process in system.


### Tests

This project have UI and Unit test cases where most complex viewModel (BlockListViewModel) was tested with some utility methods.
