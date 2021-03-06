<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Integration Server</TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
  </HEAD>
  <BODY onLoad="setNavigation('package-exchange.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_UpdateRemoveSubsScrn');">
   
  <SCRIPT LANGUAGE="JavaScript">

    function checkcheckboxes(formname)
    {
      var cnt = 0;

      if ( document.forms[formname].subscriber.length > 1 )
      {
        for( var i=0; i<document.forms[formname].subscriber.length; i++ )
        {
          if (document.forms[formname].subscriber[i].checked == true)
          cnt++;
        }
      } else {
        if( document.forms[formname].subscriber.checked == true )
          cnt++;
      }

      if ( cnt < 1 ) {
        alert("Select a Subscriber first.");
        return false;
      }
      else {
        return true;
      }
    }
  </SCRIPT>

    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Packages &gt;
          Publishing &gt;
          Update and Remove Subscriber
        </TD>
      </TR>
      %ifvar action equals('removesubscriber')%
        %invoke wm.server.replicator.adminui:subscriberCancel%
          %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
            <TR><TD class="message" colspan=2>%value message encode(html)%</TD></TR>
          %endif%
        %endinvoke%
      %endif%
      <TR>
        <TD colspan=2>
          <UL class="listitems">
			<script>
			createForm("htmlform_package_exchange", "package-exchange.dsp", "POST", "BODY");
			</script>
            <li>
			<script>getURL("package-exchange.dsp", "javascript:document.htmlform_package_exchange.submit();", "Return to Publishing");</script>
			</li>
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
        <script>
            var count = 0;
        </script>
              %invoke wm.server.replicator:getDetailedReleasedList%
                %loop packages%
                  %invoke wm.server.replicator:publishedList%
                    %loop published%
                      %ifvar ../name vequals(package)%

                                                <script>
                                                    var count = count + 1;
                                                </script>
          <TABLE class="tableView" width="100%">

                        <TR>
                          <TD class="heading" colspan=3>%value ../name encode(html)%</TD>
                        </TR>
                        <TR>
                          <TH scope="col" CLASS="oddcol-l">Subscriber</TH>
                          <TH scope="col" CLASS="oddcol">Update</TH>
                          <TH scope="col" CLASS="oddcol-l">Delete</TH>
                        </TR>
                        <SCRIPT>%rename ../../webMethods-wM-AdminUI webMethods-wM-AdminUI -copy%</SCRIPT>
                        <FORM name="%value ../name encode(htmlattr)%" action="package-remove-subscriber.dsp" method=POST>
                        <input type="hidden" name="webMethods-wM-AdminUI" value="true">
                        <input type="hidden" name="action" value="removesubscriber">
                        <input type="hidden" name="package" value="%value ../name encode(htmlattr)%">
                        <script>resetRows();</script>

                        %ifvar initbypub equals('yes')%

                            %loop subscribers%
                          <TR>
                            <script>writeTD("rowdata-l");</script>
                              %value encode(html)%
                            </TD>

                            <script>writeTD("rowdata");</script>
							<script>
							createForm("htmlform_package_edit_subscriber_%value $index%", "package-edit-subscriber.dsp", "POST", "BODY");
							setFormProperty("htmlform_package_edit_subscriber_%value $index%", "subscriber", "%value%");
							setFormProperty("htmlform_package_edit_subscriber_%value $index%", "package", "%value ../name%");
							</script>
                              <script>
									if(is_csrf_guard_enabled && needToInsertToken) {
										document.write('<A HREF="javascript:document.htmlform_package_edit_subscriber_%value $index%.submit();">Edit</A>');
									} else {
										var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
										if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
											document.write('<A HREF="package-edit-subscriber.dsp?subscriber=%value encode(url)%&package=%value ../name encode(url)%&webMethods-wM-AdminUI=true">Edit</A>');
										}
										else {
											document.write('<A HREF="package-edit-subscriber.dsp?subscriber=%value encode(url)%&package=%value ../name encode(url)%">Edit</A>');
										}
									}
								</script>
							  
							  
							  </TD>

                            <script>writeTD("rowdata-l");</script>
                              <input type="checkbox" name="subscriber" id="subscriber" value="%value encode(htmlattr)%"></input>
                            </TD>
                            <script>swapRows();</script>
                          </TR>
                            %endloop%

                        %else%
                            %loop subscribers%
                          <TR>
                            <script>writeTD("rowdata-l");</script>
                              %value encode(html)%
                            </TD>

                            <script>writeTD("rowdata");</script>
                              Not Available</TD>

                            <script>writeTD("rowdata-l");</script>
                              <input type="checkbox" name="subscriber" id="subscriber" value="%value encode(htmlattr)%"></input>
                            </TD>
                            <script>swapRows();</script>
                          </TR>
                            %endloop%
                        %endif%

                        <TR>
                          <TD class="action" colspan="3">
                            <input class="button2" type="submit" name="submit" onclick="return checkcheckboxes('%value ../name encode(javascript)%'); return false;" value="Delete Selected Subscribers">
                          </TD>
                        </TR>
                        </FORM>
          </TABLE>
                      %endif%
                    %endloop%
                  %endinvoke%
                %endloop%
              %endinvoke%

              <script>
                                if(count == 0)
                                {
                                    document.write('<table class="tableView"><tr><td class=heading>Remove Subscribers</td></tr><tr><td class=oddrow-l>No subscribers to remove</td></tr></table>');
                                }
                            </script>

        </TD>
      </TR>
    </TABLE>
  </BODY>
</HTML>
