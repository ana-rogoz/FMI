package tema4lab6;


// Primele 4 unitati
public class UnitatiTip1 extends CaracteristiciPrincipale implements Stocare{

	private int spatiuStocare;
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public void load(int x) {
		// TODO Auto-generated method stub
		spatiuStocare += x;
	}


	public void unload(int x) {
		// TODO Auto-generated method stub
		spatiuStocare -= x;
	}

}
