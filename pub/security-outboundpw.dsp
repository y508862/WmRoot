<HTML>
  <HEAD>
    <TITLE>Integration Server -- Outbound Password Management</TITLE>

    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css"></LINK>
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT type="text/javascript" SRC="webMethods.js"></SCRIPT>

  </HEAD>

  <BODY onLoad="setNavigation('security-outboundpw.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_OutboundPasswordsScrn');">

    <FORM method="post" name="propsForm" action="security-outboundpw.dsp">
      
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
      <TABLE width="100%">

        <INPUT type="hidden" name="action" value="%value action encode(htmlattr)%"/>
        <INPUT type="hidden" name="expDate" value=""/>
        <INPUT type="hidden" name="expireInterval" value="%value expireInterval encode(htmlattr)%"/>
        <INPUT type="hidden" name="interval" value=""/>
        <INPUT type="hidden" name="expiresIn" value=""/>
        <INPUT type="hidden" name="stateMsg" value=""/>

        <TR>
          <TD class="breadcrumb" colspan="2"> Security &gt; Outbound Passwords </TD>
        </TR>

        %ifvar action equals('reset')%
          %invoke wm.server.internalOutboundPasswords:resetAllPasswords%
            %onerror%
              %ifvar errorMessage%
                <TR><TD colspan="2">&nbsp;</TD></TR>
                <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
              %endif%
          %endinvoke%
        %endif%

        %ifvar action equals('updateInterval')%
          %invoke wm.server.internalOutboundPasswords:setMasterExpireInterval%
            %onerror%
              %ifvar errorMessage%
                <TR><TD colspan="2">&nbsp;</TD></TR>
                <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
              %endif%
          %endinvoke%
        %endif%

        %ifvar action equals('updateMaster')%
          %invoke wm.server.internalOutboundPasswords:rawMasterUpdate%
            %onerror%
              %ifvar errorMessage%
                <TR><TD colspan="2">&nbsp;</TD></TR>
                <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
              %endif%
          %endinvoke%
        %endif%

        %invoke wm.server.internalOutboundPasswords:getMasterPasswordProperties%
          %rename expireDate expDate -copy%
          %rename expireInterval interval -copy%
          %rename daysTilExpire expiresIn -copy%
          %rename statusMessage stateMsg -copy%
          %onerror%
            %ifvar errorMessage%
              <TR><TD colspan="2">&nbsp;</TD></TR>
              <TR><TD class="message" colspan=2>%value errorMessage encode(html)%</TD></TR>
            %endif%
        %endinvoke%

        %invoke wm.server.internalOutboundPasswords:getMasterExpireMessage%
          %ifvar expireMessage%
            <TR><TD colspan="2">&nbsp;</TD></TR>
            <TR><TD class="message" colspan="2">%value expireMessage encode(html)%</TD></TR>
          %endif%
        %endinvoke%

        %ifvar message%
          <TR><TD colspan="2">&nbsp;</TD></TR>
          <TR><TD class="message" colspan="2">%value message encode(html)%</TD></TR>
        %endif%

        <TR>
          <TD colspan="2">
            <ul class="listitems">
			  <script>
			  createForm("htmlform_masterpwd_update", "masterPwUpdate.dsp", "POST", "BODY");
			  createForm("htmlform_masterpwd_expire", "masterPwExpire.dsp", "POST", "BODY");
			  </script>
              <li class="listitem">
			  <script>getURL("masterPwUpdate.dsp","javascript:document.htmlform_masterpwd_update.submit();","Update Master Password");</script></li>
              <li class="listitem">
			  <script>getURL("masterPwExpire.dsp","javascript:document.htmlform_masterpwd_expire.submit();","Update Expiration Interval");</script></li>
            </UL>
          </TD
        </TR>

        <TR>
          <TD>
            <TABLE class="tableView" width="60%">
              <TR>
                <TD class="heading" colspan=2>Master Password Properties</TD>
              </TR>
              <script>resetRows();</script>
              <TR>
                <TD class="oddrow">Expiration Date</TD>
                <TD class="oddrowdata-l">%value expDate encode(html)%</TD>
              </TR>
              <TR>
                <TD class="evenrow">Expiration Interval (in days)</TD>
                <TD class="evenrow-l">%value interval encode(html)%</TD>
              </TR>
              <TR>
                <TD class="oddrow">Number of Days to Expiration</TD>
                <TD class="oddrowdata-l">%value expiresIn encode(html)%</TD>
              </TR>
              <TR>
                <TD class="evenrow">Status</TD>
                <TD class="evenrowdata-l">%value stateMsg encode(html)%</TD>
              </TR>
            </TABLE>
          </TD>
        </TR>

      </TABLE>
    </FORM>

  </BODY>

</HTML>

