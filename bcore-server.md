# Bcore Server Roadmap

## Overview
In addition to performing custom omics analysis, some important functions of the Bioinformatics Core are:

1. Serve data and analysis to clients in a secure, accessibly way.
1. Create robust, reusable software pipeline sna tools that we can use and share with the community.
1. Support the computational community on campus by creating informational resources.
1. Support the computational community on campus with software development and collaboration tools such as code version 
   control, issue tracking and chat.

In order to perform these functions at a high level, B-Core needs to be able to store data, process it, 
and serve it over the web. It also needs the internal ability to use best practices for software development 
such as version control.

These needs can be best served by having access to a number of servers including web servers and file servers.

## Services
The B-Core plans to use the following tools and services:

1. **Client portal**: Individual clients can log into secure, private spaces where they can upload and retrieve data, view analysis results, and explore their own data.

1. **Version Control GUI Application**: GitHub like application to store and distribute versioned code, track issues and exchange comments.

1. **Community Wiki**: A communally editable wiki with information on various topics of interest to the OHSU computational community.

1. **Chat/messaging**: A system where programmers can easily discuss issues related to software projects including rendering software code in 
   a way that makes sense to programmers. It should include fine-grained permissions, groups and channels.

1. **Raw data storage**: Storage of terabytes of data for use in analysis. For example, annotation databases.

1. **Computational Resources**: Withstand a moderate load of computational demands for scientific analysis.

## Technologies
The B-Core has selected the following technologies to provide these services:

| Service | Technology | Reason |
|---|---|---|
| Client Portal | LabKey (+ R-Shiny, Jupyter notebooks, etc.)| Open source. Has most capabilities builtin. Used at OHSU already. Exhisting in-house developer resources. |
| Version Control GUI | GitLab | Best FOSS analog to GitHub. In use elsewhere at OHSU. |
| Chat/Messaging | Mattermost | Best FOSS analog to slack. Aligns well with GitLab. |
| Community Wiki | GitLab or LabKey or ?? | GitLab has a builtin wiki engine analagous to that used by GitHub (where ours is currently stored. LabKey also has wiki capabilities. Other options may be considered. |
| Raw Data Storage | Linux File Server | It is not yet clear whether we need a dedicated file server, or simply RAID storage attached to one of our VMs. |
| Computational Resources | Linux OS with at least 24GB RAM, 16 cores and 10 TB disk | Heavy computation and lengthy jobs should be run on Exacloud. However, moderate jobs can be run interactively on our local machine. This can be enhanced by using RStudio Server and VNC sessions for interactive graphics. Additionally running STARTapp.|

## Architecture
The best way to support the combined use of these technologies would be with a system consisting of at least 4 independent operating systems distributed across multiple virtual and physical as follows:

| Server | Minimum Specs | Container | HTTP(S) ports | Notes | 
|---|---|---|---|---|
| Client Portal | 8GB RAM, 2 cores, 10TB+ disk | virtual or physical (preferred) | Yes | On individual machine for stability--maintain uptime. Not clear volume of client data. |
| Version Control | 4GB RAM, 1 core, 2TB disk | virtual | Yes | Clobbers other web apps so needs own machine. But not heavy demands. Code pushed and pulled in small increments. |
| Chat/Messaging | 16 GB RAM, 4 cores, 10TB disk | physical | Yes | Rough estimate can store chat records for 100 people for 10 years. Needs beefy resources to handle traffic. |
| Computational Resources | Linux OS with at least 24GB RAM, 16 cores and 10 TB disk | physical | Maybe | Free to compute. |
| Misc. (User home directories, private code repositories, wiki, ...) | 4GB RAM, 2 cores, 2TB disk | virtual | Yes | Utility, and misc. web apps.|

## Milestones
In order of priority:

* [X] LabKey client portal up and running under `bcore.ohsu.edu/labkey`.
  - [ ] LDAP Authentication for within OHSU
  - [ ] Connected to computational engines
    - [X] R
    - [ ] Python
  - [ ] JBrowse module functioning
* [X] GitLab Server running on `bcore.ohsu.edu/gitlab`
  - [ ] Authentication? LDAP? Personal account?
  - [X] May serve wiki
* [ ] Misc. Server 
  - [ ] LDAP Authentication
  - [ ] Create all appropriate users and groups with correct permissions/umasks for other services such as GIT. 
  - [ ] Scientific software libraries through the Anaconda package management system.
* [ ] Chat/messaging
  - [ ] Mattermost
  - [ ] LDAP Authentication
* [ ] Computational Resource
  - [ ] Assess need and use cases
