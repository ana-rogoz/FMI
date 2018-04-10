function initApp() {
  
  firebase.auth().onAuthStateChanged(function(user) {
          if (user != null) {
            user.providerData.forEach(function (profile) {
            console.log("Name: " + profile.displayName);
            console.log("Email: " + profile.email);
            window.location.href = "AnunturiUtilizator.html";
            });
          }
          else 
            alert("nu e logat");
      });

  document.getElementById('ButonLogin').addEventListener('click', ButonLogin, false);
  document.getElementById('ButonContNou').addEventListener('click', ButonContNou, false);
  document.getElementById('ButonAnunturiVizitator').addEventListener('click', ButonAnunturiVizitator, false);
}

function ButonAnunturiVizitator() {
  
  window.location.href = "AnunturiVizitator.html";
}

function ButonContNou() {
	
  window.location.href = "ContNou.html";
}

function ButonLogin() {

  if (!firebase.auth().currentUser) {
    var email = document.getElementsByName("mail")[0].value;
    var password = document.getElementsByName("parola")[0].value;
    if (email.length < 4) {
      alert('Please enter an email address.');
      return;
    }
    if (password.length < 4) {
      alert('Please enter a password.');
      return;
    }
    
    firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
      var errorCode = error.code;
      var errorMessage = error.message;
      if (errorCode === 'auth/wrong-password') {
        alert('Wrong password.');
      } 
      else {
        alert(errorMessage);
      }
    });
  }
}

window.onload = function() {
  initApp();
}
