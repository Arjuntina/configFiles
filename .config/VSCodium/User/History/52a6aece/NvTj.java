public class ScopePuzzle {
    public static void myMethod(int e) {
        int i;
        for (i = 0; i < 10; i++) {
            //System.out.println(________);        // first println

            int a = 5;
            for (int j = 0; j < 3; j++) {
                int b = 0;
                //System.out.println(________);    // second println
            }
            System.out.println(a);        // third println
        }

        int y = 3;
        //System.out.println(________);            // fourth println
    }

    public static void main(String[] args) {
        int c = 0;

        //System.out.println(________);            // fifth println

        int d = 1;
        myMethod(c);

        //System.out.println(________);            // sixth println
    }
}
