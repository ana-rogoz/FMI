package lab4.date;

import com.neuralsoft.pao.ppldatabase.objects.DatabaseElement;

public abstract class Persoana extends DatabaseElement{

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

	@Override
	public String toString() {
		return nume + " " + prenume;
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
