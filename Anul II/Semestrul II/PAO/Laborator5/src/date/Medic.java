package date;


public class Medic extends Inginer{

	private String specialitate;
	private int garzi;
	public static final int spor_garda = 5;
	
	public String getSpecialitate() {
		return specialitate;
	}

	public void setSpecialitate(String specialitate) {
		this.specialitate = specialitate;
	}

	public int getGarzi() {
		return garzi;
	}

	public void setGarzi(int garzi) {
		this.garzi = garzi;
	}

	
	public float calculeazaSalariu() {
		return getSalariu_db()*factorGarda() + spor_garda*garzi;
	}
	
	public int factorGarda() {
		if (specialitate.equals("Ortopedie"))
			return 1 + getVechime() / 10;
		if (specialitate.equals("Neurologie"))
			return 1 + getVechime() / 8;
		if(specialitate.equals("Nefrologie"))
			return 1 + getVechime() / 12;
		
		return 1 + getVechime() / 11;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
