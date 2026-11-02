---
title: "Our Projects"
layout: "projects"
intro: "As part of our mission, we are actively working on projects that contribute to the UN's Sustainable Development Goals (SDGs). Our initiatives address a range of interconnected challenges, from improving access to quality education and supporting rural development to advancing biodiversity conservation and environmental monitoring. Our technological solutions aim to empower communities, expand access to knowledge and resources, and promote sustainable development. Our ongoing projects are described below."

projects:
  - name: "LEAP"
    subtitle: "Low-bandwidth Educational Access Platform"
    community: "AID India, Tamil Nadu, India"
    year: "2025"
    description: |
      Through their Eureka Village Centers, AID India, our community partner, provides accessible education across 647 villages in Tamil Nadu, relying on online educational content to ensure consistent, high-quality teaching. However, around 50 of these villages are remote, with little or no internet connectivity. Because classes currently stream video to several devices at once, poor bandwidth makes the content slow to load: kids get impatient when a video stalls, and many eventually give up.

      Each center hosts around 40 children, each using a mobile device or "thin client", so the solution needs to serve video to roughly 40 devices at once. AID India curates the relevant content the week before it is used. Since these villages cannot provide enough bandwidth for 40 concurrent downloads, a remote solution is not practical, which rules out streaming services such as YouTube.
    details: |
      To serve all 40 clients in a village, a computing node local to the village hosts and caches the video content. We call it the LEAP Node. During lectures, this small single-board computer serves content directly to the classroom, so no internet connection is needed. The system automatically fetches each week's content ahead of time and is centrally managed by AID India. The project contributes to SDG #4 – Quality Education by improving access to digital learning opportunities and supporting inclusive, quality education in underserved rural communities.
    link:
      url: "https://github.com/T4EQ/leap"
      label: "View on GitHub"
    article:
      url: "https://www.raspberrypi.com/news/leap-low-bandwidth-educational-access-platform/"
      label: "Read the feature on Raspberry Pi"
    image: "/images/projects_leap.png"


  - name: "WildinSync – LENS "
    subtitle: "Local eDNA Navigation System"
    community: "WildinSync led by ETH Zürich and WWF USA"
    year: "2026"
    description: |    
      Biodiversity tracking is vital for protecting ecosystems, monitoring climate impacts, detecting invasive species, and guiding less destructive infrastructure development. To support these decisions, we partner with WildinSync, a non-profit initiative led by ETH Zurich and WWF USA, which combines environmental DNA (eDNA), genetic traces left by living organisms in water, soil, or air, with satellite imagery to monitor biodiversity across landscapes.

      Despite existing global eDNA platforms, local conservation partners often lack easy access to processed insights while retaining ownership of their data. They need tools to explore regional findings without navigating raw scientific datasets or relying on centralized systems. These needs are compounded by remote locations, limited internet connectivity, and constrained hardware budgets, making large global databases difficult to access and manage.
    details: |
      Within this partnership, T4EQ is developing an open-source Local eDNA Navigation System (LENS) that prioritizes local data access and ownership. It utlizes pre-processed, region-specific datasets served directly from WildinSync’s ETH server, with affordable local hardware setups designed for remote areas with limited infrastructure.

      LENS features an interactive visualization platform combining yearly GIS layers with eDNA sampling points across river, coastal, and mountain catchments. By providing indicators of ecosystem health, eDNA supports making informed conservation decisions. Users can filter data by taxa or species, explore map layers, generate summary graphs and export data, while an integrated dashboard visualizes climate and water risks to support environmental monitoring and sustainable management.  
      The project contributes to SDG #15 – Life on Land and SDG #14 – Life Below Water by supporting biodiversity monitoring and ecosystem conservation.
    link:
      url: "https://github.com/T4EQ"
      label: "View on GitHub"
    article:
      url: "https://wildinsync.org/"
      label: "Visit WildinSync initiative"
    image: "/images/projects_wildinsync.png"

  - name: "Solar Lighting for Rural Classrooms"
    community: "AID India, Tamil Nadu, India"
    year: "2025"
    description: "Many rural classrooms sit completely off the electricity grid. This leaves a typical 30 m² classroom of about 40 students without the reliable lighting they need to read, write, and learn once daylight fades. While individual solar desk lamps are easy to find, there is a major gap in ready-made solar systems designed for classroom ceilings. This effectively caps the school day to daylight hours and shuts out evening study, adult literacy classes, and community events – holding back education in the very places that can least afford the lost time."
    details: "To break through these constraints, we designed a tailored classroom solar lighting system. We mapped out the technical architecture and delivered the complete specifications alongside a detailed parts list. True to our mission, the entire system is engineered for local sourcing to ensure straightforward maintenance and long-term community ownership. Our partner, AID India, is now spearheading the local implementation on the ground. The project contributes to SDG #4 by improving access to safe, well-lit learning environments and enabling extended study hours in underserved rural communities.
"
    image: ""

services_title: "Our Services"
services_intro: "To turn our mission into impact, we leverage a multidisciplinary skillset spanning embedded and software engineering, security engineering, and hardware development (electrical, mechanical, and optical), bridging complex engineering and community-led change through our core services."

cta_text: "Have a challenge technology could help solve? Tell us about it."
cta_image: "/images/backgrounds/projects_cta.jpg"
---
