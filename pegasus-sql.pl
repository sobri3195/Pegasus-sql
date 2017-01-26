#!/usr/bin/perl --
=for comment

      *-----------------------------------------------------------*	 
      |                                                           |
      |      Pegasus-sql                                          |
      |      dr. Muhammad Sobri Maulana                           |
      |      Version 1.8                                          |
      |                                                           |
      *-----------------------------------------------------------*
=cut

use LWP::UserAgent;
use HTTP::Request;
use Term::ANSIColor qw(:constants);

#-----------------------------------------------------------#
#      Help menu                                            #
#-----------------------------------------------------------#

sub help
{
     system('clear');
     print title;
     print BOLD,"\n For pentesting and educational purposes only\n",RESET;

     print BLUE, "\n[!] Usage   : $0 <option>\n";
     print GREEN, "-----------------------------------";
     print BOLD, GREEN, "\n--|| Options\n\n", RESET;
     print GREEN,BOLD,"     -d           Dorking function (dh)\n";
     print "     -c           See dork list (press Q to quit)\n",RESET,GREEN;
     print "     -p           Define a proxy to use (ph)\n";
     print "     -o           Save result in a file\n";
     print "     -h           Print this help manual\n";
     print "     -r           Change log, description & term\n";
     print "     -dh          Print dork manual\n";
     print "     -ph          Print proxy manual\n";
     print "     -u           Update to latest version\n";
     print "-----------------------------------\n\n", RESET;
     exit();
}

sub title
{
    print "\n This program comes with ABSOLUTELY NO WARRANTY\n";
    print " This is free scriot and you are welcome to\n";
    print " redistribute it under certain conditions of GPL 3.0\n";
}

sub readme
{
	system('clear');
     print BOLD;
     print q(
    This program is free software: you can redistribute it and/or modify 
    it under the terms of the GNU General Public License as published by 
    the Free Software Foundation, either version 3 of the License, or    
    at your option any later version.                                  
                                                                          
    This program is distributed in the hope that it will be useful,      
    but WITHOUT ANY WARRANTY; without even the implied warranty of       
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        
    GNU General Public License for more details.                         
                                                                          
    You should have received a copy of the GNU General Public License    
    along with this program.  If not, see http://www.gnu.org/licenses/);
     print "\n";
     print RESET;
	print GREEN, "\n\n    -----------------------------------\n";
	print BOLD,GREEN,"    Pegasus-sql ",YELLOW,"1.8a\n",RESET;
	print GREEN,"    This program is distributed under GNU GPL 3.0\n",RESET;
	print BLUE,"    http://pastebin.com/NdVZ5HVX\n",RESET;
	print GREEN, "    -----------------------------------\n\n";
	print GREEN,"  Changes on 1.8a:\n\n",RESET;
	print BLUE,BOLD,"     - Hot fix for search engine's regex\n";
	print BLUE,BOLD,"     - Added more error types\n",RESET;
	print BLUE,"\n $0 -h\n\n",RESET;
	exit();
}

sub dorkhelp
{
	system('clear');
	print title;
	print BOLD,"\n For pentesting and educational purposes only\n",RESET;
	print     BOLD,"\n\n[!] Info [!]\n\n",RESET;
	print     YELLOW " inurl:",GREEN,"    <- indicates Query in URL\n",RESET;
	print     YELLOW," intitle:",GREEN,"  <- indicates Query in Title\n",RESET;
	print     YELLOW," intext:",GREEN,"   <- indicates Query in File Content\n",RESET;
	print     YELLOW," related:",GREEN,"  <- Related Query Content\n",RESET;
	print     YELLOW," site:",GREEN,"     <- indicates URL Domain\n",RESET;
	print     YELLOW," filetype:",GREEN," <- indicate File Type\n",RESET;
	print     YELLOW," ext:",GREEN,"      <- Similar to filetype\n",RESET;
	print     YELLOW," all",GREEN,"       <- Sub-query 'all' works only like 'allinurl','allintitle','allrelated' and 'allintext'\n",RESET;
	print     YELLOW," *",GREEN,"         <- Wildcard\n",RESET;
	print     YELLOW," \"\"",GREEN,"        <- Matches Entire Query\n",RESET;
	print     YELLOW," ()",GREEN,"        <- Brackets for Boolean operators (See Below)\n",RESET;
	print     YELLOW," |",GREEN,"         <- OR (Use only in brackets with queries like 'inurl', 'intitle','filetype' or 'related'\n",RESET;
	print     YELLOW," &",GREEN,"         <- AND (Use only in brackets with a query)\n",RESET;
	print     YELLOW," +",GREEN,"         <- spacing (I'll fix this in next version so u can add actual space)\n\n",RESET;
	print     BOLD,"[!] Basic [!]\n\n",RESET;
	print     YELLOW," php?id\n",GREEN," -- Dorks for any PHP ext with param of 'id'\n",CYAN," Since we didn't indicate the exact query, it will get contents from anywhere (Doesn't need to be in URL)\n\n";
	print     YELLOW," inurl:php?id\n",GREEN," -- Dorks for PHP ext with param of 'id' only from URL\n",CYAN," See the difference?\n\n";	
	print     YELLOW," intitle:php?id\n",GREEN," -- Dorks for text 'php?id' in the title\n\n";
	print     YELLOW," site:gov+inurl:php?id\n",GREEN," -- Dorks top-lvl domain 'gov' with PHP ext and 'id' param only from URL\n\n";
	print     YELLOW," site:google.ca\n",GREEN," -- Dorks domain 'google.ca' only from URL\n\n";
	print     YELLOW," site:.google.ca\n",GREEN," -- Dorks ANY sub-domain(s) of 'google.ca' only from URL\n",CYAN," See the difference between a dot?\n\n";
	print     YELLOW," site:play.google.ca\n",GREEN," -- Dorks specifically sub-domain 'play.google.ca' only from URL\n\n";
	print     YELLOW," (asp|aspx)?id=\n",GREEN," -- Dorks URL ext 'asp' OR 'aspx' with 'id' param\n",CYAN," ONLY works inside",RED,BOLD," '' ",RESET,CYAN,"or",RED,BOLD," \"\"",RESET,CYAN,"\n Ex: $0 -d ",BOLD,"'(index|forum|cart).php?id='\n\n",RESET;
	print     YELLOW," cute+AND+nice+inurl:php?cat=\n",GREEN," -- Dorks for both words 'cute' & 'nice' and PHP ext with 'cat' param only from URL\n\n";
	print     YELLOW," (cart|forum)*?id=\n",GREEN," -- Dorks for sub-queries 'cart' or 'forum' in ANY available query (could be ext & vice versa) with 'id' param\n",CYAN," The * indicate any available result\n\n";
	print     YELLOW," php?(id|cat)=\n",GREEN," -- Dorks for PHP ext with param of 'id' or 'cat'\n\n";
	print     YELLOW," (asp|php)?(id|cat)=\n",GREEN," -- Dorks for PHP or ASP exts with param of 'id' or 'cat'\n\n",RESET;
	print     BOLD,"[!] Advanced [!]\n\n",RESET;
	print     YELLOW," inurl:\"wp-download.php?dl_id=\"\n",GREEN," -- SQLi Vuln CVE 2008-1646\n\n",RESET;
	print     YELLOW," allinurl:(asp|aspx|php)?(id=|q=)&*+site:mil\n",GREEN," -- Search for 'asp','aspx' OR 'php' with param 'id' OR 'q' AND any other param with top-lvl domain 'mil'\n\n",RESET;
	print     YELLOW," \"you have an error in your sql syntax\"+php?id=\n",GREEN," -- Precisely dorks for MySQLi vuln with PHP ext and 'id' param\n\n",RESET;
	print CYAN,"[=] For some reasons queries like inurl or intitle don't work inside single/double quotes, so avoid using them (this will be fixed in next 2-3 version)\n";
	print 		  "[=] ALWAYS use single/double quotes for queries which have () | & and/or \"\"\n";
	print 		  "[=] For long query string, avoid using inurl/intext/intitle/related (see 1st reason)\n";
	print 		  "[=] Play around with queries. Do not give up if it doesn't show. Remember! Tries different query if ones don't work!\n";
	print 		  "[=] Check out ",UNDERLINE,"http://www.exploit-db.com/google-dorks/",RESET,CYAN," for more special dorks! Or make your own specials!\n";
	print 		  "[=] If u still have question about query, email me at ",UNDERLINE,"madfedora\@protomail.ch\n",RESET;
	print BLUE,"\n$0 -h\n\n",RESET;
	exit();
}

sub proxyhelp
{
	system('clear');
	print title;
	print GREEN,"\n[?] Example: ./Pegasus-sql -p ",BOLD,"http://127.0.0.1:9050/\n";
	print "[!] To install TOR: $0 -t\n",RESET;
	print BLUE,"$0 -h\n\n",RESET;
	exit();
}

sub update
{
	system('clear');
	
	print title;
	print BOLD,"\n For pentesting and educational purposes only\n",RESET;
	print GREEN,"\n[!] Updating...\n";
	system('wget http://pastebin.com/raw.php?i=NdVZ5HVX -r -O ./Pegasus-sql && ls -l Pegasus-sql ; chmod u+x ./Pegasus-sql ; dos2unix ./Pegasus-sql');
        print BOLD,"";
	system('echo "For what changed run: ./Pegasus-sql -r"');
        print "\n",RESET;
	exit();
}

sub tor
{
	system('clear');
	
	print title;
	print GREEN,BOLD,"\n[!] You're installing TOR\n[!] Please enter your permission password to proceed if being prompted\n",YELLOW,"[!] Press Ctrl C to exit\n",RESET;
	system('sudo apt-get install tor || sudo yum install tor && service tor start');
	print YELLOW"If TOR didn't start automaticall, please start run 'tor' command in different terminal.",RESET;
	print BLUE,BOLD"\nTo use: $0 -d <input> -p http://127.0.0.1:9050/\n",RESET;
	exit();
}

sub conte
{
	system('w3m -dump http://pastebin.com/raw.php?i=UVcmJQQz|less');
}

sub variables
{
	my $i=0;
	foreach (@ARGV)
	{
        if ($ARGV[$i] eq "-d"){$search_dork = $ARGV[$i+1]}
        if ($ARGV[$i] eq "-o"){$vulnf = $ARGV[$i+1]}
        if ($ARGV[$i] eq "-p"){$proxy = $ARGV[$i+1]}
	if ($ARGV[$i] eq "-h"){&help}
	if ($ARGV[$i] eq "-r"){&readme}
	if ($ARGV[$i] eq "-dh"){&dorkhelp}
	if ($ARGV[$i] eq "-ph"){&proxyhelp}
	if ($ARGV[$i] eq "-u"){&update}
	if ($ARGV[$i] eq "-t"){&tor}
	if ($ARGV[$i] eq "-c"){&conte}
        $i++;
	}
}


sub main
{
	system('clear');
	
	print title;
	print BOLD,"\n For pentesting and educational purposes only\n",RESET;
	print GREEN, " \n--------------------------------------\n";
	print BOLD," \n    Pegasus-sql ",YELLOW,"1.8a\n",RESET;
	print BLUE,"       sobri3195\@gmail.com\n",RESET;
	print GREEN," \n--------------------------------------\n\n",RESET;
	if (@ARGV+1){print GREEN,"[?] For Help : ",BOLD,"$0 -h\n\n",RESET;}
}

sub vulnscanner
{
     checksearch();
     search1($search_dork);
     search2($search_dork);
}
sub checksearch
{
	my $request   = HTTP::Request->new(GET => "http://www.ask.com/web?q=$search_dork&page=1");
	my $useragent = LWP::UserAgent->new(agent => 'Mozilla/5.0 (Windows; U; Windows NT 6.1) AppleWebKit/531.7.2 (KHTML, like Gecko) Version/5.1 Safari/531.7.2');
	$useragent->proxy("http", "http://$proxy/") if defined($proxy);
	my $response  = $useragent->request($request) ;
	my $result    = $response->content;
}         

sub search1
{
     my $dork  = $_[0];
     for ($i=1;$i<10;$i=$i+1)
     {
	my $request   = HTTP::Request->new(GET => "http://www.ask.com/web?q=$dork&page=$i");
        my $useragent = LWP::UserAgent->new(agent => 'Mozilla/5.0 (Windows; U; Windows NT 6.1) AppleWebKit/531.7.2 (KHTML, like Gecko) Version/5.1 Safari/531.7.2');
        $useragent->proxy("http", "http://$proxy/") if defined($proxy);
        my $response  = $useragent->request($request) ;
        my $result    = $response->content;
	while ($result =~ m/<a class="web-result-title-link\" href=\"(.*?)\" onmousedown=\"uaction/g)
         {
             print BLUE, "[!] Scanning > $1\n", RESET;     
             checkvuln($1)
         }
     }                  
}
sub search2
{
     my $dork  = $_[0];
     for ($i=1;$i<50;$i++)
     {
	my $request   = HTTP::Request->new(GET => "http://www.bing.com/search?q=$dork&go=&filt=all&first=$i");
	my $useragent = LWP::UserAgent->new(agent => 'Mozilla/5.0 (Windows; U; Windows NT 6.1) AppleWebKit/531.7.2 (KHTML, like Gecko) Version/5.1 Safari/531.7.2');
        $useragent->proxy("http", "http://$proxy/") if defined($proxy);
        my $response  = $useragent->request($request) ;
        my $result    = $response->content;
	while ($result =~ m/class=\"b_algo\"><h2><a href=\"(.*?)\" h="\ID=SERP/g)
	{
        	my $dorkurl ="http://".$3 ;
        	print BLUE, "[!] Scanning > $dorkurl\n",RESET;
        	checkvuln($dorkurl);
        }
     }
}

sub checkvuln
{
     my $urlscan   = $_[0];
     my $link       = $urlscan.('\'');
     my $ua         = LWP::UserAgent->new();
     $ua->proxy("http", "http://$proxy/") if defined($proxy);
     my $req        = $ua->get($link);
     my $fz       = $req->content;
#-----------------------------------------------------------#
#      PHP MySQL                                            #
#-----------------------------------------------------------#
     if ($fz =~ m/mysql_num_rows/i)

     {
	print BOLD, GREEN, "[!] {MySQL} Num Row -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL Num Row] $urlscan\n");
         }
     }

     elsif ($fz =~ m/mysql_fetch_/i || $fz =~ m/mysql_fetch_array/i || $fz =~ m/FetchRow()/i|| $fz =~ m/GetArray()/i || $fz =~ m/FetchRow(.*)/i|| $fz =~ m/GetArray(.*)/i)
     {
         print BOLD, GREEN, "[!] {MySQL} Fetch -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
		push (@vuln1,"[MySQL Fetch] $urlscan\n");
         }
     }

     elsif ($fz =~ m/user_error(.*,E_USER_ERROR.*)/i || $fz =~ m/user_error(.*,E_USER_WARNING.*)/i|| $fz =~ m/trigger_error(.*,E_USER_ERROR.*)/i || $fz =~ m/trigger_error(.*,E_USER_WARNING.*)/i )
     {
         print BOLD, GREEN, "[!] {MySQL} User/Trigger Error -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
		push (@vuln1,"[MySQL User/Trigger Error] $urlscan\n");
         }
     }

     elsif ($fz =~ m/set_error_handler(.*)/i)
     {
         print BOLD, GREEN, "[!] {MySQL} Error Handler -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
		push (@vuln1,"[MySQL Error Handler] $urlscan\n");
         }
     }


#-----------------------------------------------------------#
#      MySQL                                                #
#-----------------------------------------------------------#

     elsif ($fz =~ m/Unexpected EOF found when reading file/i)
     {
         print BOLD, GREEN, "[!] {MySQL} 1039 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL 1039] $urlscan\n");
         }
     }

     elsif ($fz =~ m/Triggers cannot be created on system tables/i)
     {
         print BOLD, GREEN, "[!] {MySQL} 1465 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL 1465] $urlscan\n");
         }
     }
     elsif ($fz =~ m/Can't get working directory/i)
     {
         print BOLD, GREEN, "[!] {MySQL} 1015 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL 1015] $urlscan\n");
         }
     }
     elsif ($fz =~ m/You have an error in your SQL syntax/i || $fz =~ m/Query failed/i || $fz =~ m/SQL query failed/i)
     {
         print BOLD, GREEN, "[!] {MySQL} 1064 -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL 1064] $urlscan\n");
         }
     }
     elsif ($fz =~ m/The used SELECT statements have a different number of columns/i)
     {
         print BOLD, GREEN, "[!] {MySQL} 1222 -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL 1222] $urlscan\n");
         }
     }
	elsif ($fz =~ m/mysql_fetch_object()/i)
     {
         print BOLD, GREEN, "[!] {MySQL} mysql_fetch_object() -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL fetch_object] $urlscan\n");
         }
     }
	elsif ($fz =~ m/pg_connect()/i)
     {
         print BOLD, GREEN, "[!] {MySQL} pg_connect()  -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL pg_connect] $urlscan\n");
         }
     }
	elsif ($fz =~ m/SQL command not properly ended/i)
     {
         print BOLD, GREEN, "[!] {MySQL} command  -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL command] $urlscan\n");
         }
     }
	elsif ($fz =~ m/Warning: include/i)
     {
         print BOLD, GREEN, "[!] {MySQL} include  -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL include] $urlscan\n");
         }
     }
	elsif ($fz =~ m/Warning: main/i)
     {
         print BOLD, GREEN, "[!] {MySQL} main  -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL main] $urlscan\n");
         }
     }
	elsif ($fz =~ m/Warning: pg_exec/i)
     {
         print BOLD, GREEN, "[!] {MySQL} pg_exec  -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL pg_exec] $urlscan\n");
         }
     }
	elsif ($fz =~ m/Warning: ocifetchstatement/i)
     {
         print BOLD, GREEN, "[!] {MySQL} ocifetchstatement  -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln1,"[MySQL ocifetchstatement] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      MsSQL                                                #
#-----------------------------------------------------------#
     elsif ($fz =~ m/Microsoft OLE DB Provider for SQL Server/i || $fz =~ m/Unclosed quotation mark/i || $fz =~ m/OLE\/DB provider returned message/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} Microsoft OLE DB -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL OLEDB] $urlscan\n");
         }
     }

     elsif ($fz =~ m/ORDER BY items must appear in the select list if the statement contains a UNION operator/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 104 -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 104] $urlscan\n");
         }
     }

     elsif ($fz =~ m/The column prefix.*does not match with a table name or alias name used in the query/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 107 -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 107] $urlscan\n");
         }
     }

     elsif ($fz =~ m/The ORDER BY position number.*is out of range of the number of items in the select list/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 108 -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 108] $urlscan\n");
         }
     }
     elsif ($fz =~ m/There are more columns in the INSERT statement than values specified in the VALUES clause/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 109 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 109] $urlscan\n");
         }
     }

     elsif ($fz =~ m/There are fewer columns in the INSERT statement than values specified in the VALUES clause/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 110 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 110] $urlscan\n");
         }
     }

     elsif ($fz =~ m/Missing end comment mark '\*\/'/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 113 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 113] $urlscan\n");
         }
     }

     elsif ($fz =~ m/A GOTO statement references the label '.*' but the label has not been declared/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 133 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 133] $urlscan\n");
         }
     }

     elsif ($fz =~ m/Could not load sysprocedures entries for constraint ID.*in database ID/i)
     {
         print BOLD, GREEN, "[!] {MsSQL} 427 -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MsSQL 427] $urlscan\n");
         }
     }

#-----------------------------------------------------------#
#      Access                                               #
#-----------------------------------------------------------#
     elsif ($fz =~ m/ODBC SQL Server Driver/i || $fz =~ m/ODBC Microsoft Access Driver/i || $fz =~ m/OLE DB Provider for ODBC/i)
     {
         print BOLD, GREEN, "[!] {Access} Microsoft ODBC -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln3,"[ODBC] $urlscan\n");
         }
     }

     elsif ($fz =~ m/Microsoft JET Database/i)
     {
         print BOLD, GREEN, "[!] {Access} Microsoft JET -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln3,"[JET DB] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      ADO DB                                               #
#-----------------------------------------------------------#
	elsif ($fz =~ m/Invalid Querystring/i)
     {
         print BOLD, GREEN, "[!] {ADO DB} Invalid Querystring -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[ADO DB Query] $urlscan\n");
         }
     }
	elsif ($fz =~ m/ADODB.Field/i)
     {
         print BOLD, GREEN, "[!] {ADO DB} Field -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[ADO DB Field] $urlscan\n");
         }
     }
	elsif ($fz =~ m/ADODB.Command/i )
     {
         print BOLD, GREEN, "[!] {ADO DB} Command -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[ADO DB Command] $urlscan\n");
         }
     }
	elsif ($fz =~ m/BOF or EOF/i)
     {
         print BOLD, GREEN, "[!] {ADO DB} BOF or EOF -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[BOF or EOF] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      VBS Runtime (Minor)                                  #
#-----------------------------------------------------------#
     elsif ($fz =~ m/VBScript Runtime/i)
     {
         print BOLD, GREEN, "[!] VBScript Runtime -> $urlscan\n", RESET;
	 print BOLD, YELLOW "[x] Non-Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[VBScript] $urlscan\n");
         }
     }

#-----------------------------------------------------------#
#      PostgreSQL                                           #
#-----------------------------------------------------------#
	elsif ($fz =~ m/postgresql.util/i || $fz =~ m/psql: FATAL/i || $fz =~ m/ERROR: invalid input syntax for integer/i )
     {
         print BOLD, GREEN, "[!] {PostgreSQL} Fatal Error -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre Fatal Error] $urlscan\n");
         }
     }
	elsif ($fz =~ m/dynamic_result_sets_returned/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 0100C -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 0100C] $urlscan\n");
         }
     }
	elsif ($fz =~ m/null_value_eliminated_in_set_function/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 1003 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 1003] $urlscan\n");
         }
     }

	elsif ($fz =~ m/string_data_right_truncation/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 1004 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 1004] $urlscan\n");
         }
     }
	elsif ($fz =~ m/deprecated_feature/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 01P01 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 01P01] $urlscan\n");
         }
     }
	elsif ($fz =~ m/sql_statement_not_yet_complete/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 3000 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 3000] $urlscan\n");
         }
     }
	elsif ($fz =~ m/connection_does_not_exist/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 8003 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 8003] $urlscan\n");
         }
     }

	elsif ($fz =~ m/connection_failure/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 8006 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 8006] $urlscan\n");
         }
     }

	elsif ($fz =~ m/sqlserver_rejected_establishment_of_sqlconnection/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 8004 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 8004] $urlscan\n");
         }
     }

	elsif ($fz =~ m/no_additional_dynamic_result_sets_returned/i)
     {
         print BOLD, GREEN, "[!] {PostgreSQL} 2001 -> $urlscan\n", RESET;
	 print BOLD, WHITE "[*] Critical\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Postgre 2001] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      Oracle                                               #
#-----------------------------------------------------------#
	elsif ($fz =~ m/oracle.jdbc/i || $fz =~ m/system.data.oledb/i )
     {
         print BOLD, GREEN, "[!] {JDBC} -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[JDBC] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      Sybase                                               #
#-----------------------------------------------------------#
	elsif ($fz =~ m/Warning: sybase_query()/i || $fz =~ m/sybase_fetch_assoc()/i )
     {
         print BOLD, GREEN, "[!] {Sybase} Query/Fetch -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[Sybase Query/Fetch] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      MariaDB                                              #
#-----------------------------------------------------------#
	elsif ($fz =~ m/ERROR 1712 (HY000)/i )
     {
         print BOLD, GREEN, "[!] {MariaDB} Index Corruption -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MariaDB Index] $urlscan\n");
         }
     }
	elsif ($fz =~ m/ER_QUERY_EXCEEDED_ROWS_EXAMINED_LIMIT/i )
     {
         print BOLD, GREEN, "[!] {MariaDB} Query Excecution Corrupted -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MariaDB Query Exe] $urlscan\n");
         }
     }
	elsif ($fz =~ m/ER_QUERY_CACHE_IS_GLOBALY_DISABLED/i )
     {
         print BOLD, GREEN, "[!] {MariaDB} Query cache is globally disabled -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MariaDB Query Cache] $urlscan\n");
         }
     }
	elsif ($fz =~ m/ER_DYN_COL_IMPLEMENTATION_LIMIT/i )
     {
         print BOLD, GREEN, "[!] {MariaDB} Dynamic column implementation limit -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[MariaDB Dynamic Col] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      IBM DB2                                              #
#-----------------------------------------------------------#
	elsif ($fz =~ m/The processing of the CONNECT statement at a DB2 remote server has failed/i)
     {
         print BOLD, GREEN, "[!] {IBM DB2} 00D30021 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[DB2 00D30021] $urlscan\n");
         }
     }

	elsif ($fz =~ m/DB2 cannot connect to a group buffer pool/i)
     {
         print BOLD, GREEN, "[!] {IBM DB2} 00C20203 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[DB2 00C20203] $urlscan\n");
         }
     }
	elsif ($fz =~ m/An error was detected in the command that was used to start the/i)
     {
         print BOLD, GREEN, "[!] {IBM DB2} 00E80051 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[DB2 00E80051] $urlscan\n");
         }
     }
	elsif ($fz =~ m/Oracle DB2/i)
     {
         print BOLD, GREEN, "[!] {IBM DB2} Oracle DB2 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[DB2 Oracle] $urlscan\n");
         }
     }
	elsif ($fz =~ m/Oracle ODBC/i)
     {
         print BOLD, GREEN, "[!] {IBM DB2} Oracle ODBC -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[DB2 ODBC] $urlscan\n");
         }
     }


#-----------------------------------------------------------#
#      PHP PDO                                              #
#-----------------------------------------------------------#
	elsif ($fz =~ m/SQLSTATE[42000] [1049] Unknown database/i )
     {
         print BOLD, GREEN, "[!] {PHP PDO} 1049 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[PHP PDO 1049] $urlscan\n");
         }
     }
	elsif ($fz =~ m/SQLSTATE[28000] [1045] Access denied for user/i )
     {
         print BOLD, GREEN, "[!] {PHP PDO} 1045 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[PHP PDO 1045] $urlscan\n");
         }
     }
#-----------------------------------------------------------#
#      Coldfusion                                           #
#-----------------------------------------------------------#
	elsif ($fz =~ m/Error Executing Database Query/i)
     {
         print BOLD, GREEN, "[!] {Coldfusion} Error Executing DB -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[CFM] $urlscan\n");
         }
     }
	elsif ($fz =~ m/ORA-01756/i )
     {
         print BOLD, GREEN, "[!] {Coldfusion} JDBC ORA-01756 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[CFM ORA-01756] $urlscan\n");
         }
     }
     elsif ($fz =~ m/ORA-00921/i )
     {
         print BOLD, GREEN, "[!] {Coldfusion} JDBC ORA-00921 -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[CFM ORA-00921] $urlscan\n");
         }
     }
     elsif ($fz =~ m/error ORA-/i )
     {
         print BOLD, GREEN, "[!] {Coldfusion} JDBC Generic -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[CFM Misc] $urlscan\n");
         }
     }
     elsif ($fz =~ m/JDBC Oracle/i )
     {
         print BOLD, GREEN, "[!] {Coldfusion} JDBC Oracle -> $urlscan\n", RESET;
         if (defined($vulnf))
         { 
             push (@vuln2,"[CFM JDBC Oracle] $urlscan\n");
         }
     }
}

variables();
main();

if (defined($search_dork))
{
     print GREEN,BOLD,"[+] Dork        : ",YELLOW,"$search_dork\n";
		  print GREEN,"[+] Proxy       : ",YELLOW,"$proxy\n";
		  print GREEN,"[+] Output File : ",YELLOW,"$vulnf\n";
		  print YELLOW,"[!] Press Ctrl C to Exit\n";
		  print "[!] ",UNDERLINE,"Beware of False Positive\n\n",RESET;
     vulnscanner();
     if (defined($vulnf))
     {
	 
         open(vuln_file,">>$vulnf") ;
         print vuln_file @vuln1;
         print vuln_file @vuln2;
         print vuln_file @vuln3;
         close(vuln_file);
         print YELLOW,"[+] Result Saved to $vulnf\n",RESET;
         exit();
     }
}
#-----------------------------------------------------------#
#      End                                                  #
#-----------------------------------------------------------#
