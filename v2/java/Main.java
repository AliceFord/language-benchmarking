import java.util.ArrayList;
import java.util.Arrays;

public class Main {

    private static ArrayList<Integer> primeSieve(int n) {
        boolean[] prime = new boolean[n+1];
        Arrays.fill(prime, true);
        int p = 2;
        while (p * p <= n) {
            if (prime[p]) {
                for (int i = p * 2; i < n+1; i += p) {
                    prime[i] = false;
                }
            }
            p++;
        }
        prime[0] = false;
        prime[1] = false;

        ArrayList<Integer> output = new ArrayList<Integer>();

        for (int i = 0; i < n+1; i++) {
            if (prime[i]) {
                output.add(i);
            }
        }
        return output;
    }

    
    public static void main(String[] args) throws Exception {
        System.out.println("s");
        if (primeSieve(100000000).size() != 5761455) throw new Exception("Prime sieve failed!");
        System.out.println("f");
    }
}
