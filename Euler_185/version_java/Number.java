public class Number{
	private int[] digits;
	private int size;

	public Number(int size){
		digits = new int[size];
		this.size = size;
	}

	public Number(String number){
		size = number.length();
		digits = new int[size];
		for(int i = 0; i < size; i++){
			digits[i] = Character.getNumericValue(number.charAt(i));
		}
	}

	public Number(int[] digits){
		size = digits.length;
		this.digits = digits;
	}

	public int digitAt(int indice){
		return digits[indice];
	}

	public String toString(){
		String str = "";
		for(int i = 0; i < size; i++){
			str+= (digitAt(i) == -1) ? "_" : String.valueOf(digitAt(i));
		}
		return str;
	}

	public int getSize(){return size;}
}