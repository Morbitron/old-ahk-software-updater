var converted = "", editorAce, editorResult, viewname;

$(document)
		.ready(
				function() {

					viewname = $("#viewName").val().trim();

					if (viewname == 'json-to-csv') {
						setViewTitle("JSON TO CSV Converter", true, true);
						createEditor("json", "text");
					} else if (viewname == 'jsontoxml') {
						setViewTitle("JSON TO XML Converter", true, true);
						createEditor("json", "xml");
					} else if (viewname == 'json-to-yaml') {
						setViewTitle("JSON TO YAML Converter", true, true);
						createEditor("json", "yaml");
					} else if (viewname == 'jsonvalidate') {
						createEditor("json");
						setViewTitle("JSON Validator", true, true);
					}else if (viewname == 'tsv-to-json-converter') {
						createEditor("text","json");
						setViewTitle("Online TSV TO JSON Converter", true, true);
					}else if (viewname == 'json-to-tsv-converter') {
						createEditor("json","text");
						setViewTitle("Online JSON TO TSV Converter", true, true);
					}else if (viewname == 'tsv-to-xml-converter') {
						createEditor("text","xml");
						setViewTitle("Online TSV TO XML Converter", true, true);
					}else if (viewname == 'xml-to-tsv-converter') {
						createEditor("xml","text");
						setViewTitle("Online XML TO TSV Converter", true, true);
					}else if (viewname == 'json-to-excel-converter') {
						createEditor("json");
						setViewTitle("Online JSON TO EXCEL Converter", true, true);
					} 

					// yaml beautify
					var detect_indentation = function(input) {
						var first_index = input.match(/\n+(\s+)/) || [];
						return first_index[1] ? first_index[1].length : null;
					};

					var chomp = function(str) {
						return str.substr(0, str.length - 1);
					};

					var format = function(input, input_indentation,
							output_indentation) {
						var lines = input.split("\n");
						var output = "";
						lines.forEach(function(line) {
							var outputLine = line;
							var spaces = line.match(/^\s+/);
							if (spaces) {
								var num_indents = Math.ceil(spaces[0].length
										/ input_indentation);
								var replace = Array(
										num_indents * output_indentation + 1)
										.join(" ");
								outputLine = line.replace(/^\s+/, replace);
							}

							output += outputLine + "\n";
						});

						return chomp(output);
					};

					function updateIndentation(input,indentation) {
						var input_indentation = detect_indentation(input);
						if (input_indentation) {
							var output = format(input, input_indentation,
									indentation);
							update_output(output);
						}
					}
					var update_output = function(text) {
						editorResult.setValue(text);
					}
				});

function jsonTocsv() {

	jsonTocsvbyjson(editorAce.getValue());
}

function json2xmlConvert(data) {
	try {
		editorResult.getSession().setMode("ace/mode/xml");
		var obj = editorAce.getValue();
		
		if(data != undefined){
			obj = data;
		}
		else{
			setOutputMsg("JSON TO XML");
		}

		if (obj.trim().length > 0) {
			var xotree = new XML.ObjTree();
			var xml = xotree.writeXML(JSON.parse(obj));
			xml = decodeSpecialCharacter(xml);
			var isvalidXML;
			try {
				isvalidXML = $.parseXML(xml);
			} catch (e) {
				isvalidXML = false;

			}
			if (isvalidXML == false) {
				xml = xml.substr(0, 39) + "<root>" + xml.substr(39) + "</root>";
			}
			editorResult.setValue(vkbeautify.xml(xml));
			
		}
	} catch (e) {
		editorResult.setValue("Error in data");
	}
}

function JsonToYAML() {
	editorResult.getSession().setMode("ace/mode/yaml");
	var oldformat = editorAce.getValue();

	if (oldformat.trim().length > 0) {
		try {

			data = json2yaml(oldformat.trim());

			//updateIndentation(data,3);
			editorResult.setValue(data);

			setOutputMsg("JSON TO YAML");
		} catch (e) {
			var errorData = "";

			errorData = errorData + "Error : " + e['message'];
			errorData = errorData + "\n";
			errorData = errorData + "Line : " + e['parsedLine'] + "  "
					+ e['snippet'];

			editorResult.setValue(errorData);
			setOutputMsg("Invalid JSON");
		}
	}
}

function validateJSON() {
	if (validate(editorAce.getValue().trim()) != " "
			&& editorAce.getValue().trim().length > 0) {
		var data = editorAce.getValue();
		if (data != null && data != "" && data.trim().length > 0) {
			try {
				if (jsonlint.parse(data)) {

					// temp check json property and data is proper or not
					console.log(jsonDataValidate(data));
					
					if(!jsonDataValidate(data)){
						throw new JsonDataNotAccurate();
					}

					$("#hResult").show();
					$("#hResult").removeClass();
					$("#hResult").addClass("success");
					$("#editor").css({
						'border' : '1px solid #C6D880'
					});
					$("#hResult").text("Valid JSON");
					var oldformat = editorAce.getValue();
					;
					if (oldformat.trim().length > 0) {
						var newformat = vkbeautify.json(oldformat);
						editorAce.setValue(newformat);
						editorAce.clearSelection();
					}
				}
			} catch (e) {
				$("#hResult").show();
				$("#editor").css({
					'border' : '1px solid #FBC2C4'
				});
				$("#hResult").removeClass();
				$("#hResult").addClass("error");
				$("#hResult").text(e.message);
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
function clearJSON() {
	editorAce.setValue("");
	$("#hResult").hide();
}
//json validator
function downloadJSONFile() {
	var content = editorAce.getValue();
	if (content.trim().length > 0) {

		var blob = new Blob([ "" + editorAce.getValue() + "" ], {
			type : "text/plain;charset=utf-8"
		});
		var filename = "codebeautify.json";
		
		if (converted != "validate") {
			saveAs(blob, filename);
		} else {
			openErrorDialog("Yaml is not converted to JSON / XML ");
		}
	} else {
		openErrorDialog("Sorry Result is Empty");
	}
}



function setToEditor(data) {

	editorAce.setValue(vkbeautify.json(data));
	if (viewname == 'json-to-csv') {
		jsonTocsv();
	} else if (viewname == 'jsontoxml') {
		json2xmlConvert();
	} else if (viewname == 'json-to-yaml') {
		JsonToYAML();
	} else if (viewname == 'jsonvalidate') {
		validateJSON();
	}
}