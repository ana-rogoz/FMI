window.onload=function() {
	var v = document.getElementsByTagName("li");
	alert(v.length);

	var l = document.getElementById("lista");
	var culori = ["red", "orange", "green", "violet", "blue", "indigo"];
	for (var i = 0; i < v.length; i++)
		v[i].style.backgroundColor = culori[Math.floor(Math.random() * 6)];


	var paragraf_a = document.getElementsByClassName("a");
	var v=[];
	for (var i = 0; i < paragraf_a.length; i++) {
		v[i] = paragraf_a[i];
	}
	
	for (var i = 0; i < v.length; i++) {
		v[i].className="b";
	}
}