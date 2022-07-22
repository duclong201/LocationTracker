# LocationTracker

## 1. How to run

## 2. Implementation decision and trade-offs
I decided to use the default Apple MapKit instead of other 3rd party libraries because I am not familiar with using location service in iOS. Also, Apple has a very thorought documentation of the MapKit which I can rely on for research and save time for the project. Although, default MapKit and CoreLocation could be less accurate and effective, it has served its purpose as a prototype to prove the idea.

## 3. Any architectural considerations and reasonings
### Refactor Location Manager and location functions into a seperate class
  #### Pros: 
  - Allow access to the same instance of location manager throughout the apps
  - Cleaner code in ViewController
  
  #### Cons:
  - With the current application, there will be functions with only a few lines
  
  #### Reason: 
  At the time of submission, the location manager has very simple applications, which are to request permission and update location. Also, it was only used in 1 place in the app so that it was not neccessary to proceed with the refactoring.

## 4. Areas of focus
I want to make an intuitive applicaiton to use 

## 5. Any copied code, references and 3rd party libraries

## 6. Duration
- Research and brainstorming: 1-2 hours
- Execution: 2-3 hours
- Testing and debugging 1-2 hours

## 7. To-do list and updates time
Date 22/07/2022
- [x] Map view
- [x] Request and handle user permission for location access and notification
- [x] Handle update of user location
- [x] Display text when user has moved more than 10m
- [X] Unit test

### To do
- [ ] Add polyline to link user previous locations
- [ ] Save past sessions and display with map and polyline
- [ ] Rank session based on average speed
- [ ] Custom notifications
- [ ] Refactor location manager

## 8. Others
