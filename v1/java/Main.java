import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class Main {

    private static int a005132_internal(int n) {
        if (n == 0) return 0;

        boolean includes = false;
        int itemtotest = a005132_internal(n-1)-n;
        for (int k = 0; k < n; k++) {
            if (itemtotest == a005132_internal(k)) {
                includes = true;
                break;
            }
        }

        if ((itemtotest < 0) || includes) {
            return a005132_internal(n-1) + n;
        } else {
            return itemtotest;
        }
    }

    private static int[] a005132(int ntop) {
        int[] rval = new int[ntop];
        for (int i = 1; i <= ntop; i++) {
            rval[i-1] = a005132_internal(i);
        }
        return rval;
    }

    private static ArrayList<Integer> a002113(int n) {
        ArrayList<Integer> output = new ArrayList<Integer>();
        for (int i = 0; i < n+1; i++) {
            int reverse = 0;
            for (int j = i; j > 0; j /= 10) 
                reverse = reverse*10 + j%10;
            if (reverse == i) output.add(i);
        }
        return output;
    }

    private static ArrayList<Integer> a000040(int n) {
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

    private static String a005150_internal(int n, String seq) {
        if (n > 1) {
            StringBuilder output = new StringBuilder();
            char prev = '-';
            char len = 49;
            for (char c : seq.toCharArray()) {
                if (c == prev) {
                    len++;
                } else {
                    if (prev != '-') {
                        output.append(len);
                        output.append(prev);
                        len = 49;
                        prev = c;
                    } else {
                        prev = c;
                    }
                }
            }
            output.append(len);
            output.append(prev);
            return a005150_internal(n-1, output.toString());
        }
        return seq;
    }

    private static String[] a005150(int n) {
        String[] output = new String[n];
        for (int i = 1; i <= n; i++) {
            output[i-1] = a005150_internal(i, "1");
        }
        return output;
    }

    private static int a000045_internal(int n) {
        if (n > 1) return a000045_internal(n-1) + a000045_internal(n-2);
        return 1;
    }

    private static int[] a000045(int n) {
        int[] output = new int[n];
        for (int i = 1; i <= n; i++) {
            output[i-1] = a000045_internal(i);
        }
        return output;
    }

    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(System.in);
        int ip = Integer.parseInt(scanner.nextLine());
        scanner.close();

        if ((ip & ( 1 << 0 )) >> 0 == 1) {
            if (!Arrays.equals(a005132(13), new int[]{1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23})) throw new Exception("a005132 failed");
        }
            
        if ((ip & ( 1 << 1 )) >> 1 == 1) {
            if (a002113(10000000).size() != 10999) throw new Exception("a002113 failed!");
        }

        if ((ip & ( 1 << 2 )) >> 2 == 1) {
            if (a000040(10000000).size() != 664579) throw new Exception("a000040 failed!");
        }

        if ((ip & ( 1 << 3 )) >> 3 == 1) {
            String[] response = a005150(45);
            int[] a4a = new int[]{1, 2, 2, 4, 6, 6, 8, 10, 14, 20, 26, 34, 46, 62, 78, 102, 134, 176, 226, 302, 408, 528, 678, 904, 1182, 1540, 2012, 2606, 3410, 4462, 5808, 7586, 9898, 12884, 16774, 21890, 28528, 37158, 48410, 63138, 82350, 107312, 139984, 182376, 237746};
            for (int i = 0; i < response.length; i++) if (response[i].length() != a4a[i]) throw new Exception("a005150 failed!");
        }

        if ((ip & ( 1 << 4 )) >> 4 == 1) {
            if (!Arrays.equals(a000045(35), new int[]{1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352})) throw new Exception("a000045 failed");
        }
    }
}
