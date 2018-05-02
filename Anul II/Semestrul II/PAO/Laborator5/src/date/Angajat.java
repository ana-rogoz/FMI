package date;

public abstract class Angajat extends Persoana{ // pentru ca e abstracta, nu trebuie implementate
												// toate metodele abstracte din parinte.

	private int vechime;
	private float salariu_db;

	public int getVechime() {
		return vechime;
	}

	public void setVechime(int vechime) {
		this.vechime = vechime;
	}

	public float getSalariu_db() {
		return salariu_db;
	}

	public void setSalariu_db(float salariu_db) {
		this.salariu_db = salariu_db;
	}
	
	public abstract float calculeazaSalariu(); // poate sa nu existe.
	
}
