package lab6;

public class Profesor extends Persoana{

	/**
	 * @param args
	 */
	private String grad;
	
	
	public Profesor(String nume, String prenume, String grad) {
		super(nume, prenume);
		this.grad = grad;
	}

	// putem redefini compareTo si aici, dar nu neaparat.
		public int compareTo(Persoana p) {
			return 1;
		}
		

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
