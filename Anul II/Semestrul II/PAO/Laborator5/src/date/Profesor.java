package date;


public class Profesor extends Angajat{

	private String disciplina;
	private int grad;
	public static final int spor_profesor = 10;
	public static final int spor_grad = 20;
	
	public String getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(String disciplina) {
		this.disciplina = disciplina;
	}


	public int getGrad() {
		return grad;
	}

	public void setGrad(int grad) {
		this.grad = grad;
	}

	public float calculeazaSalariu() {
		return getSalariu_db() + spor_profesor*getVechime() + spor_grad*grad;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
}
