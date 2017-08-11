# Pre-work - *Tipster*

**Tipster** is a tip calculator application for iOS.

Submitted by: **Himal Sherchan**

Time spent: **3-4** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [ ] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [X] Currency conversion!

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![alt text](https://raw.githubusercontent.com/hshercha/Tipster/master/static/Tip_Calculator.gif)

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** Having worked with iOS before, I would still have to say that the IDE could take a while to get used to. Getting used to navigating between UI windows and code windows could take a while to get used to. 
Outlets are references to the UI object and actions are their respective event handlers. Different UI objects have different set of event handlers. You reference that in the code to perform certain types of "actions"

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** Whenever you instantiate a strong variable, the reference count increases by 1. The ARC deallocates variables when the reference count hits 0. If two strong variables have a reference to each other then they can get into strong reference cycle.


## License

    Copyright [2017] [Himal Sherchan]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
