---
title: "Designing for low-bandwidth education"
date: 2026-10-11
draft: false
summary: "A journey in bridging the education gap through technology."
deck: "A journey in bridging the education gap through technology"
hero_image: "/images/backgrounds/project_highlight.jpg"
author: "Javier Alvarez"
---

# An introduction to LEAP

In an [earlier post](/blog/first-challenge-blog), we discussed how we started our
partnership with AID India. As an NGO actively working in the field, they know 
the needs of the people they are helping better than anyone else. This is how our
first challenge became helping to bring quality education to rural villages 
in India.

AID India curates educational content they use in their classrooms in the Eureka 
Villages. We learned that they relied on their own tailored Android application 
to deliver the content to the kids in the classroom, streaming videos from cloud 
storage in AWS. The idea was sound. This is something that children in the 
developed world are used to every day. 

In remote villages, however, the situation is different. Internet connections 
are either spotty or nonexistent. When this technology is used in the classroom, 
the kids quickly lose focus and give up waiting for the videos to load.
A solution that works perfectly in developed countries does not work at 
all for these villages in India.

This is one of the many reasons why systems must be designed in the context 
where they will be used. A wrong assumption about the environment can be the 
difference between a great solution to a problem and one that just does not work.

With this problem in mind, our first project, the Low-Bandwidth Educational 
Access Platform ([LEAP](/projects)), was born.

# What videos need to be buffered?

We started gathering all the constraints of the problem. To a first approximation, 
the problem could be solved by buffering. There were still a few challenges, 
though. First of all, we had no control over the Android application, so we could 
not buffer the videos ahead of time. We learned that each group of kids would 
share a device in the classroom, connected to a local network via Wi-Fi or 
Ethernet.

As we learned more about the organization of the classrooms, we started 
realizing that the devices the kids used were quite heterogeneous. AID India 
was using what they could get their hands on, from tablets running Android on 
ARM devices to thin-client computers, on which they would also install x86 
Android. Getting the content delivered to each one of these devices independently 
was a big challenge.

We suggested that AID India have a centralized computing node per classroom 
that would cache the video content. The idea was simple: a 
least-[frecency](https://en.wikipedia.org/wiki/Frecency)-used cache could keep 
track of how frequently and recently a video has been used, and keep the most-used 
ones in the local storage. The system would serve almost as a regular plain HTTP 
proxy, with the capacity to cache specific video data.

While this could work, upon further discussion with AID India we realized we 
could build a simpler and more effective system for their needs. See, the 
educational content they serve is curated periodically. They know ahead of time
which videos are going to be shown in the classrooms. This means that we do not
need to embed a heuristic about which video is likely to be accessed.

# How do we manage the LEAP node?

The missing piece was understanding how to update the content that needs to be 
served. We could have gone with a management API on the LEAP node that would 
allow a teacher to select the data to be downloaded and then have it download 
during the weekend. We initially proposed this to AID India, but their reaction 
was mixed. For them, having a centralized management system would be 
a better solution. That way, they could ensure all classrooms have received the 
order to download the new content. 

This would mean making the LEAP nodes publicly accessible over the 
internet so that AID India could reach them and command the nodes to update
with new content. To us, this was not a good idea. First of all, the nodes already
operate in locations where the internet is spotty. They might not be available 
at the time an update is commanded. Secondly, this would also bring a 
number of security concerns that needed to be mitigated.

Because of these drawbacks, we started thinking about polling for new content 
rather than having new content pushed by the central server. Since AID India 
was already using AWS S3 storage, we could simply host one more file in the 
bucket, which we call the **manifest** file. This file declares the content
the LEAP node must cache, organized by playlists, each one containing a set 
of videos.

The manifest file gets uploaded to S3 and periodically updated with the content
for the next week. The LEAP node polls the manifest at a configurable interval.
With this solution, a single file update in the S3 bucket commands all LEAP 
nodes around the globe to update their content, using a delivery mechanism that
we were already using for the video data.

No extra security was needed, since the nodes are not directly accessible from 
the internet. We didn't have to deal with complex solutions like Tailscale or 
VPN networks, and at the same time, we could guarantee that, as long as 
sufficient time had passed since the last manifest update in S3, all LEAP nodes 
would try to fetch the new manifest content. If a download is interrupted, 
LEAP automatically retries after a configurable backoff interval. After repeated 
failures, it backs off exponentially to avoid hogging the network.

<div style="width: 100%; display: block; margin: 20px auto; border-radius: 8px;">
    <img src="/images/blog/leap_design/arch_diagram.svg" alt="LEAP Architecture" />
</div>

# How do we serve the content to the classroom?

Apart from the operation of the backend (handling the downloads and caching 
behavior), the LEAP node eventually needs to serve the video content to the 
devices that the children use in the classroom.

We have designed a web server (accessible on the LAN at http://leap.local via 
[mDNS](https://en.wikipedia.org/wiki/Multicast_DNS)). The web server shows
the playlists currently downloaded, along with the videos accessible in each.
Videos show their view count, a feature requested by AID India to keep track of
how many children have watched the content.

The UI is optimized for both mobile and desktop computers, and is sufficiently
simple so that there are no distractions or extra frills that draw attention 
away from the actual content.

<div style="width: 100%; display: block; margin: 20px auto; border-radius: 8px;">
    <img src="/images/blog/leap_design/desktop.png" alt="Desktop UI" />
</div>

LEAP still provides a programmatic API that may be used in the future by the 
existing AID India application to hook video content into it. However, AID India
is actually interested in moving in the opposite direction, potentially adding
other content like PDFs to LEAP, helping it to become the perfect offline 
learning tool.

<div style="max-width: 300px; width: 100%; display: block; margin: 20px auto; border-radius: 8px;">
    <img src="/images/blog/leap_design/mobile.png" alt="Mobile UI" />
</div>

# What actually is a LEAP node?

In short, a LEAP node is: 
- A Raspberry Pi 4 with 1 GB of RAM.
- An external USB storage drive with 256 GB.

We have chosen widely available parts that are easy to source around the globe
and are inexpensive. The magic of LEAP is in the software and the design tailored
to the needs of the communities that use the system. 

With the DRAM shortage affecting the world since the beginning of 2026, the choice 
of the 1 GB version has become critical to limit the cost of the system. 
In order to limit the resources LEAP needs, the software runs a small 
[Buildroot](https://buildroot.org/) distribution with the LEAP software 
being entirely written in [Rust](https://rust-lang.org/), making it small 
and performant.

This modest hardware is enough to serve up to 40 client devices in a classroom 
concurrently, and leaves some space for extensibility in the future.

# There are just too many topics to cover!

I have intentionally left many topics out of this post. I hope to cover 
them over time and give you a deeper insight into LEAP. Some of them include:
- Over-the-air software updates.
- Device provisioning (initial configuration).
- Completely offline operation.
- How AID India can centrally manage the distributed content with manifest files.
- Software security and architecture for security.
- Our approach to training AID India to manage the fleet of LEAP devices.
- Our approach to testing devices in the field and gathering usage diagnostics and 
  faults.

Many of these topics are still young and undergoing development, but we are 
already starting to test and deploy our first units in the field. We are very 
excited to have come this far, but we are even more excited about what is to 
come!

# Get involved!

We would love for more people to help us build LEAP and join us on this 
journey to bring quality educational content to places where the internet is not 
widely available.

If you are interested in joining in, or curious about our work:
- Have a look at our [GitHub](https://github.com/T4EQ/leap) page for LEAP. 
  Do you see an issue that interests you? Feel free to pick it up!
- Have a look at our discussions in [PRs](https://github.com/T4EQ/leap/pulls?q=is%3Apr) 
  or over [Zulip](https://zulip.t4eq.org/) if you want to see how we work.
- Send us an email at info@t4eq.org letting us know how you'd like to help!

