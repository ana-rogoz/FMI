package tema4lab6;

public class CaracteristiciPrincipale {

	private int viata = 600;
	private int energie = 1600;
	
	private void move(int x, int y) {
		//schimba pozitia
		energie = energie - (x-y);
	}
	
	private void takeDamage(int damage) {
		viata = viata - damage;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
