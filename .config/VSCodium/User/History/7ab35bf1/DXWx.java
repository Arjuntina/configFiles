/* 
 * BigInt.java
 *
 * A class for objects that represent non-negative integers of 
 * up to 20 digits.
 */

public class BigInt  {
    // the maximum number of digits in a BigInt -- and thus the length
    // of the digits array
    private static final int MAX_SIZE = 20;
    
    // the array of digits for this BigInt object
    private int[] digits;
    
    // the number of significant digits in this BigInt object
    private int numSigDigits;

    /*
     * Default, no-argument constructor -- creates a BigInt that 
     * represents the number 0.
     */
    public BigInt() {
        this.digits = new int[MAX_SIZE];
        this.numSigDigits = 1;  // 0 has one sig. digit--the rightmost 0!
    }

    public BigInt(int[] input) {
	if (input == null) {
	    throw new IllegalArgumentException("Input array is null");
	}
	if (input.length > MAX_SIZE) {
	    throw new IllegalArgumentException("Input array is of too large size");
	}
	if (!arrayContainsOnlyValidDigits(input)) {
	    throw new IllegalArgumentException("Input array contains invalid digits");
	}
	digits = new int[20];
	for (int i = 20 - input.length; i < 20; i++) {
	    digits[i] = input[i-20+input.length];
	}
	numSigDigits = calculateNumSigDigits(input);
    }
    

    public BigInt(int input) {
	if (input < 0) {
	    throw new IllegalArgumentException("BigInt class cannot represent negative numbers");
	}
	this.digits = new int[MAX_SIZE];
	int numDigits = numDigitsOfNumber(input);
	for (int i = digits.length-1; i >= digits.length-numDigits ; i--) {
	    digits[i] = input % 10;
	    input = input/10;
	}
	numSigDigits = calculateNumSigDigits(digits);
    }

    public boolean isValidDigit (int intToTest) {
	if (intToTest >= 0 && intToTest <= 9) {
	    return true;
	}
	return false;
    }

    public boolean arrayContainsOnlyValidDigits(int[] input) {
	for (int i = 0; i < input.length; i++) {
	    if (!isValidDigit(input[i])) {
		return false;
	    }
	}
	return true;
    }

    public boolean isZeroArray(int[] input) {
	for (int i = 0; i < input.length; i++) {
	    if (input[i] != 0) {
		return false;
	    }
	}
	return true;
    }

    public int getIndexOfFirstNonZeroDigit(int[] input) {
	for (int i = 0; i < input.length; i++) {
	    if (input[i] != 0) {
		return i;
	    }
	}
	return input.length;
    }

    public int calculateNumSigDigits (int[] input) {
	numSigDigits = 0;
	if (isZeroArray(input)) {
	    return 1;
	}
	return input.length-getIndexOfFirstNonZeroDigit(input);
    }

    public int getNumSigDigits() {
	return numSigDigits;
    }

    public String toString() {
	String toReturn = "";
	for (int i = digits.length-getNumSigDigits(); i < digits.length; i++) {
	    toReturn += digits[i];
	}
	return toReturn;
    }

    public int numDigitsOfNumber(int input) {
	if (input == 0) {
	    return 1;
	}
	int inputCopy = input;
	int numDigits = 0;
	while (inputCopy != 0) {
	    numDigits++;
	    inputCopy = inputCopy/10;
	}
	return numDigits;
    }

    public int takeExponent(int base, int exponent) {
	int result = 1;
	for (int i = 0; i < exponent; i++) {
	    result = result * base;
	}
	return result;
    }

    public int getFirstDigit(int input) {
	return input/takeExponent(10, numDigitsOfNumber(input)-1);
    }

    public int getMostSignificantDigit() {
	return digits[digits.length-getNumSigDigits()];
    }

    public int convertToInt() {
	int result = 0;
	for (int i = getNumSigDigits(); i >= 1; i--) {
	    result += digits[digits.length-i] * takeExponent(10, i-1);
	}
	return result;
    }

    public int compareTo(BigInt other) {
	if (other == null) {
	    throw new IllegalArgumentException("object to compare to is not defined!");
	}
	if (getNumSigDigits() > other.getNumSigDigits()) {
	    return 1;
	}
	else if (getNumSigDigits() < other.getNumSigDigits()) {
	    return -1;
	}
	for (int i = getNumSigDigits(); i >= 1; i--) {
	    if (digits[digits.length - i] > other.getDigits()[digits.length - i]) {
		return 1; 
	    }
	    else if (digits[digits.length - i] < other.getDigits()[digits.length - i]) {
		return -1; 
	    }
	}
	return 0;
    }

    public BigInt add(BigInt other) {
	if (other == null) {
	    throw new IllegalArgumentException("object to be added to is null");
	}
	int carry = 0;
	int[] newBigIntDigits = new int[MAX_SIZE];
	for (int i = 1; i <= digits.length; i++) {
	    int tempSum = carry + digits[digits.length-i] + other.getDigits()[digits.length-i];
	    carry = 0;
	    while (tempSum >= 10) {
		carry += 1;
		tempSum = tempSum - 10;
	    }
	    newBigIntDigits[digits.length-i] = tempSum;
	}
	if (carry != 0) {
	    throw new ArithmeticException();
	}
	return new BigInt(newBigIntDigits);
    }

    public BigInt mul(BigInt other) {
        if (other == null) {
            throw new IllegalArgumentException();
        }
        BigInt result = new BigInt(0);
        for (int i = 0; i < getNumSigDigits(); i++) {
            for (int j = 0; j < other.getNumSigDigits(); j++) {
                int tempResult = digits[digits.length - 1 - i] * other.getDigits()[digits.length - 1 - j];
                if (tempResult != 0 && numDigitsOfNumber(tempResult) + i + j > MAX_SIZE) {
                    throw new ArithmeticException();
                }
                int[] tempArray = new int[MAX_SIZE];
                tempArray[MAX_SIZE - 1 - i - j] = tempResult % 10;
                if (tempResult >= 10) {
                    tempArray[MAX_SIZE - 2 - i - j] = tempResult / 10;
                }
                BigInt toBeAdded = new BigInt(tempArray);
                result = result.add(toBeAdded);
            }
        }
	    return result;
    }

    public int[] getDigits() {
	return digits;
    }
    
    public static void main(String [] args) {
        System.out.println("Unit tests for the BigInt class.");
        System.out.println();

	int[] arr = {0, 0, 0, 5, 7, 4, 3, 1};
	BigInt val = new BigInt(arr);
	System.out.println(val);
        /* 
         * You should uncomment and run each test--one at a time--
         * after you build the corresponding methods of the class.
         */
        
        System.out.println("Test 1: result should be 7");
        int[] a1 = { 1,2,3,4,5,6,7 };
        BigInt b1 = new BigInt(a1);
        System.out.println(b1.getNumSigDigits());
        System.out.println();
        
        System.out.println("Test 2: result should be 1234567");
        b1 = new BigInt(a1);
        System.out.println(b1);
        System.out.println();
        
        System.out.println("Test 3: result should be 0");
        int[] a2 = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
        BigInt b2 = new BigInt(a2);
        System.out.println(b2);
        System.out.println();

        System.out.println("Test 4: should throw an IllegalArgumentException");
        try {
            int[] a3 = { 0,0,0,0,23,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
            BigInt b3 = new BigInt(a3);
            System.out.println("Test failed.");
        } catch (IllegalArgumentException e) {
            System.out.println("Test passed.");
        } catch (Exception e) {
            System.out.println("Test failed: threw wrong type of exception.");
        }
        System.out.println();
	
        System.out.println("Test 5: result should be 1234567");
        b1 = new BigInt(1234567);
        System.out.println(b1);
        System.out.println();

        System.out.println("Test 6: result should be 0");
        b2 = new BigInt(0);
        System.out.println(b2);
        System.out.println();
	
        System.out.println("Test 7: should throw an IllegalArgumentException");
        try {
            BigInt b3 = new BigInt(-4);
            System.out.println("Test failed.");
        } catch (IllegalArgumentException e) {
            System.out.println("Test passed.");
        } catch (Exception e) {
            System.out.println("Test failed: threw wrong type of exception.");
        }
        System.out.println();
	
        System.out.println("Test 8: result should be 0");
        b1 = new BigInt(12375);
        b2 = new BigInt(12375);
        System.out.println(b1.compareTo(b2));
        System.out.println();

        System.out.println("Test 9: result should be -1");
        b2 = new BigInt(12378);
        System.out.println(b1.compareTo(b2));
        System.out.println();

        System.out.println("Test 10: result should be 1");
        System.out.println(b2.compareTo(b1));
        System.out.println();

        System.out.println("Test 11: result should be 0");
        b1 = new BigInt(0);
        b2 = new BigInt(0);
        System.out.println(b1.compareTo(b2));
        System.out.println();
	
        System.out.println("Test 12: result should be\n123456789123456789");
        int[] a4 = { 3,6,1,8,2,7,3,6,0,3,6,1,8,2,7,3,6 };
        int[] a5 = { 8,7,2,7,4,0,5,3,0,8,7,2,7,4,0,5,3 };
        BigInt b4 = new BigInt(a4);
        BigInt b5 = new BigInt(a5);
        BigInt sum = b4.add(b5);
        System.out.println(sum);
        System.out.println();

        System.out.println("Test 13: result should be\n123456789123456789");
        System.out.println(b5.add(b4));
        System.out.println();

        System.out.println("Test 14: result should be\n3141592653598");
        b1 = new BigInt(0);
        int[] a6 = { 3,1,4,1,5,9,2,6,5,3,5,9,8 };
        b2 = new BigInt(a6);
        System.out.println(b1.add(b2));
        System.out.println();

        System.out.println("Test 15: result should be\n10000000000000000000");
        int[] a19 = { 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9 };    // 19 nines!
        b1 = new BigInt(a19);
        b2 = new BigInt(1);
        System.out.println(b1.add(b2));
        System.out.println();

        System.out.println("Test 16: should throw an ArithmeticException");
        int[] a20 = { 9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9 };  // 20 nines!
        try {
            b1 = new BigInt(a20);
            System.out.println(b1.add(b2));
        } catch (ArithmeticException e) {
            System.out.println("Test passed.");
        } catch (Exception e) {
            System.out.println("Test failed: threw wrong type of exception.");
        }
        System.out.println();
	
        System.out.println("Test 17: result should be 5670");
        b1 = new BigInt(135);
        b2 = new BigInt(42);
        BigInt product = b1.mul(b2);
        System.out.println(product);
        System.out.println();
	
        System.out.println("Test 18: result should be\n99999999999999999999");
        b1 = new BigInt(a20);   // 20 nines -- see above
        b2 = new BigInt(1);
        System.out.println(b1.mul(b2));
        System.out.println();

        System.out.println("Test 19: should throw an ArithmeticException");
        try {
            b1 = new BigInt(a20);
            b2 = new BigInt(2);
            System.out.println(b1.mul(b2));
        } catch (ArithmeticException e) {
            System.out.println("Test passed.");
        } catch (Exception e) {
            System.out.println("Test failed: threw wrong type of exception.");
        }
        System.out.println();
        
    }
}
