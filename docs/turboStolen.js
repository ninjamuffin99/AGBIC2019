var storyContent = ﻿{"inkVersion":19,"root":[["^My package is missing!","\n",["ev",{"^->":"0.2.$r1"},{"temp=":"$r"},"str",{"->":".^.s"},[{"#n":"$r1"}],"/str","/ev",{"*":"0.c-0","flg":18},{"s":["^You look around to see if you can find any clues",{"->":"$r","var":true},null]}],{"c-0":["ev",{"^->":"0.c-0.$r2"},"/ev",{"temp=":"$r"},{"->":"0.2.s"},[{"#n":"$r2"}],"\n",{"->":"0.g-0"},{"#f":5}],"g-0":["^I don't notice anything out of the ordinary. I hope I didn't drop it on my way here...","\n","^Look's like there's a few shops in this small little street. I should ask some people there if they may have seen it.","\n",{"->":"shop_choices"},["done",{"#f":5,"#n":"g-1"}],{"#f":5}]}],"done",{"shop_choices":[["^Which store should I go inside?","\n","ev","str","^Apple Store","/str","/ev",{"*":".^.c-0","flg":4},["ev",{"^->":"shop_choices.0.8.$r1"},{"temp=":"$r"},"str",{"->":".^.s"},[{"#n":"$r1"}],"/str","/ev",{"*":".^.^.c-1","flg":2},{"s":["^Go home",{"->":"$r","var":true},null]}],{"c-0":["\n","^You walk in ","ev",{"CNT?":".^"},1,">","/ev",[{"->":".^.b","c":true},{"b":["^ once again",{"->":".^.^.^.8"},null]}],"nop","^.","\n","^There's a nice young man at the desk, and they're wearing a blue shirt with the old logo on it. How retro.","\n","^\"Hello welcom to Apple store buy an iPad pls\"","\n","^You look at the iPads. This one seems to have the newest CPU... better battery life... and an even higher refresh rate for the display... Hmmm","\n",["ev","str","^Leave","/str","/ev",{"*":".^.c-0","flg":4},"ev","str","^Stay","/str","/ev",{"*":".^.c-1","flg":4},{"c-0":["\n","^You leave the Apple store","\n",{"->":".^.^.^.^.^"},{"->":".^.^.g-0"},{"#f":5}],"c-1":["\n","^These electronics are a bit pricey, and out of my budget. Too bad they don't have anything more affordable","\n","^for the everygirl like myself. Although they were once a status symbol in culture, they fell out of style","\n","^after the company lacked their past innovation and vision.","\n","^Nowadays they have came back in style as there's been a wave of 2000s-2010s nostalgia.","\n","^Wait a minute...","\n","^I was trying to find out what happened to the package!","\n","^\"Uhhh hey do you need help or something?\"","\n","^They must have noticed the sudden worry on my face","\n",["ev","str","^Package","/str","/ev",{"*":".^.c-0","flg":20},"ev","str","^iPad","/str","/ev",{"*":".^.c-1","flg":20},{"c-0":["\n","^\"A package? What are you a delivery kid or somethin?\"","\n",{"->":".^.^.^.^.g-0"},{"#f":5}],"c-1":["\n",{"->":".^.^.^.^.g-0"},{"#f":5}]}],{"#f":5}],"g-0":[{"->":".^.^.^.^.^"},"^sfd","\n",{"#f":5}]}],{"#f":5}],"c-1":["ev",{"^->":"shop_choices.0.c-1.$r2"},"/ev",{"temp=":"$r"},{"->":".^.^.8.s"},[{"#n":"$r2"}],"\n","^Oh well you snooze you lose, seems like you can't find your package. Sometimes you just gotta take the L.","\n","^YOU GO HOME","\n","^YOU LOST THE PACKAGE","\n","^YOU LOST YOUR JOB","\n","^AND NOW YOU ARE POOR AND HOMELESS","\n","^HOMELESS ENDING","\n","end",{"->":".^.^.^"},{"#f":5}]}],{"#f":1}],"#f":1}],"listDefs":{}};