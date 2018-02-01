$(document).ready(function() {

	var viewname = $("#viewName").val();

	if(viewname == "un-google-link"){
		$("#temp").attr("value","Un-Link");
		$("#temp").attr("title","Un-Google Link");
		$("#unescape").hide();
		$("#loadEscape").hide();
		$("#me").hide();
	}
	$("#" + viewname).addClass("currentselected");

});
var escapeHtmlArray = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&apos;',
  };

function setToEditor(response) {
	$("#input").val("");
	$("#input").val(response.trim());
	$("#temp").click();
}
  function escapeHtml(input) {
    return String(input).replace(/[&<>"']/g, function (s) {
      return escapeHtmlArray[s];
    });
  }
  
  function unEscapeHtml(input) {
	  return String(input)
      .replace(/&amp;/g, '&')
      .replace(/&quot;/g, '"')
      .replace(/&apos;/g, "'")
      .replace(/&lt;/g, '<')
      .replace(/&gt;/g, '>');
  }
  
  function escapeSQL(input){
	  return String(input).replace(/'/g,'"');
  }
  
  function unEscapeSQL(input){
	  return String(input).replace(/"/g,"'");
  }
  
  function escapeCSV(input){
	  var csv = String(input).replace(/"/g,'""');
	  
	  if(csv.charAt(0) != '"'){
		  csv = '"' + csv;
	  }
	  if(csv.charAt(csv.length-1) != '"'){
		  csv = csv + '"';
	  }
	  return csv;
  }
  
  function unEscapeCSV(input){
	  
	  if(input.charAt(0) == '"'){
		  input = input.substring(1, input.length-1);
	  }
	  if(input.charAt(input.length-1) == '"'){
		  input = input.substring(0, input.length-2);
	  }
	  
	  return String(input).replace(/""/g,'"');
  }
  
  function escapeJava(input)
	{
		var escape="";
		
		var i=0;
		for(i=0;i<input.length;i++)
		{
			escape=escape+javaEscapeCode(input.charAt(i),false);
		}
		
		return escape;	
	}
  
  function unEscapeJava(input){
	  return  input.replace(/\\r/g,'\r')
	  .replace(/\\n/g,'\n')
	  .replace(/\\'/g,"\'")
	  .replace(/\\\"/g,'"')
	  .replace(/\\\\/g,'\\')
	  .replace(/\\t/g,'\t')
	  .replace(/\\b/g,'\b')
	  .replace(/\\f/g,'\f');
  }
  
  function unEscapeJavaScript(input){
	  return input.replace(/\\r/g,'\r')
			   .replace(/\\n/g,'\n')
			   .replace(/\\'/g,"\'")
			   .replace(/\\\"/g,'"')
			   .replace(/\\&/g,'\&')
			   .replace(/\\\\/g,'\\')
			   .replace(/\\t/g,'\t')
			   .replace(/\\b/g,'\b')
			   .replace(/\\f/g,'\f')
			   .replace(/\\x2F/g,'/')
			   .replace(/\\x3C/g,'<')
			   .replace(/\\x3E/g,'>');
  }
	 
function javaEscapeCode(original, skipNewLine)
{
	if(skipNewLine && original=='\n') return; 
 	var thecharchar=original.charAt(0);
	switch(thecharchar) {
			case '\n': return "\\n"; break; //newline
			case '\r': return "\\r"; break; //Carriage return
			case '\'': return "\\'"; break;
			case '"': return "\\\""; break;
			case '\\': return "\\\\"; break;
			case '\t': return "\\t"; break;
			case '\b': return "\\b"; break;
			case '\f': return "\\f"; break;
			default:
				return original;
				break;
		}
}
 

function escapeJavascript(input)
{
	var escape="";
	
	var i=0;
	for(i=0;i<input.length;i++)
	{
		escape=escape+javascriptEscapeCode(input.charAt(i),false);
	}
	
	return escape;	
}

function javascriptEscapeCode(original)
{
	  	var thecharchar=original.charAt(0);
	switch(thecharchar) {
			case '\r': return "\\r"; break;
			case '\n': return "\\n"; break; //newline
			case '\v': return "\\v"; break; 
			case '\'': return "\\'"; break;
			case '"': return "\\\""; break;
			case '\&': return "\\&"; break;
			case '\\': return "\\\\"; break;
			case '\t': return "\\t"; break;
			case '\b': return "\\b"; break;
			case '\f': return "\\f"; break;
			default:
				return original;
				break;
		}
}

function makeLink(type,url){
	type = type.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
   var regex = new RegExp("[\\?&]" + type + "=([^&#]*)"),
   results = regex.exec(url);
   return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function unLink(link){
	var value = makeLink("url", link);
	
	if(!value){
		value = makeLink("adurl",link);
	}
return value;
}
  function escape(type){
	  var str = $("#input").val();
	  
	  var vName = $("#viewName").val().split('-')[0];
	  
	  if(vName == null || vName.trim().length == 0){
		  return;
	  }
	  
	  if(vName.trim().toLowerCase() == 'html' || vName.trim().toLowerCase() == 'xml'){
		  str = escapeHtml(str);
	  }
	  else if(vName.trim().toLowerCase() == 'java' || vName.trim().toLowerCase() == 'csharp'){
		  str = escapeJava(str);
	  }
	  else if(vName.trim().toLowerCase() == 'javascript' || vName.trim().toLowerCase() == 'json'){
		  str = escapeJavascript(str);
	  }
	  else if(vName.trim().toLowerCase() == 'sql'){
		  str = escapeSQL(str);
	  }
	  else if(vName.trim().toLowerCase() == 'csv'){
		  str = escapeCSV(str);
	  }
	  else if(vName.trim().toLowerCase() == 'un'){
		  str = unLink(str);
	  }
	  $("#output").val(str);
  }
  
  function unescape(type){
	  var str = $("#input").val();
	  
	  var vName = $("#viewName").val().split('-')[0];
	  
	  if(vName == null || vName.trim().length == 0){
		  return;
	  }
	  
	  if(vName.trim().toLowerCase() == 'html' || vName.trim().toLowerCase() == 'xml'){
		  str = unEscapeHtml(str);
	  }
	  else if(vName.trim().toLowerCase() == 'java' || vName.trim().toLowerCase() == 'csharp'){
		  str = unEscapeJava(str);
	  }
	  else if(vName.trim().toLowerCase() == 'javascript' || vName.trim().toLowerCase() == 'json'){
		  str = unEscapeJavaScript(str);
	  }
	  else if(vName.trim().toLowerCase() == 'sql'){
		  str = unEscapeSQL(str);
	  }
	  else if(vName.trim().toLowerCase() == 'csv'){
		  str = unEscapeCSV(str);
	  }
	  $("#output").val(str);
  }
  