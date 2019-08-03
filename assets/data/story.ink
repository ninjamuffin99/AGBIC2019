VAR uber_eats = "Uber Eats"
VAR postmates = "Postmates"
VAR claw_crew = "Claw Crew"
VAR teeth_gang = "Teeth Gang"

-> gang_hideout
-> intro
== intro ==
My package is missing!
* You look around to see if you can find any clues.
- I don't notice anything out of the ordinary. I hope I didn't drop it on my way here...
Looks like there's a few shops in this small little street. I should ask some people there if they may have seen it.
-> shop_choices


== shop_choices ==
Which store should I go inside?
+ (in_apple) [Apple Store]
    You walk in {in_apple > 1: once again}.
    There's a nice young man at the desk, and they're wearing a blue shirt with the old logo on it. How retro.
    {not asked_apple: "Hello welcom to Apple store buy an iPad pls" | "Hmmm, sorry kid, I still haven't seen any sort of package of yours around here" -> shop_choices}
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
        + + + (asked_apple) [Package]
            "A package? What are you a delivery kid or somethin'?"
            "Hmm..."
            "Haven't seen anything like that, but if you happen to drop on by again, and something comes up, I'll be sure to tell ya"
        + + + [iPad]
            "So basically it's the new model. Standard edition comes with 16 petabytes, more than enough for light use."
    - - ->shop_choices
+ [Sushi/Ramen/Food bar or weeb shit like that]
    This place smells very good.
    Like momma's cookin
    This place has a chill vibe.
    The bartender greets you
    "HMMM 21+ in here kid, sorry"
    * [Explain]
    - "Looking for a package huh?"
    Woah, you found a secret hideout. It's the {claw_crew}.
    -> gang_hideout
+ [Go home]
    Oh well. You snooze you lose. Seems like you can't find your package. You just gotta take the L.
    YOU GO HOME
    YOU LOST THE PACKAGE
    YOU LOST YOUR JOB
    AND NOW YOU ARE POOR AND HOMELESS
    HOMELESS ENDING
    -> END
-> shop_choices

== gang_hideout ==
Alright, I just arrived at the gang hideout.
It's rumored that {claw_crew} has business ties to {uber_eats}. Some sort of weird money laundering scheme or something like that.
* Sneak through the hallways Snake from Metal Gear Solid 2
- Man I love that video game
You meet a boy
* Hello
- "Aw shucks jee whiz this is embarrassing."
-> END
