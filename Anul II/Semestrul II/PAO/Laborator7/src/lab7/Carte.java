package lab7;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class Carte implements Serializable {

	public Coperta getCoperta() {
		return coperta;
	}

	public void setCoperta(Coperta coperta) {
		this.coperta = coperta;
	}

	public Pagina[] getPagini() {
		return pagini;
	}

	public void setPagini(Pagina[] pagini) {
		this.pagini = pagini;
	}

	public String getTitlu() {
		return titlu;
	}

	public void setTitlu(String titlu) {
		this.titlu = titlu;
	}

	private String titlu;
	private Coperta coperta;
	private Pagina[] pagini;
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	private void writeObject(ObjectOutputStream s) throws IOException {
		setTitlu("abc" + getTitlu());
		s.defaultWriteObject();
	}

}
