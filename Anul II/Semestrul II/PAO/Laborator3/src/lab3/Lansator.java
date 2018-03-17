package lab3;

import lab3.jucarii.Carte;
import lab3.jucarii.Student;
import lab3.numarator.ClassCounter;

public class Lansator {

	static {
		System.out.println("static1");
	} // se executa cand clasa e incarcata de class loader
	private static int numar = 5; // se aloca cand clasa e incarcata de class 
								  // loader aka cand se porneste programul.
	static {
		System.out.println("static2");
	} // la fel ca primul static
	// se executa de sus in jos campurile statice
	
	
	{
		System.out.println("block1");
	}
	private int altNumar = 6;
	{
		System.out.println("block2");
	}
	
	
	public Lansator() {
		System.out.println("constructor");
	}
	
	public static void main(String[] args) {

		// campurile statice se executa doar cand se incarca clasa. 
		Lansator obiect = new Lansator();
		// la crearea unui obiect nou, se executa instructiunile nestatice. 
		// constructorul se executa dupa ce s-au executat toate blocurile de initializare.
		
		/* Cum accesam un camp static dinafara clasei? 
		 * 1) Instanta.metoda/campStatic
		 * 2) numeleClasei.Campul/MetodaStatica
		 */
		// nu exista this pentru campurile statice. 
	
		new Student();
		new Student();
		new Carte();
	
		System.out.println(ClassCounter.getInstance().getNumar("minge"));
		System.out.println(new Student()); // apare hashcode-ul clasei respective.
		// in java nu exista constructor de copiere. 
		
	}

}
