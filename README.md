An exploration of Augmented Reality development using ARkit



Project outline:

MVP:
-Start Button click
    -start repeating pattern (every .5 sec)
        -record audio
            -create audio level graph
            -wrap into circular graphic
            -pass graphic into node positioning func
        -node positioning func
            -receive visual graphic
            -get current position
            -paste graphic at current position relative to parent node

-End button click
    -disables timer
    -Stops recording
    
-Reset button click
    -pause session
    -ennumerate over children nodes and delete
    -reset tracking & existing anchors
