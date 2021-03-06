<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">

<link rel="stylesheet" type="text/css" href="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<script src="webMethods.js"></script>

%invoke wm.server.jms:getSettings%

<script language ="javascript">
  
  function validateForm(obj) {   
    if (editform.threadPoolThrottle.value == "") {
      alert("Thread Pool Throttle must be specified");
      return false;
    }
    if (!isNumeric(editform.threadPoolThrottle.value) || editform.threadPoolThrottle.value < 1 || editform.threadPoolThrottle.value > 100) {
      alert("Thread Pool Throttle must be an integer between 1 and 100.");
      return false;
    }
    return true;
  }

  function isNumeric(input) {
    var validNums = "0123456789";
    var char;
    var result = true;

    if (input.length == 0) {
      return false;
    }
    for (i = 0; i < input.length && result == true; i++) {
      char = input.charAt(i);
      if (validNums.indexOf(char) == -1) {
        result = false;
      }
    }
    return result;
  }

</script>

</head>

<body onLoad="setNavigation('settings-jms-global-trigger.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMS_TriggerMgmtEdit');">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JMS Settings &gt; Global JMS Trigger Controls &gt; Edit</td>
    </tr>
    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jms_trigger_management", "settings-jms-trigger-management.dsp", "POST", "BODY");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-jms-trigger-management.dsp","javascript:document.htmlform_settings_jms_trigger_management.submit();","Return to JMS Trigger Management")</script>
		  </li>
        </ul>
      </td>
    </tr>
    <tr>
    
    <form name="editform" action="settings-jms-trigger-management.dsp" method="post" onSubmit="return validateForm()">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
    
      <td>
        <table class="tableView">

          <tr>
            <TD class="heading" colspan=2>Global JMS Trigger Controls</TD>
          </tr>
          
          <!-- Thread Pool Throttle -->
          
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true"><label for="threadPoolThrottle">Thread Pool Throttle</label></td>
            <td class="oddrowdata-l"><INPUT NAME="threadPoolThrottle" id="threadPoolThrottle" size="6" value="%value threadPoolThrottle encode(htmlattr)%">&nbsp;% of Server Thread Pool</td>
          </tr>
          
          <!-- Processing Throttle -->
          
          <tr>  
            <td class="evenrow-l" nowrap><label for="processingThrottle">Individual Trigger Processing Throttle</label></td>
            <td class="evenrowdata-l" nowrap>          
              <select name="processingThrottle" id="processingThrottle" size="1">
                <option %ifvar processingThrottle equals('100')% selected="selected" %endif% value="100" > 100% </option>
                <option %ifvar processingThrottle equals('90')% selected="selected" %endif% value="90" > 90% </option>
                <option %ifvar processingThrottle equals('80')% selected="selected" %endif% value="80" > 80% </option>
                <option %ifvar processingThrottle equals('70')% selected="selected" %endif% value="70" > 70% </option>
                <option %ifvar processingThrottle equals('60')% selected="selected" %endif% value="60" > 60% </option>
                <option %ifvar processingThrottle equals('50')% selected="selected" %endif% value="50" > 50% </option>
                <option %ifvar processingThrottle equals('40')% selected="selected" %endif% value="40" > 40% </option>
                <option %ifvar processingThrottle equals('30')% selected="selected" %endif% value="30" > 30% </option>
                <option %ifvar processingThrottle equals('20')% selected="selected" %endif% value="20" > 20% </option>
                <option %ifvar processingThrottle equals('10')% selected="selected" %endif% value="10" > 10% </option>
              </select>&nbsp;of Maximum
            </td>
          </tr>
          
          <tr>
            <td class="action" colspan=2>
              <input name="action" type="hidden" value="setSettings">
              <input type="submit" value="Save Changes">
            </td>
          </tr>
    
    </form>
  </table>
  
  %onerror%
    %value errorService encode(html)%<br>
    %value error encode(html)%<br>
    %value errorMessage encode(html)%<br>
  
</body>
%endinvoke%
</html>