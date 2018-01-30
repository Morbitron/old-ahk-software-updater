var isXmlData = true, editorAce, editorResult, viewname, converted = "", arr = [], flag = true, mode, json = "", editor;

$(document).ready(function() {
	
	viewname = $("#viewName").val().trim();

	if (viewname == 'xmlviewer') {
		setViewTitle("XML VIEWER", true, true);
		createEditor("xml", "xml");
	} else if (viewname == 'xml-to-csv-converter') {
		setViewTitle("XML TO CSV Converter", true, true);
		createEditor("xml", "text");
	} else if (viewname == 'xml-to-yaml') {
		setViewTitle("XML TO YAML Converter", true, true);
		createEditor("xml", "yaml");
	} else if (viewname == 'xmltojson') {

		mode = document.getElementById('mode');
		/*mode.onchange = function() {
			try{
			editorResult.getSession().setMode(mode.value);
			showJSON(true);
		}
		catch(e){
			console.log(e);
		}

		};*/

		var container = document.getElementById("jsoneditor");

		var options = {
			//mode : mode.value,
			error : function(err) {
				openErrorDialog(err.toString());
			}
		};
		//editor = new JSONEditor(container, options,{});
		setViewTitle("XML TO JSON Converter", true, true);
		createEditor('xml','json');
	}
	else if (viewname == 'xmlvalidate') {
		setViewTitle("XML Validator",true,true);
		createEditor("xml");
	}
	else if (viewname == 'online-xml-editor') {
		setViewTitle("Online XML EDITOR",true,true);
		createEditor("xml");	
		editorAce.setOptions({
		    enableBasicAutocompletion: true,
		    enableSnippets: true,
		    enableLiveAutocompletion: false
		});
	}else if (viewname == 'xml-to-excel-converter') {
		createEditor("xml");
		setViewTitle("Online XML TO EXCEL Converter", true, true);
	}
});

function setToEditor(data) {
	isXmlData = true;
	/*if(mode.value=='tree')
	{
		editorResult.getSession().setMode("ace/mode/tree");
		editor.setMode('tree');
	}
	else{*/
		//alert(viewname);
		if(viewname !='xmlvalidate' && viewname !='xml-to-excel-converter' && viewname!='online-xml-editor')
		{
			editorResult.getSession().setMode("ace/mode/json");
		}

	editorAce.setValue(data);
	if (viewname == 'xmlviewer') {
		xmlTreeView();
	} else if (viewname == 'xml-to-csv-converter') {
		 xmlTocsv();
	} else if (viewname == 'xml-to-yaml') {
		XMLToYAML();
	} else if (viewname == 'xmltojson') {
		 xmlTojson();
	}

	else if (viewname == 'xmlvalidate') {
		validateXML();
	}
	else if (viewname == 'online-xml-editor') {
		xmlTreeView();
	}
}

function xmlTreeView() {
	isXmlData = true;
	var oldformat = editorAce.getValue();
	if (oldformat.trim().length > 0) {
		var newformat = vkbeautify.xml(oldformat);
		$('#result1').html("");
		$('#result1').show();
		$('#result').hide();
		new XMLTree({
			xml : newformat.trim(),
			container : '#result1',
			startExpanded : true
		});

		setOutputMsg("XML Tree View");
	} else {
		$('#result1').html("");
	}
}

function FormatXML() {
	isXmlData = true;
	editorResult.getSession().setMode("ace/mode/xml");
	$('#result').show();
	$('#result1').hide();
	var oldformat = editorAce.getValue();
	if (oldformat.trim().length > 0) {

		var newformat = vkbeautify.xml(oldformat);
		editorResult.setValue(newformat);

		setOutputMsg("Beautify XML");
	}
}

function showJSON() {
	isXmlData = false;
	editorResult.getSession().setMode("ace/mode/json");
	$('#result').show();
	$('#result1').hide();

	var xml = editorAce.getValue();

	if (xml.trim().length > 0) {
		try {
			var x2js = new X2JS();

			editorResult.setValue(vkbeautify.json(JSON.stringify(x2js
					.xml_str2json(xml))));

			setOutputMsg("XML to JSON");
		} catch (e) {

			openErrorDialog("invalid XML" + e);
		}
	}
}

function MinifyXML() {
	isXmlData = true;
	editorResult.getSession().setMode("ace/mode/xml");
	$('#result').show();
	$('#result1').hide();
	var oldformat = editorAce.getValue();
	editorResult.getSession().setUseWrapMode(true);
	if (oldformat.trim().length > 0) {
		var newformat = vkbeautify.xmlmin(vkbeautify.xml(oldformat));
		editorResult.setValue(newformat);

		setOutputMsg("Minify XML");
	}
}

function createXMLFile() {

	var data = editorAce.getValue();

	if (data.trim().length > 0) {

		var content = "";
		if ($("#result1").is(':visible')) {
			content = vkbeautify.xml(data);
		} else {
			content = editorResult.getValue();
		}

		if (content != null && content != "" && content.trim().length > 0) {
			var blob = new Blob([ "" + content + "" ], {
				type : "text/plain;charset=utf-8"
			});
			var fileName = "codebeautify.xml";
			if (isXmlData == false) {
				fileName = "codebeautify.json";
			}
			saveAs(blob, fileName);
		} else {
			openErrorDialog("Sorry Result is Empty");
		}
	}
}

/** *********** xml to csv *************** */

function getText(xml, xpath, nodes) {
	$(xpath, xml).each(function() {
		nodes.push($(this).text());
	});
}


function xmlTocsv() {

	var data = editorAce.getValue();

	var xml = "";

	if (data != null && data.trim().length != 0) {

		try {
			xml = $.parseXML(data);
		} catch (e) {
			openErrorDialog("Invalid XML");
		}

		var x2js = new X2JS();

		data = x2js.xml2json(xml);

		setOutputMsg("XML TO CSV");

		jsonTocsvbyjson(data);
	}
}

function xmlToarray() {

	$.ajax({
		type : "post",
		url : globalurl + "convter",
		dataType : "json",
		data : {
			type : "xml2array",
			data : editorAce.getValue()
		},
		success : function(response) {
			console.log(response);
			console.log(Papa.unparse(response));
		},
		error : function(e, s, a) {
			openErrorDialog("Failed to load data=" + s);

		}
	});
}


// xml to yaml

function XMLToYAML() {
	editorResult.getSession().setMode("ace/mode/yaml");
	var oldformat = editorAce.getValue();

	if (oldformat.trim().length > 0) {
		try {

			var x2js = new X2JS();

			data = x2js.xml_str2json(oldformat.trim());

			data = json2yaml(data);

			editorResult.setValue(data);

			setOutputMsg("XML TO YAML");
		} catch (e) {
			var errorData = "";

			errorData = errorData + "Error : " + e['message'];
			errorData = errorData + "\n";
			errorData = errorData + "Line : " + e['parsedLine'] + "  "
					+ e['snippet'];

			editorResult.setValue(errorData);
			setOutputMsg("Invalid XML");
		}
	}
}

// xml to json
function xmlTojson() {

	var xml = editorAce.getValue();

	if (xml.trim().length > 0) {
		
		$("#json").show();
		$("#xml").hide();
		var data = "";
		try {

			/*var x2js = new X2JS();
			editor.setMode('json');
			editor.set(x2js.xml_str2json(xml));
			editor.expandAll(true);*/
			var x2js = new X2JS();
			var n  = vkbeautify.json(x2js.xml_str2json(xml));
			console.log(n);
			isJsonData = true;
					editorResult.getSession().setMode("ace/mode/json");
					$("#json").hide();
					$("#xml").show();
					editorResult.getSession().setUseWrapMode(false);
					editorResult.setValue(n);
			setOutputMsg("XML to JSON");
			
			$(".jsoneditor").removeAttr('height');
			
		} catch (e) {
			console.log(e);
			if (data != null && data.length != 0) {
				openErrorDialog("invalid XML");
			}
		}
	}
}

// xml validate
function validateXML() {
	if (validate(editorAce.getValue().trim()) != " "
			&& editorAce.getValue().trim().length > 0) {
		var data = editorAce.getValue();
		if (data != null && data != "" && data.trim().length > 0) {
			try {
				$.ajax({
					type : 'post',
					url : '/service/validateXML',
					dataType : 'json',
					data : {
						data : data
					},
					success : function(response) {
						if (response.length == 0) {
							$("#hResult").show();
							$("#hResult").removeClass();
							$("#hResult").addClass("success");
							$("#editor").css({
								'border' : '1px solid #C6D880'
							});
							$("#hResult").text("Valid XML");
							var oldformat = editorAce.getValue();
							
							if (oldformat.trim().length > 0) {
								var newformat = vkbeautify.xml(oldformat);
								editorAce.setValue(newformat);
								editorAce.clearSelection();
							}
						} else {

							var total_error = "";
							$.each(response, function(i, value) {

								var error = '';

								error = error + "Error on-> ";
								error = error + " Line :" + value.line;
								error = error + " Column :" + value.column
										+ "\n";
								error = error + "Message :" + value.message
										+ "\n";
								total_error = total_error + error;
							});
							$("#hResult").show();
							$("#editor").css({
								'border' : '1px solid #FBC2C4'
							});
							$("#hResult").removeClass();
							$("#hResult").addClass("error");
							$("#hResult").text(total_error);
						}
					}

				});

			} catch (e) {

				$("#hResult").show();
				$("#editor").css({
					'border' : '1px solid #FBC2C4'
				});
				$("#hResult").removeClass();
				$("#hResult").addClass("error");
				$("#hResult").text(e);
			}
		}
	} else {
		$("#editor").css({
			'border' : '1px solid #BCBDBA'
		});
		$("#hResult").hide();
	}
}

function validate(arg) {
	if (arg == undefined || arg == null || arg == "") {
		return "";
	} else {
		return arg;
	}
}

function clearXML()
{
	editorAce.setValue("");
	$("#hResult").hide();
}

//xml validator
function downloadXMLFile() {
	var content = editorAce.getValue();
	if (content.trim().length > 0) {

		var blob = new Blob([ "" + editorAce.getValue() + "" ], {
			type : "text/plain;charset=utf-8"
		});
		var filename = "codebeautify.xml";
		
		if (converted != "validate") {
			saveAs(blob, filename);
		} else {
			openErrorDialog("Yaml is not converted to JSON / XML ");
		}
	} else {
		openErrorDialog("Sorry Result is Empty");
	}
}
