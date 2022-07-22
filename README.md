# LocationTracker

![alt text](https://github.com/duclong201/LocationTracker/blob/main/Screenshot1.PNG)
![alt text](https://github.com/duclong201/LocationTracker/blob/main/Screenshot2.PNG)

## 1. Environment requirements
- Xcode 13.4.1
- iOS 15.0

## 2. Implementation decision and trade-offs
Decision: Using Apple MapKit instead of 3rd party libraries.
Reason:
- I am not familiar with using location service in iOS
- Apple provides a very thorought documentation of the MapKit which I can rely on for research and save time for the project
Trade-offs:
- Less accurate and effective

## 3. Architectural considerations and reasonings
MVC pattern
Reason:
- The project is simple and using MVVM would be overkill with new classes and bindings, which is not necessary

## 4. Areas of focus
I want to make an intuitive and fun application to use. As a result, I have focused on the live updates of map such as new annotation, speed, etc.

## 5. Any copied code, references and 3rd party libraries
References:
- https://www.raywenderlich.com/9956648-mapkit-tutorial-overlay-views
- https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started
- No 3rd party library

## 6. Duration
- Research and brainstorming: 1-2 hours
- Execution: 2-3 hours
- Testing and debugging 1-2 hours

## 7. To-do list
- [x] Map view
- [x] Request and handle user permission for location access and notification
- [x] Handle update of user location
- [x] Display text when user has moved more than 10m
- [X] Unit test
- [ ] Add polyline to link user previous locations
- [ ] Save past sessions and display with map and polyline
- [ ] Rank session based on average speed
- [ ] Custom notifications
- [ ] Refactor location manager

## 8. Others

