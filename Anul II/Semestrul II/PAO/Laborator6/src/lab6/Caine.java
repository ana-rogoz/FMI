package lab6;

public class Caine extends Animal {

	private String rasa;
	private Disciplina caine;
	
	public Caine() {
		caine = Disciplina.BazeDeDate;
	}

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public void vinde() {
		// TODO Auto-generated method stub
		
	}

}


/* Animal a = new Caine(); avem voie
   Produs b = new Caine(); avem voie
   a = b; nu avem voie
   b = a; avem voie
   a.vinde(); avem voie
   b.vinde(); avem voie
   Caine c = b; nu avem voie, dar putem face cast
   Pisica p = b; nu avem voie; daca facem cast nu avem eroare la compilare, dar avem la runtime 
   if (b instanceof Produs) {
   
   }
 */