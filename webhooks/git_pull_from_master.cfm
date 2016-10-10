<!--- Github Webhook script.  I run after a "git push" happens on Master. I deploy those changes to the various web servers. --->

<cfscript>
    public string function makebashFriendlyPath(p) {
        return "/#replace(replace(arguments.p, "\", "/", "all"), ":", "", "all")#";
    }   
</cfscript>

<!--- path to git.exe is the same for Dev,Prod1 and Prod2 servers. path to git.exe binary may be different for other servers (like Nolan's dev laptop) --->
<cfswitch expression="#cgi.server_name#">
	
	<cfcase value="metrofamilylaunchpad.dev">
		<cfset strPathToGitBinary = "C:\Program Files (x86)\Git\bin\git.exe" />
	</cfcase>
	
	<!--- Dev1,Prod1 and Prod2 servers. TODO: get actual values for cgi.server_name for these boxes --->
	<cfdefaultcase>
        <cfset strPathToGitBinary = "C:\Program Files\Git\bin\git.exe" />		
	</cfdefaultcase>
	
</cfswitch>

<cfset pathToRepo = makebashFriendlyPath( expandPath( "../" ) ) />

<cfset homeDirectory = "/c/Users/Administrator" />

<cfset gitArguments = '-c "HOME=#homeDirectory#;cd #pathToRepo#;git pull origin 2>&1;"' />

<cfexecute name="#strPathToGitBinary#" arguments="#gitArguments#" timeout="120" variable="rsltGitCommand" />

<cfdump var="#rsltGitCommand#" />


