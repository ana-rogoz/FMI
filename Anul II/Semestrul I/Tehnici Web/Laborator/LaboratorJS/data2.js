window.onload=function() {
	/*var v = document.getElementsByTagName("li");
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
	}*/
	
	/*var v1 = document.querySelector("li");
	var v2 = v1.parentElement;
	alert(v2);
	v1.onclick = function() {alert("ati selectat li");}
	v2.innerHTML +="<li> Element 4</li>";
	v2.appendChild(v1);
	
	
	var v3 = document.querySelectorAll("li");
	var v4 = v3[2];
	v2.removeChild(v4);
	v3[0].className = "a";
	v3[0].classList.add("b");
	
	var v5 = document.body; //body
	var v6 = document.querySelector("li"); //li
 	var v7 = v6.parentElement; //ol
	
	v7.addEventListener("click", function() {alert("ati selectat ol")}, false);
	v6.onclick = function() {alert("ati selectat li")}
	v5.addEventListener("click", function() {alert("ati selectat body")}, true);*/
	var element_lista = document.querySelector("li");
	var lista = document.querySelector("ol");
	element_lista.onclick = myFunction2;
	lista.onclick = myFunction2;
		
}


	/*var myVar = setInterval(myFunction, 1000);*/
	var contor = 0;

	function myFunction() {
		if(contor == 20)
			clearInterval(myVar);
		else {
			var paragraful = document.querySelector("p");
			paragraful.innerHTML = contor;
			contor ++;
		}   	
	}


	function myFunction2(ev) {

			alert(ev.target);
			alert(ev.currentTarget);
	}
		/*var dimensiune = elemente.length;
		for(let i = 0; i < dimensiune; i++)
			setTimeout(function(x){elemente[x].innerHTML = x;}, 1000, i);
			
	*/
	

	
