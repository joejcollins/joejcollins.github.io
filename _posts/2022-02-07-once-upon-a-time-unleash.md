---
layout: post
---
### Let the hack commence

It is not all work and no play here at Zengenti (https://www.zengenti.com/). We love getting together for a BBQ, a walk or a casual game of cricket but one thing we really look forward to is the annual hackathon.  If you are not familiar with a hackathon, don’t worry it’s nothing sinister and no hacking of banks goes on.  Every year we stop monitoring the Kanban boards, cancel our stand up meetings and take two days to work on something (anything) we find interesting. Many great ideas have come from this annual ritual that have benefited both our customers and staff at Zengenti.   

We are not crazy, so we still answer the phones and provide support. But the focus becomes a free for all, to play with things that aren’t part of our normal work with Contensis.  This actually represents a large investment for the company to have the entire staff take two days to mess about with things that they find interesting or diverting, but historically this has paid dividends. This year five of us took a look at feature toggling.

### You turn me on

What is feature toggling?  Conceptually it is not that hard to grasp.  When you are developing software you want to add features.  You also want to add them as soon as you can, to see if they work.  Building software is an exploratory process.  It is not like building a house.  Houses are made up of bits and pieces that are known to be reliable.  All the things that are lying around at the builders merchant.  I am not saying that building a house is easy, I have had a go and clearly it isn’t, but software development is always about doing something new.  

Every piece of software is a prototype intended to solve a unique problem and one is never entirely sure if a new feature will solve part of that problem.  The key point is that it is uncertain.  The challenge is introducing unknown features to a working piece of software without messing up some other feature.  The solution is to introduce each new feature with a built in on/off switch.  The new feature can be lying dormant, then when you are ready, you can turn it on.  And equally, if things don’t go to plan you can turn it off again.  These on/off switches are colloquially known as feature toggles because they allow you to toggle a feature on or off.

### Unleash the toggles

At Zengenti, we have flirted with feature toggling using configuration files built into each piece of software.  If we needed to turn something on or off we would edit the configuration.  It’s a pretty simple way to start but it is limited.  Whoever turns the feature on or off has to have access to the configuration file and know what they are doing, at least a bit.  To get around this issue there are a number of feature toggle services available on the market which provide a pleasant web interface to turn features on or off.  If you google for “feature toggles” you can see a bunch of adverts for different services.  We decided we would like to try one out for our hackathon.  The question is which one?  It is a mantra at Zengenti…”if you don’t know where to start, just start”.  So rather than do an in depth investigation and comparison of features we picked one, that suited our style.  We are a multilingual programming organisation that favours open source.  Unleash https://www.getunleash.io/ fitted the bill for us, especially since it is written in JavaScript and we could host the service ourselves.  Amongst other things we also provide hosting for our customers, so hosting a service like Unleash is a simple matter.

[Full disclosure: We convinced Unleash to send us some tee-shirts in exchange for writing about our experience.  The other mantra at Zengenti is “Can we have a tee-shirt?” and we apply the same reasoning to our colleagues in other organisations.  Though I will be honest there is a healthy trade in Zengenti socks going on as well.  It seems that the price of a programmer at Zengent is a pair of socks, but that is another story.]

### The host with the most

The key to beginning with Unleash is the hosted service, which is the home for your feature toggles and provides a web interface to turn them on or off.  There is no need to host the service yourself.  The team at Unleash aren’t completely benevolent; they have to eat like the rest of us, so for a fee they will provide a hosted service for you.  Allowing you to off load the effort and cost of hosting. 

Look no further than Gitlab if you are looking for other low cost options .  If you are hosting your source code with Gitlab then Unleash is baked right in.  It is not very obvious, but  you’ll find it under “Deployments > Feature Flags”.  Here at Zengenti, hosting is part of our core business, so hosting the Unleash server doesn’t represent a challenge.  That is not to say it is always our favoured option.  Hosting the Unleash server on our infrastructure is a cost and an inconvenience, even if that cost isn’t hitting our credit card directly.  Nevertheless, setting up the Unleash server is pretty straightforward.  If you want to use Docker there is a readily available image to get you going.  We chose the option to set up all the pieces ourselves.  Essentially it’s a PostgreSql database and a JavaScript application, nothing unusual to see here and easy to integrate into the infrastructure-as-a-service tools we use at Zengenti.

### Monty the Python

Setting up the Unleash server is just a preamble to the main event of using feature toggles in our software.  Like many software developers we find Python and Flask are a handy means to create an API.  We drive a lot of interrelated stuff via our API.  It is an environment where deploying new changes can have knock on effects elsewhere in our systems. 

Which is exactly the situation where feature toggles would provide an extra layer of protection, giving us the confidence to deploy changes knowing we can roll them back in an instant.  Previously we had used combination configuration files and rolling back deployments to earlier versions.  It worked but late on a Friday night when you are tired and want to undo a change so you can attend to it on Monday morning, it required more effort than we would like.  Our hope was that Unleash would reduce that effort. Fortunately it does.  

![Unleash Platform](/assets/unleash-server.jpg)

Unleash provides an extension https://github.com/Unleash/Flask-Unleash that smooths the introduction of feature toggles for Flask APIs.  Initially we were confused by the apparent complexity of the Unleash extension.  It is only contacting the Unleash server for information about the feature toggle, so why the complexity?  Turns out that the Unleash extension is asynchronously contacting the Unleash server in the background.  So when you request a toggle, it has already been retrieved.  

Why bother going to this effort?  Look mum!  No delays!  This gives us the intriguing possibility of testing the performance of features as well as their functionality.  It becomes a relatively trivial task to compare the performance of new features with old features.  You can flip the switch and try it out with no reloads and no reboots.  Any delays or lags can be attributed to the feature on, not to the feature toggle.

### A cup o’JavaScript

At Zengenti we like to work efficiently and don’t want to reinvent the wheel, so the applications that use our API are often written using JavaScript and Reactjs.  It’s a pretty conventional combo.

![Unleash Proxy](/assets/unleash-proxy.jpg)

Once again the people at Unleash have provided an SDK for our convenience and enjoyment https://github.com/Unleash/proxy-client-react.  The eagle eyed among my readers will notice that this is a client for a proxy.  So you also need a proxy to go with the client https://github.com/Unleash/unleash-proxy .  At first glance, this seems like yet another layer of extra complexity that one would rather do without.  But have faith, the people at Unleash have done the thinking for us.  A Reactjs client typically runs in the browser with the client.  So it is running in an environment where the user has access to all the settings and can view any calls to the Unleash server.  And the calls to the Unleash server include your secret key.  Well you wouldn’t want anyone taking a look at your feature toggles, so you can’t go handing out your key to anyone with a browser.  The solution is a proxy between the browser and the Unleash server.  Like the Python SDK, the proxy server can be polling the Unleash server in the background, keeping an up to date version of your feature toggles.  So it can react quickly (pun intended), but it also keeps your secret key out of the grubby little hands of your users.  This does sound a tad complicated as I write it but for practical purposes it wasn’t.  We embedded the Unleash proxy into the Nodejs server, which was serving our Reactjs application and then the Reactjs proxy client did it’s work.  Now we can turn features on and off in our Reactjs applications as well.

### Teaming with toggles

Normally our hackathons are just a festival of nerdiness.  We like a bit of technology and the hackathons are an opportunity to indulge our desires.  But using a feature toggle service raises some interesting possibilities that weren’t available with our old approach using configuration files.  Now that we are freed from the configuration files, two or more applications can use the same set of feature toggles, irrespective of where they are or what languages they are written in.  Feature toggles can be a means to tie together teams as well as technologies.  Now we can turn a feature on and off in a Reactjs application, that makes use of a Python API endpoint and is turned on and off with the same feature toggle.  

The Unleash server interface means that someone else (who isn’t one of the developers) can also do the switching.  The developers don’t have to be around for the launch of a new feature, they can be getting on with something else.  A manager or stakeholder that has closer contact with our customers can take over that responsibility.  That isn’t to say the developers are out of touch with the process.  We have set up our Unleash server to post changes to one of our Slack channels.  Now whenever a feature is toggled on or off, the channel is notified.  No one needs to go on to high alert but it just keeps everyone informed.  Introducing feature toggling has had the side effect of improving and smoothing communications between our teams.

### Let the toggling commence

We have been using Unleash since before Christmas, so not long really.  It would be overstating it to say that it has saved our bacon.  It has, however, made our lives much easier and more relaxed.  Sure there is always a bit of tension with releasing a new feature, but knowing that it can be safely rolled back takes the pressure off.  Which is exactly what it is supposed to do.  We expect to be toggling happily ever after.

If you are a Zengenti customer and want to start making use of feature toggles give us a call.  We would be happy to share our experience and take you through the process we used.  Otherwise contact the team at Unleash, who knows you might even be able to get a tee-shirt out of them too.
