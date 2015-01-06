import java.util.Stack;
public class Permutation{
	private int[] indices;

	public Permutation(int size){
		indices = new int[size];
		for(int i = 0; i < size; i++){indices[i] = -1;}
	}

	public Permutation(int size, int init){
		this(size);
		this.append(init);
	}

	public void append(int value){
		int i = indices.length-1;
		while(i >= 0 && indices[i] == -1){i--;}
		indices[i+1] = value;
	}

	public int[] getIndices(){
		return indices;
	}

	private static Stack<Permutation> generate(int max, int size, int max_size){
		Stack<Permutation> permutations = new Stack<Permutation>();
		//Cas terminal/trivial des permutations de taille 1
		if(size == 1){
			for(int i = 0; i < max; i++){
				permutations.push(new Permutation(max_size, i));
			} 
		}else{
			//Sinon, on retire des elements jusqu'à atteindre la taille limite
			//Et on concatène avec les permutations du vecteur
			while(max >= size){
				max--;
				Stack<Permutation> inf_perm = generate(max, size-1, max_size);
				for(Permutation perm : inf_perm){
					perm.append(max);
				}
				permutations.addAll(inf_perm);
			}
		}
		return permutations;
	}

	public static Stack<Permutation> generate(int max, int size){
		return generate(max, size, size);
	}

	public String toString(){
		String str = "<";
		for(int i = 0; i < indices.length; i++){str += indices[i]+",";}
		return str.substring(0, str.length()-1)+">";
	}

}