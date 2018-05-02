package lab6;

public class Student extends Persoana{

	/**
	 * @param args
	 */
	private int an;
	
	public Student(String nume, String prenume, int an) {
		super(nume, prenume);
		this.an = an;
	}

	// putem redefini compareTo si aici, dar nu neaparat.
	public int compareTo(Persoana p) {
		if (p instanceof Profesor)
			return 1; // Profesor e inaintea lui this student.
		int result;
		if (p instanceof Student) {
				 result = super.compareTo(p);
				 if (result == 0)
					 return an - ((Student)(p)).an; // returneaza pozitiv, deci p e inaintea lui this
				 else 
					 return result;
		}
		else
			//return super.compareTo(p); // p este persoana
			return -1; // this student e mereu inaintea unei persoane obisnuite
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
