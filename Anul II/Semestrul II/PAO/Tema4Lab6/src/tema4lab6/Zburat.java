package tema4lab6;

public interface Zburat {
	default void takeoff() {
		System.out.println("decolat");
	}
	default void land() {
		System.out.println("aterizat");
	}
}
