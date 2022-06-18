# Build Guide for P1YUSH-1 

## Status

**NTP**: Off  
**Firewall**: On  
**Updates**: Off  
**ICMP**: On  
**IPv6**: Off  
**AV or Security**: Off

## Overview

**OS**: Ubuntu 22.04 SERVER  
**OS DOWNLOAD DIRECT LINK**:https://releases.ubuntu.com/22.04/ubuntu-22.04-live-server-amd64.iso
**Hostname**: P1YUSH-1  
**Vulnerability 1**: LFI Leads To log poisoning.
**Vulnerability 2**: Abusable Sudo Permission For All Intended Users.
**Admin Username**: root  
**Admin Password**: P1yushHasAV@lidR00t  
**Low Priv Username**: piyush
**Low Priv Password**: PiyushHasAV@lidU$er
**Location of local.txt**: /home/piyush/local.txt  
**Value of local.txt**: 1316bf5401c3ea33de8805916116254e
**Location of proof.txt**: /root/proof.txt  
**Value of proof.txt**: 41bab9633a20cd4a82ab4fd3f8703b59

## Required Settings

**CPU**: 1 CPU  
**Memory**: 1GB  
**Disk**: 10GB

## Build Guide

1. Install Ubuntu 22.04 LTS
2. Enable network connectivity
3. Ensure machine is fully updated by running `apt upgrade`
4. Upload the following files to `/root`
    - `build.sh`
    - `web_files.zip`
5. Change to `/root` and run `build.sh`


