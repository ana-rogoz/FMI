package date;


public class Inginer extends Angajat{


	public float calculeazaSalariu() {
		return getSalariu_db()*(1 + getVechime() / 16);
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
