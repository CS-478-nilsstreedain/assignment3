# assignment3
## Learning Objective:

Analyze packet captures

Write software to find vulnerabilities

## Setup:

For this Assignment, you will be generating or finding packet captures with particular traffic.   If you're generating your own traffic, you may need to create a few services to do so (like a telnet server and a ftp server to name a few).  Since both of those protocols are insecure, I'd recommend doing that on your Kali device.  If you're finding packet capture traffic, make sure you are getting your captures from a reliable source (and probably run the file through a virus scanner just in case).  If possible, I highly recommend looking at "found" captures on your Kali instance just in-case!  You may do this exercise in any programming language you want and you may use any APIs or other libraries you would like to use.  [Just make sure to document which APIs and libraries you used so we can build and test your code!]  I personally recommend using pyshark. 

Pyshark is an API based on Wireshark and is highly useful.  It is NOT standard to Kali Linux, but can be installed with pip install pyshark [note that you may need to use sudo]. 

You can access the data and metadata of each layer by using the layer name as an attribute of the packet object. For example, packet.ip will return the IP layer object of the packet, which has its own attributes and methods, such as packet.ip.src, packet.ip.dst, packet.ip.version, etc. You can also use indexing to access a specific layer by its position in the packet. For example, packet[0] will return the first layer of the packet, which is usually the Ethernet layer.

You can also use the get_field() and get_field_value() methods to access any field of any layer by its name. For example, packet.get_field('tcp.port') will return a field object that represents the TCP port field of the packet, which has attributes such as name, showname, value, etc. You can also use packet.get_field_value('tcp.port') to directly get the value of the field as a string.

For those interested in using pyshark, here is a sample program which identifies the highest protocol layer in each packet and creates a list of those protocols --> listProtocols.py Download listProtocols.py

## Instructions:

You mission this week is use the packet capture data do be able to create a rudimentary vulnerability scanner.  Note that this vulnerability scanner is NOT supposed to be perfect, general purpose, or fully featured.  Rather, this scanner is intended as proof-of-concept which you could expand at your leisure to perform other types of scans.  This vulnerability scanner must utilize packet capture data as it's only input (no pinging the network or making other connections).  The goal here is to have your software be something which only needs packet capture data to help find possible network vulnerabilities.  This allows the software to be completely passive (and may even operate air-gapped from the rest of the network) and thus undetectable as only captures are needed.

All write-up prompts should assume that your audience is the organization who hired you to perform the penetration test.  This means that your responses should be understandable by someone who may not be a technical person (think manager) and should also include enough technical depth for your response to be useful to the client's technical team(s).  The standard best-practice is to provide sections for "Executive Briefings" to summarize at a high level and "Technical Briefings" for the more in-depth technical discussion.

## Task 1: Protocol Scanner

Write code to determine if known insecure protocols are being using within in your network.  For our purposes, this list should include AT LEAST: ftp, telnet, and ssl.  

**Suggestions:** 
- Create or find a packet capture which will have traffic with at least 1 of the above protocols so you can use that packet capture for testing against.  You may need to do some independent research to figure out the best way to generate this traffic.  Feel free to share packet generation techniques with your classmates on ED and/or Teams!  (If you're having trouble creating traffic of your own to capture OR finding existing packet captures here is a clean telnet capture start with telnet.cap Download telnet.cap.
- If you're using pyshark, my sample code in the instructions might be a good place to start.

## Task 2:  Port Matching

Add a feature to check if common ports are being used by the correct/matching protocols.  For our purposes, you should check AT LEAST:
- is 22 being used for anything other ssh?
- is 80 being used for anything other than http?
- is 53 being used for anything other than dns?

## Task 3:  Look For Vulnerable Protocol Versions

Add a feature to check for vulnerable versions of a protocol.  For the purposes of this assignment, you should AT LEAST identify if TLS versions 1.0 or 1.1 are being used (TLS 1.2 and TLS 1.3 are both currently considered secure and should not be flagged). 

For reference, the TLS version codes are:
- TLS 1.0: 0x0301
- TLS 1.1: 0x0302
- TLS 1.2: 0x0303
- TLS 1.3: 0x0304

The version codes are used by the tls field version.  (tls is a field in any packet which is a TLS packet.)

## Task 4:  Feature or Enhancement of Your Choice

Add code for either a new Feature or an Enhancement of an existing Feature:

**New Feature Option Requirements:**
- Must only use network information from the packet capture
- Must provide a clear benefit to a Security Engineer
- Must be able to explain why the network vulnerability detected IS actually indicative of a network vulnerability

**Enhancement Option Requirements:**
- Must expand the capabilities of an existing feature in a more in-depth or detailed direction.  Simply adding the ability to detect more known vulnerable protocols, more port/protocol combinations, or more version checked protocols would NOT be sufficient.  
- Must only use network information from the packet capture
- Must provide a clear benefit to a Security Engineer beyond the existing feature capability 
- Must be able to explain why the network vulnerability detected IS actually indicative of a network vulnerability

## Write-up Prompts

**Write-up prompts:**
- What language(s), libraries, API(s), etc. did you use?  Why did you select those tools?
- How did you develop your plan of attack to write this code?  Take me through your thought/design process!  (This does NOT need to be formal.)
- What did you find the most challenging and why?
- What was the easiest part?  Why?
- What other port number and protocol combinations would you want to make sure to check/verify in a production environment?  Why would the combinations you selected be important? [Should have 10 common specific protocol/port combinations noted/listed.  And at least 4 of those protocols should be justified for why they are on the list.]
- How might this kind of vulnerability scanner be used by both a Security Engineer and a hacker? (Explain both perspectives to get full points)
- How might this vulnerability scanner be used in conjunction with the port scanning tools we covered last week?  Why would this be desirable?
- With regard to your new Feature or Enhancement:
  - What did you decide to do?
  - How does your Feature/Enhancement provide additional benefit to a Security Engineer
  - How do you know that your new Feature/Enhancement actually detects new network vulnerabilities

## Grading Guidelines/Rubric:

**Task Applications:**

### Assignment Rubric

| | A – Level | B – Level | C – Level |
|---|---|---|---|
| **Task #1** | Was able to correctly detect known insecure protocols without false positives.  Specifically including AT LEAST: ftp, telnet, and ssl. | Was able to correctly detect known insecure protocols without false positives.  Specifically including AT LEAST 2 of the required protocols: ftp, telnet, and ssl. | Was able to detect known insecure protocols without false positives.  Specifically including AT LEAST 1 of the required protocols: ftp, telnet, and ssl. |
| **Task #2** | Was able to correctly detect when a common port number was being used for a protocol OTHER than its normal protocol without false positives.  Specifically including AT LEAST: 22/ssh, 80/http, and 53/dns. | Was able to correctly detect when a common port number was being used for a protocol OTHER than its normal protocol without false positives.  Specifically including AT LEAST 2 of the required ports: 22/ssh, 80/http, and 53/dns. | Was able to correctly detect when a common port number was being used for a protocol OTHER than its normal protocol without false positives.  Specifically including AT LEAST 1 of the required ports: 22/ssh, 80/http, and 53/dns. |
| **Task #3** | Was able to correctly detect when an insecure/vulnerable version of a protocol was being used without generating false positives.  Specifically including AT LEAST TLS 1.0 and TLS 1.1 (while not flagging either TLS 1.2 or TLS 1.3). | Was able to correctly detect when an insecure/vulnerable version of a protocol was being used without generating false positives.  Specifically including AT LEAST 1 of TLS 1.0 and TLS 1.1 (while not flagging either TLS 1.2 or TLS 1.3). | Was able to correctly detect when an insecure/vulnerable version of a protocol was being used without generating false positives for TLS 1.2.  Specifically including AT LEAST 1 of TLS 1.0 and TLS 1.1 (while not flagging TLS 1.2). |
| **Task #4** | Was able to identify a worthwhile Feature or Enhancement to add to the vulnerability scanner.  AND was able to correctly implement a proof-of-concept demonstrating how that Feature or Enhancement works without generating false positives. | Was able to identify a worthwhile Feature or Enhancement to add to the vulnerability scanner.  AND was able to correctly implement a mostly functional proof-of-concept demonstrating how that Feature or Enhancement works without generating false positives. | Was able to identify a worthwhile Feature or Enhancement to add to the vulnerability scanner.  AND was able to correctly implement a well documented code outline for the proof-of-concept demonstrating how that Feature or Enhancement works without generating false positives. |

**Write-up Evaluations:**

Note on Technical Briefings and Executive Summary:  Starting with this assignment, we will be deducting up to 10 points if you don't have your Write-up separated into the Technical Briefing and an Executive Summary.

IMPORTANT NOTE:  For maximum points, make sure to format your write-up in a professional manner.  This means proper grammar, spelling, and use of headings.  As this is a 400/500 level course, those items are not specifically included in the rubric, but ARE expected of you in order to receive full credit.

### Evaluation Rubric

| | A – Level | B – Level | C – Level |
|---|---|---|---|
| **Prompt #1** | Noted all languages, libraries, APIs, and any other tools used. Provided a justification/explanation for each tool's inclusion/use. Included and Discussed at least 1 outside reference/link as part of the response. | Noted all languages, libraries, APIs, and any other tools used. Provided a justification/explanation for most of the tool's inclusion/use. Included and Discussed at least 1 outside reference/link as part of the response. | Noted all languages, libraries, APIs, and any other tools used. Provided a justification/explanation for most of the tool's inclusion/use. Included, but did not Discuss, at least 1 outside reference/link as part of the response. |
| **Prompt #2** | Described their thought process; detailing their design, plan of attack, and any course-corrections via a coherent narrative. | Described their thought process; detailing their design, plan of attack, and any course-corrections via a mostly coherent narrative. | Described their thought process; but did not go into detail regarding their design, plan of attack, and any course-corrections via a mostly coherent narrative. |
| **Prompt #3** | Indicated the part of the assignment they found most challenging. Explained why they found the indicated portion challenging in a way which demonstrated authentic reflection. | Indicated the part of the assignment they found most challenging. Explained why they found the indicated portion challenging in a way which demonstrated some level of reflection. | Indicated the part of the assignment they found most challenging. Explained why they found the indicated portion challenging in a way which did not demonstrate some level of reflection. |
| **Prompt #4** | Indicated the part of the assignment they found easiest. Explained why they found the indicated portion challenging in a way which demonstrated authentic reflection. | Indicated the part of the assignment they found easiest. Explained why they found the indicated portion challenging in a way which demonstrated some level of reflection. | Indicated the part of the assignment they found easist. Explained why they found the indicated portion challenging in a way which did not demonstrate some level of reflection. |
| **Prompt #5** | Identified AT LEAST 10 other important port numbers to check AND indicated which protocol SHOULD be associated with each port. Logically justified the inclusion of AT LEAST 4 of the port/protocol combinations. Included and Discussed at least 1 outside reference/link as part of their justifications. | Identified AT LEAST 7 other important port numbers to check AND indicated which protocol SHOULD be associated with each port. Logically justified the inclusion of AT LEAST 3 of the port/protocol combinations. Included and Discussed at least 1 outside reference/link as part of their justifications. | Identified AT LEAST 5 other important port numbers to check AND indicated which protocol SHOULD be associated with each port. Logically justified the inclusion of AT LEAST 2 of the port/protocol combinations. Included at least 1 outside reference/link as part of their justifications. |
| **Prompt #6** | Explained the value of this kind of vulnerability scanner from BOTH the perspective of a Security Engineer and a Hacker. Included and Discussed at least 1 outside reference/link as part of their discussion. | Explained the value of this kind of vulnerability scanner from BOTH the perspective of a Security Engineer and a Hacker. Included at least 1 outside reference/link as part of their discussion. | Explained the value of this kind of vulnerability scanner from EITHER the perspective of a Security Engineer or a Hacker. Included at least 1 outside reference/link as part of their discussion. |
| **Prompt #7** | Full coherently conjectured how this vulnerability scanner might be utilized in conjunction with the port scanning tools from Week 2. Logically explained why such utilization might be desirable. Included and Discussed at least 1 outside reference/link as part of their discussion. | Full coherently conjectured how this vulnerability scanner might be utilized in conjunction with the port scanning tools from Week 2. Logically explained why such utilization might be desirable. Included at least 1 outside reference/link as part of their discussion. | Mostly coherently conjectured how this vulnerability scanner might be utilized in conjunction with the port scanning tools from Week 2. Logically explained why such utilization might be desirable. Included at least 1 outside reference/link as part of their discussion. |
| **Prompt #8** | Identified and explained what their new Feature or Enhancement is/does. Fully explained in a logical and coherent way how their Feature/Enhancement provides additional benefit to a Security Engineer. Explained how they were able to determine that their Feature/Enhancement will actually be detecting network vulnerabilities. Included and Discussed at least 1 outside reference/link as part of their response. | Identified and explained what their new Feature or Enhancement is/does. Fully explained in a logical and coherent way how their Feature/Enhancement provides additional benefit to a Security Engineer. Explained how they were able to determine that their Feature/Enhancement will actually be detecting network vulnerabilities. Included at least 1 outside reference/link as part of their response. | Identified and explained what their new Feature or Enhancement is/does. Fully explained in a logical and coherent way how their Feature/Enhancement provides additional benefit to a Security Engineer. Included at least 1 outside reference/link as part of their response. |

## Deliverables:

A compressed folder (remember, the folder's name should be your username!) containing:

- Your source code and any documentation we would need to build your software from the source code.
- A PDF containing your answers to the write-up prompts
