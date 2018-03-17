package lab4.date;

public class Profesor extends Persoana {

	private String disciplina;
	
	@Override
	public String toString() {
		return super.toString() + "(" + disciplina + ")";
	}

	public String getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(String disciplina) {
		this.disciplina = disciplina;
	}

	public String getElementType() {
		return "Profesor";
	}
	
	public String[] getDataFieldNames() {
		
		String[] s = {"Nume", "Prenume", "Disciplina"};
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
				setDisciplina(arg1);
				break;
			default: 
				break;
		}
		
	}
	
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return getNume();
	}

	@Override
	public String getType() {
		return "Profesor";
	}

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
