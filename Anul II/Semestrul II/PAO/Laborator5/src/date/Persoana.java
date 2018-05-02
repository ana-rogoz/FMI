package date;

public abstract class Persoana { // O clasa abstracta nu poate fi instantiata.

	private String nume;
	private String prenume;
	
	public String getNume() {
		return nume;
	}
	public void setNume(String nume) {
		this.nume = nume;
	}
	public String getPrenume() {
		return prenume;
	}
	public void setPrenume(String prenume) {
		this.prenume = prenume;
	}
	
	public abstract float calculeazaSalariu(); 
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
