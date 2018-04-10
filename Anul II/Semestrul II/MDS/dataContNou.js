function initApp() {

  // Se executa la fiecare log in sau sign out.
  firebase.auth().onAuthStateChanged(function(user) {
    
    if (user != null) { // Un user este logat.
      var lastName = document.getElementsByName("nume")[0].value;
      var firstName = document.getElementsByName("prenume")[0].value;

      if (lastName != "" && firstName != "") {
        console.log(lastName + firstName);
        user.updateProfile({
          displayName: firstName + lastName
        })
        .then(function() {
          console.log("update name");
          user.providerData.forEach(function (profile) {
            console.log("  Name: " + profile.displayName);
            console.log("  Email: " + profile.email);
            window.location.href = "AnunturiUtilizator.html";
          });
        })
        .catch(function(error) {
          console.log(error);
        });
      }

      alert("e logat");
    }
    else 
      alert("nu e logat");
  });

  document.getElementById("ButonContNou").addEventListener("click", ButonContNou);
}

function ButonContNou() {

  // Aduna datele de la intrare. 
  var email = document.getElementsByName("mail")[0].value;
  var password = document.getElementsByName("parola")[0].value;
  var phone = document.getElementsByName("telefon")[0].value;
  var nume = document.getElementsByName("nume")[0].value;
  var prenume = document.getElementsByName("prenume")[0].value;
  var companie = document.getElementsByName("companie")[0].value;

  if (email.length < 4) {
        alert('Please enter an email address.');
        return;
  }
  if (password.length < 4) {
        alert('Please enter a password.');
        return;
  }

  // Creeaza un nou user. 
  firebase.auth().createUserWithEmailAndPassword(email, password).catch(function(error) {
        var errorCode = error.code;
        var errorMessage = error.message;
        if (errorCode == 'auth/weak-password') {
          alert('The password is too weak.');
        } else {
          alert(errorMessage);
        }
        console.log(error);
      });
  
  // Creeaza o noua intrare in baza de date pentru user avand toate campurile de la intrare.
  firebase.database().ref('users/' + prenume + nume).set({
    email: email,
    phone: phone,
    nume: nume,
    prenume: prenume,
    companie: companie
  });
}

window.onload = function() {
  
  initApp();
}
