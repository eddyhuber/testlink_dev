{* 
TestLink Open Source Project - http://testlink.sourceforge.net/

show Test Results and Metrics
@filesource	resultsTC.tpl

@internal revisions
@since 1.9.6 
20130203 - franciscom - TICKET 0005516
*}

{lang_get var="labels"
          s="title,date,printed_by,title_test_suite_name,platform,
             title_test_case_title,version,generated_by_TestLink_on, priority,
             info_resultsTC_report,elapsed_seconds,export_as_spreadsheet"}

{include file="inc_head.tpl" openHead="yes"}
{foreach from=$gui->tableSet key=idx item=matrix name="initializer"}
  {assign var=tableID value=$matrix->tableID}
  {if $smarty.foreach.initializer.first}
    {$matrix->renderCommonGlobals()}
    {if $matrix instanceof tlExtTable}
        {include file="inc_ext_js.tpl" bResetEXTCss=1}
        {include file="inc_ext_table.tpl"}
    {/if}
  {/if}
  {$matrix->renderHeadSection()}
{/foreach}

</head>
<body>

{if $gui->printDate == ''}
<form name="resultsTC" id="resultsTC" METHOD="POST"
      action="lib/results/resultsTC.php?format=3&tplan_id={$gui->tplan_id}&tproject_id={$gui->tproject_id}">
<h1 class="title">{$gui->title|escape}
  {if $gui->apikey != ''}
  <input type="hidden" name="apikey" id="apikey" value="{$gui->apikey}">
  {/if}
  <input type="image" name="exportSpreadSheet" id="exportSpreadSheet" 
         src="{$tlImages.export_excel}" title="{$labels.export_as_spreadsheet}">
</form>
</h1>

{else}{* print data to excel *}
<table style="font-size: larger;font-weight: bold;">
	<tr><td>{$labels.title}</td><td>{$gui->title|escape}</td><tr>
	<tr><td>{$labels.date}</td><td>{$gui->printDate|escape}</td><tr>
	<tr><td>{$labels.printed_by}</td><td>{$user|escape}</td><tr>
</table>
{/if}

<div class="workBack">
{include file="inc_result_tproject_tplan.tpl" 
         arg_tproject_name=$gui->tproject_name arg_tplan_name=$gui->tplan_name}	

{foreach from=$gui->tableSet key=idx item=matrix}
  {assign var=tableID value="table_$idx"}
  {if $idx != 0}
  <h2>{$labels.platform}: {$gui->platforms[$idx]|escape}</h2>
  {/if}
  {$matrix->renderBodySection()}
{/foreach}

<br />
<p class="italic">{$labels.info_resultsTC_report}</p>
<br />

{$labels.generated_by_TestLink_on} {$smarty.now|date_format:$gsmarty_timestamp_format}
<p>{$labels.elapsed_seconds} {$gui->elapsed_time}</p>
</div>

</body>
</html>