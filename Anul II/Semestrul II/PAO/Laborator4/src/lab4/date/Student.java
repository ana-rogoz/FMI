package lab4.date;

public class Student extends Persoana{

	private int an;
	
	@Override
	public String toString() {
		return super.toString() + "(" + an + ")";
	}

	public int getAn() {
		return an;
	}

	public void setAn(int an) {
		this.an = an;
	}

	public String getElementType() {
		return "Student";
	}
	
	public String[] getDataFieldNames() {
		
		String[] s = {"Nume", "Prenume", "An"};
		return s;
	}
	
	public void setFieldAt(int arg0, String arg1) {
		switch(arg0) {
			case 0: 
				setNume(arg1);
				break;
			case 1: 
				setPrenume(arg1);
				break;
			case 2:
				setAn(Integer.parseInt(arg1));
				break;
			default: 
				break;
		}
		
	}
	
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return getPrenume();
	}

	@Override
	public String getType() {
		
		return "Student";
	}

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
