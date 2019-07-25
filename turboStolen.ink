My package is missing!
* You look around to see if you can find any clues
- I don't notice anything out of the ordinary. I hope I didn't drop it on my way here...
Look's like there's a few shops in this small little street. I should ask some people there if they may have seen it.
-> shop_choices
== shop_choices ==
Which store should I go inside?
+ (in_apple) [Apple Store]
    You walk in {in_apple > 1: once again}.
    There's a nice young man at the desk, and they're wearing a blue shirt with the old logo on it. How retro.
    "Hello welcom to Apple store buy an iPad pls"
    You look at the iPads. This one seems to have the newest CPU... better battery life... and an even higher refresh rate for the display... Hmmm
    + + [Leave]
        You leave the Apple store.
        -> shop_choices
    + + [Stay]
        These electronics are a bit pricey, and out of my budget. Too bad they don't have anything more affordable
        for the everygirl like myself. Although they were once a status symbol in culture, they fell out of style
        after the company lacked their past innovation and vision.
        Nowadays they have came back in style as there's been a wave of 2000s-2010s nostalgia.
        Wait a minute...
        I was trying to find out what happened to the package!
        "Uhhh hey do you need help or something?"
        They must have noticed the sudden worry on my face.
        * * * [Package]
            "A package? What are you a delivery kid or somethin'?"
        * * * [iPad]
    - - ->shop_choices
        sfd
+ Go home
    Oh well. You snooze you lose. Seems like you can't find your package. You just gotta take the L.
    YOU GO HOME
    YOU LOST THE PACKAGE
    YOU LOST YOUR JOB
    AND NOW YOU ARE POOR AND HOMELESS
    HOMELESS ENDING
    -> END
-> shop_choices
