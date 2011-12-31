var maxIndex = 1;
function toggle(id, button) {
    var theObj = document.getElementById(id);
    var theToggle = document[button];
    var currentImg = theToggle.src;
    var endIndex = currentImg.lastIndexOf('images/');
    var relPath = '';
    if (endIndex > 0) {
        relPath = currentImg.substring(0, endIndex);
    }
    //alert('Rel path: ' + relPath);
    if (theObj.style.display == "none") {
        theToggle.src = relPath + "images/minus.png";
        theObj.style.display = "";      
    } else {
        theToggle.src = relPath + "images/plus.png";
        theObj.style.display = "none";      
    }
}

function toggleTee(id, button) {
    var theObj = document.getElementById(id);
    var theToggle = document[button];
    if (theObj.style.display == "none") {
        theToggle.src = "images/tee-minus.png";
        theObj.style.display = "";		
	} else {
        theToggle.src = "images/tee-plus.png";
		theObj.style.display = "none";		
	}
}

function toggleElbow(id, button) {
	var theObj = document.getElementById(id);
	var theToggle = document[button];
	if (theObj.style.display == "none") {
        theToggle.src = "images/elbow-minus.png";
	    theObj.style.display = "";		
	} else {
        theToggle.src = "images/elbow-plus.png";
		theObj.style.display = "none";		
	}
}

function toggleAnnotation(id, button) {
    //alert("Toggle annotation: " + id + "; " + button);
    var theObj = document.getElementById(id);
    var theToggle = document.getElementById(button);
    if (theObj.style.display == "none") {
        theObj.style.display = "";
        maxIndex = maxIndex+1;
        theToggle.style.zIndex = maxIndex;          
    } else {
        theObj.style.display = "none";   
    }
}
