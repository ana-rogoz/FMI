package lab6;

public class Persoana implements Comparable<Persoana>{
								 // persoana este comparabila, dar doar cu o alta persoana
	private String nume;
	private String prenume;
	
	
	public Persoana(String nume, String prenume) {
		super();
		this.nume = nume;
		this.prenume = prenume;
	}


	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}


	public int compareTo(Persoana p) {
		int result = nume.compareTo(p.nume);
		if (result == 0)
			return prenume.compareTo(p.prenume);
		return result;
	}

}
