public class Rule {
	private Number number;
	private int weight;

	public Rule(Number number, int weight){
		this.number = number;
		this.weight = weight;
	}

	public Number getNumber(){return number;}
	public int getWeight(){return weight;}
	public String toString(){return "#"+number+"~"+weight;}
}