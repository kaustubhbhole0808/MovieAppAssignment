# MovieDetails
MovieDetails

Please check internet Connection before running Ap. As No internet handling Not done property, app may not launch after splash screen in case of No internet. 

Requirements - 

1. Display List of movies through CollectionView with LOAD More Feature - DONE
2. Clicking on poster should show the Movie Details screen along with Movie Poster, Movie Title, Release Date, Movie Description and List of Similar movies, Reviews & Credits - DONE
3. APIS are used from TheMoviedb - 
GET - /movie/now_playing 
GET- movie/{movie_id}/similar
GET- movie/{movie_id}/reviews
GET- movie/{movie_id}/credits
4. Written UNIT Test cases - DONE
5. Added my own logic for Search Algorithm. By NOT using Contains search as mentioned in requirements.
6. Architecture Patten Used - VIPER 
7. UI Design - Done with Programmatically and Using Storyboard and Xibs  


Additional Feature - 
1. Added Load More functionality in Movies List 
2. CGD mechanism (dispatch_global_async) used to download images. 
3. Feature created as Framework So that it can be plug to any Host app.

Known Issues 
- Not Focused on pixel perfect UI as this is just an Assignment 
- Somewhere used hardcoded values and some code might be not at proper place where it should be. 

Note -
 As the assignment was quite a large I didnt get a time to structure code properly. So plese ignore few things.    
