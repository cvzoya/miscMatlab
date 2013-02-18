/** External Links **/

function externalLinks() { if (!document.getElementsByTagName) return; var anchors = document.getElementsByTagName("a"); for (var i=0; i<anchors.length; i++) { var anchor = anchors[i]; if (anchor.getAttribute("href") && anchor.getAttribute("rel") == "external") anchor.target = "_blank"; } } window.onload = externalLinks;

/** Responsive Menu **/

$(function() {
	$("<select />").appendTo(".menu");
	$("<option />", { "selected": "selected", "value" : "", "text" : "Go to..." }).appendTo(".menu select");
	$("#headerright a").each(function() { var el = $(this); $("<option />", { "value" : el.attr("href"), "text" : el.text() }).appendTo(".menu select"); });
	$("#headerright select").change(function() { window.location = $(this).find("option:selected").val(); });
});

