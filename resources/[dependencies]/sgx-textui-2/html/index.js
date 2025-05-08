window.addEventListener('message', function(event) {
    ed = event.data;
	if (ed.action === "textUI") {
		if (ed.show) {
			document.getElementById("TUKeyDivInside").innerHTML=`<span>${ed.key}</span>`;
			document.getElementById("textUIH4").innerHTML=ed.text;
			$("#textUI").show().css({bottom: "-10%", position:'absolute', display:'flex'}).animate({bottom: "4%"}, 800, function() {});
		} else {
			$("#textUI").show().css({bottom: "4%", position:'absolute', display:'flex'}).animate({bottom: "-10%"}, 800, function() {});
		}
    } else if (ed.action === "textUIUpdate") {
        document.getElementById("TUKeyDivInside").innerHTML=`<span>${ed.key}</span>`;
        document.getElementById("textUIH4").innerHTML=ed.text;
    }
})