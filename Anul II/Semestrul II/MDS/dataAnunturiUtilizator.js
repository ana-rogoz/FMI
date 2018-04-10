function initApp() {
	// Se executa la fiecare schimbare de autentificare: log in sau sign out. 
	firebase.auth().onAuthStateChanged(function(user) {
          if (user != null) { // Exista un user logat.
            user.providerData.forEach(function (profile) {
            console.log("Name: " + profile.displayName);
            console.log("Email: " + profile.email);
            });
          }
          else 
            window.location.href = "Homepage.html"; // Daca userul curent este null, merge in Homepage.
      });

  document.getElementById('ButonSignOut').addEventListener('click', ButonSignOut, false);
  document.getElementsByName('Submit')[0].addEventListener('click', ButonSubmit, false);
  colecteazaAnunturi();
}

function ButonSubmit() {

	var currentMessage = document.getElementsByTagName("textarea")[0].value;
	var key = firebase.auth().currentUser.displayName; // Luam cheia utilizatorului curent pentru a cauta in baza de date compania.
	var currentAuthor = "";

	firebase.database().ref('users/' + key).once("value").then(function(snapshot) {
	
		currentAuthor = snapshot.child("companie").val();
		// Calculeaza data. 
		var d = new Date();
		var day = d.getDate();
		var month = d.getMonth();
		var year = d.getFullYear();
		var months = ["Ianuarie", "Februarie", "Martie", "Aprilie", "Mai", "Iunie", "Iulie", "August", "Septembrie", "Octombrie", "Noiembrie", "Decembrie"];

		var currentDate = day + " ";
		
		for (let i = 0; i < 12; i++)
			if (i == month) {
				currentDate = currentDate + months[i];
				break;
			}
		currentDate = currentDate + " " + year;
		// Sfarsit calculeaza data;

		// Nou post in lista de anunturi.
		var Lista = document.getElementById("Lista");
		var div = document.createElement('div');
		var p = document.createElement('p');
		div.innerHTML = currentMessage;
		p.innerHTML = currentDate + " " + currentAuthor;
		Lista.prepend(p);
		Lista.prepend(div);

		// Nou post in baza de date.
		var messagesCount = 0;
		firebase.database().ref('messagesCount').once("value").then(function(snapshot) {
			messagesCount = snapshot.child("count").val() + 1 ;
			// Formam un nou mesaj in baza de date.
			firebase.database().ref('messages/' + messagesCount).set( {
				author: currentAuthor,
				date: currentDate,
				message: currentMessage
			});
			
			// Updatam numarul de anunturi. 
			firebase.database().ref('messagesCount').update({
				count: messagesCount
			});
		});

	});
}

function ButonSignOut() {

  if (firebase.auth().currentUser) 
    firebase.auth().signOut();
}

// Se executa la incarcarea paginii si afiseaza toate anunturile din baza de date.
function colecteazaAnunturi() {

	var sectionLista = document.getElementById("Lista");
	var messagesCount = 0;
	firebase.database().ref('messagesCount').once("value").then(function(snapshot) {
		messagesCount = snapshot.child("count").val();
		for (var index = messagesCount; index >= 1; index --) {
			var author = "";
			var date = "";
			var message = "";
			firebase.database().ref('messages/' + index).once("value").then(function(snapshot) {
				author = snapshot.child("author").val();
				date = snapshot.child("date").val();
				message = snapshot.child("message").val();
				var div = document.createElement("div");
				var p = document.createElement("p");
				div.innerHTML = message;
				p.innerHTML = date + " " + author;

				sectionLista.appendChild(div);
				sectionLista.appendChild(p);
			});

		}

	});

}

window.onload = function() {
	initApp();
}
